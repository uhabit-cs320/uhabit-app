#!/bin/bash

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Debug mode flag
DEBUG=false
if [[ "$1" == "--debug" ]]; then
    DEBUG=true
fi

# Function to print debug messages
debug_log() {
    if [[ "$DEBUG" == true ]]; then
        echo -e "${BOLD}[DEBUG] $1${NC}"
    fi
}

# Function to print status messages
print_status() {
    echo -e "${BOLD}$1${NC}"
}

# Function to print success messages
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

# Function to print error messages
print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Function to print warning messages
print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if a port is in use
port_in_use() {
    lsof -i :"$1" >/dev/null 2>&1
}

# Function to check if backend is healthy
check_backend_health() {
    local response
    response=$(curl -s http://localhost:8081/health 2>&1)
    if [[ $? -eq 0 && "$response" == *"OK!"* ]]; then
        return 0
    fi
    return 1
}

print_status "🚀 Starting UHabit Development Environment Setup"
echo "=================================================="

# Check operating system
debug_log "Checking operating system..."
OS="$(uname -s)"
case "${OS}" in
    Linux*)     OS='Linux';;
    Darwin*)    OS='Mac';;
    MINGW*)     OS='Windows';;
    *)          OS='Unknown';;
esac
debug_log "Operating System: $OS"

# Check for Flutter
print_status "\nChecking Flutter installation..."
if ! command_exists flutter; then
    print_error "Flutter is not installed"
    print_status "Please install Flutter from: https://flutter.dev/docs/get-started/install"
    exit 1
else
    FLUTTER_VERSION=$(flutter --version | head -n1 | awk '{print $2}')
    print_success "Flutter version: $FLUTTER_VERSION"
    
    if [[ "$DEBUG" == true ]]; then
        print_status "\nRunning Flutter doctor..."
        flutter doctor -v
    fi
fi

# Check for Firebase CLI
print_status "\nChecking Firebase CLI..."
if ! command_exists firebase; then
    print_warning "Firebase CLI not found. Installing..."
    if [[ "$OS" == "Windows" ]]; then
        curl -sL https://firebase.tools | bash
    else
        curl -sL https://firebase.tools | bash
    fi
    
    if ! command_exists firebase; then
        print_error "Failed to install Firebase CLI"
        exit 1
    fi
fi
FIREBASE_VERSION=$(firebase --version)
print_success "Firebase CLI version: $FIREBASE_VERSION"

# Check if Firebase is logged in
debug_log "Checking Firebase authentication..."
if ! firebase projects:list >/dev/null 2>&1; then
    print_warning "Not logged into Firebase. Please login:"
    firebase login
fi

# Check backend server with retries
print_status "\nChecking backend server..."
MAX_RETRIES=3
RETRY_COUNT=0
BACKEND_HEALTHY=false

while [[ $RETRY_COUNT -lt $MAX_RETRIES ]]; do
    if check_backend_health; then
        BACKEND_HEALTHY=true
        break
    fi
    RETRY_COUNT=$((RETRY_COUNT + 1))
    if [[ $RETRY_COUNT -lt $MAX_RETRIES ]]; then
        print_warning "Backend check failed, retrying ($RETRY_COUNT/$MAX_RETRIES)..."
        sleep 2
    fi
done

if [[ "$BACKEND_HEALTHY" == false ]]; then
    print_error "Backend server is not running or not healthy"
    print_status "Please ensure the backend server is running at http://localhost:8081"
    print_status "Start the backend server with:"
    print_status "cd backend && ./gradlew bootRun"
    exit 1
else
    print_success "Backend server is running and healthy"
fi

# Check Firebase emulator
print_status "\nChecking Firebase emulator..."
EMULATOR_PORT=9099
if ! port_in_use $EMULATOR_PORT; then
    print_warning "Firebase emulator is not running on port $EMULATOR_PORT"
    print_status "Starting Firebase emulator..."
    firebase emulators:start --only auth &
    sleep 5
    if ! port_in_use $EMULATOR_PORT; then
        print_error "Failed to start Firebase emulator"
    else
        print_success "Firebase emulator started successfully"
    fi
else
    print_success "Firebase emulator is running on port $EMULATOR_PORT"
fi

# Check Flutter dependencies
print_status "\nChecking Flutter dependencies..."
flutter pub get > /dev/null 2>&1
if [ $? -ne 0 ]; then
    print_error "Failed to get Flutter dependencies"
    exit 1
fi
print_success "Flutter dependencies are up to date"

# Check for required environment variables
debug_log "Checking environment variables..."
required_vars=("FIREBASE_PROJECT_ID" "FIREBASE_API_KEY")
missing_vars=()

for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        missing_vars+=("$var")
    fi
done

if [ ${#missing_vars[@]} -ne 0 ]; then
    print_warning "Missing environment variables: ${missing_vars[*]}"
    print_status "Please set them in your .env file"
else
    debug_log "All required environment variables are set"
fi

# Final status
echo -e "\n=================================================="
print_status "Environment Check Summary:"
echo "- Operating System: $OS"
echo "- Flutter: $FLUTTER_VERSION"
echo "- Firebase CLI: $FIREBASE_VERSION"
echo "- Backend Server: $(check_backend_health && echo "Healthy" || echo "Not Running")"
echo "- Firebase Emulator: $(port_in_use $EMULATOR_PORT && echo "Running" || echo "Not Running")"
echo "=================================================="

# Check if there were any warnings or errors
if [[ -n $(grep -E "❌|⚠️" <(echo "$output")) ]]; then
    print_warning "Setup completed with warnings/errors. Please review the output above."
else
    print_success "🎉 All checks passed! You're ready to start developing!"
fi

# Instructions for next steps
print_status "\nNext Steps:"
echo "1. Start the backend server (if not running)"
echo "2. Start the Firebase emulator (if not running)"
echo "3. Run the app: flutter run"
echo ""