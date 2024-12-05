# UHabit - Habit Tracking Made Social

UHabit is a modern, social-focused habit tracking application built with Flutter. It helps users build and maintain habits while connecting with friends for mutual encouragement and accountability.

![UHabit App Screenshot] (Add screenshot here)

## Features

- 📱 Daily habit tracking with beautiful animations
- 🔥 Snapchat-style streak tracking
- 👥 Social feed to see friends' progress
- 📊 Visual progress tracking
- 🤝 Follow friends' habits
- 📅 Calendar view of habit completion
- 🌟 Achievement system

## Getting Started

### Prerequisites

- 🚀 Flutter SDK (latest stable version) - [Download Flutter](https://flutter.dev/docs/get-started/install)
- 💻 Dart SDK (included with Flutter)
- 🛠️ Android Studio or VS Code with Flutter extensions - [Download Android Studio](https://developer.android.com/studio)
- 📱 iOS Simulator (for Mac users) or Android Emulator

### Platform-specific Setup Guide

<details>
<summary>🪟 Windows</summary>

1. Download and install Git for Windows from [git-scm.com](https://git-scm.com/download/win)
2. Download and install Flutter SDK from the [Flutter website](https://flutter.dev/docs/get-started/install/windows)
3. Install Android Studio from [JetBrains](https://developer.android.com/studio)
4. Add Flutter to your PATH environment variable
5. Run `flutter doctor` to verify installation

**Required Tools:**
- Windows 10 or later (64-bit)
- Git for Windows
- Android Studio
- VS Code (optional but recommended)
</details>

<details>
<summary>🍎 macOS</summary>

1. Install Xcode from the Mac App Store
2. Download and install Flutter SDK from the [Flutter website](https://flutter.dev/docs/get-started/install/macos)
3. Install Android Studio from [JetBrains](https://developer.android.com/studio)
4. Run `xcode-select --install` to install command-line tools
5. Run `flutter doctor` to verify installation

**Required Tools:**
- macOS (latest version recommended)
- Xcode
- Android Studio
- CocoaPods (`sudo gem install cocoapods`)
</details>

<details>
<summary>🐧 Linux</summary>

1. Install required dependencies:
```bash
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
```
2. Download and install Flutter SDK from the [Flutter website](https://flutter.dev/docs/get-started/install/linux)
3. Install Android Studio from [JetBrains](https://developer.android.com/studio)
4. Add Flutter to your PATH in `~/.bashrc` or `~/.zshrc`
5. Run `flutter doctor` to verify installation

**Required Tools:**
- A supported Linux distribution (Ubuntu 20.04 or later recommended)
- Android Studio
- VS Code (optional but recommended)
</details>

### Installation

1. Clone the repository:
```bash
git clone https://github.com/uhabit-cs320/uhabit-app
```

2. Navigate to the project directory:
```bash
cd UHabit
```

3. Install the emulator:
```bash
./preflight.sh
firebase emulators:start
flutter emulators --launch mobile
```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── models/          # Data models
├── services/        # API and business logic
├── screens/         # UI screens
└── widgets/         # Reusable widgets
```

## Core Features Implementation


## Usage

### Adding a New Habit

1. Tap the + button in the bottom right corner
2. Enter the habit name
3. Choose an icon (optional)
4. Set visibility (public/private)

### Tracking Habits

- Tap the circle next to a habit to mark it as complete for the day
- View your current streak in the streaks section
- Check your weekly progress in the calendar view

### Social Features

- Follow friends' habits by visiting their profile
- Give "cheers" to friends' achievements
- Share your own achievements on the social feed
