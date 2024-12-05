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

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio or VS Code with Flutter extensions
- iOS Simulator (for Mac users) or Android Emulator

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/UHabit.git
```

2. Navigate to the project directory:
```bash
cd UHabit
```

3. Install dependencies:
```bash
flutter pub get
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

### Habit Tracking

The app uses an animated list to display daily habits with smooth transitions:

```dart:lib/HomeScreen.dart
startLine: 216
endLine: 315
```

### Streak System

Streaks are calculated and displayed with engaging visuals:

```dart:lib/HomeScreen.dart
startLine: 317
endLine: 389
```

### Social Feed

The social feed shows friends' activities and achievements:

```dart:lib/HomeScreen.dart
startLine: 391
endLine: 467
```

## API Integration

The app communicates with a backend server through the HabitService:

```dart:lib/services/habit_service.dart
startLine: 5
endLine: 40
```

## Models

### Habit Model
```dart:lib/models/habit.dart
startLine: 1
endLine: 29
```

### HabitRecord Model
```dart:lib/models/habit_record.dart
startLine: 1
endLine: 41
```

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

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter team for the amazing framework
- [List any other libraries or resources used]

## Screenshots

[Add screenshots of different screens here]

## Contact

Your Name - [@yourtwitter](https://twitter.com/yourtwitter)
Project Link: [https://github.com/yourusername/UHabit](https://github.com/yourusername/UHabit)
```

This README provides comprehensive documentation for the UHabit project, including setup instructions, feature explanations, and code references. You should add actual screenshots, update the social media links, and modify any placeholder content before publishing.
