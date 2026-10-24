# TaskBuddy

A simple task manager app built with Flutter. Add tasks with due dates, search through them, and switch between light and dark mode.

This is my first complete Flutter project, built while learning Flutter and Dart.

## Demo

<!-- Add a screenshot or GIF here. Put the image in a "screenshots" folder, then use: -->
<!-- ![Home screen](screenshots/home.png) -->

## Features

- Time-based greeting (Good Morning, Afternoon, Evening, Night)
- Add tasks with a title and a due date
- Colorful task cards
- Search tasks on a full search page
- Dark mode toggle for the whole app
- Clear all tasks from the profile page
- About dialog with app info

## Built With

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)

## What I Learned

- Managing state with `setState`
- Building a search page with `SearchDelegate`
- Switching themes across the whole app with `ValueNotifier` and `ThemeMode`
- Organizing screens and navigating between them

## Getting Started

Make sure you have [Flutter installed](https://docs.flutter.dev/get-started/install), then run:

```bash
git clone https://github.com/jmawya/Task_Buddy.git
cd Task_Buddy
flutter pub get
flutter run
```

## Project Structure

```
lib/
├── main.dart                  # App entry point and theme setup
└── Screens/
    ├── main_home_screen.dart
    ├── home_screen.dart       # Task list and search
    ├── add_task_screen.dart   # Add a new task
    └── profile.dart           # Dark mode, clear tasks, about
```

## Future Improvements

- Save tasks so they stay after closing the app
- Edit and delete single tasks
- Mark tasks as completed
- Task reminders and notifications

## Author

Jannatul Mawya
- GitHub: [@jmawya](https://github.com/jmawya)
- LinkedIn: https://www.linkedin.com/in/jannatul-mawya-418b3230b/
