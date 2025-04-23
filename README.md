# HabitTune

A comprehensive habit tracking application that adapts to user needs through thoughtful design, leverages psychological principles for effective habit formation, and motivates users through a combination of personalized gamification, meaningful life integration, and optional social connections.

## Features

### Core Features
- **Flexible Habit Tracking System**: Multiple frequency options, different goal types, customizable reminders
- **Context-Aware Tracking**: Reduces friction in habit tracking by adapting to user context
- **Habit Organization**: Smart habit groups, calendar integration, habit conflict detection
- **Progress Visualization**: Clear daily view, streak calendars, progress charts
- **Psychological Framework Integration**: Evidence-based psychological principles to improve habit formation

### Experience Features
- **Gamification System**: Points, achievements, streaks, and milestone celebrations
- **Progressive Mastery**: Mastery levels, skill trees, and challenges
- **Personalization**: Adaptive interface, personalized insights, and customized motivation
- **Statistics & Insights**: Visual statistics, pattern recognition, correlation analysis
- **Narrative Journey**: Progress visualization as a personal story or journey

## Technical Implementation

- **Architecture**: Clean architecture with separation of concerns (presentation, domain, data)
- **State Management**: BLoC pattern for predictable state management
- **Local Storage**: Hive for efficient local data persistence
- **UI Implementation**: Material Design with custom animations and responsive layouts
- **Performance Optimization**: Efficient widget rebuilds, list rendering, and memory usage
- **Accessibility**: Screen reader support, high contrast mode, accessible tap targets

## Getting Started

### Prerequisites
- Flutter SDK (2.17.0 or higher)
- Dart SDK (2.17.0 or higher)
- Android Studio / VS Code with Flutter extensions

### Installation
1. Clone the repository
   ```
   git clone https://github.com/yourusername/habitune.git
   ```
2. Navigate to the project directory
   ```
   cd habitune
   ```
3. Install dependencies
   ```
   flutter pub get
   ```
4. Run the app
   ```
   flutter run
   ```

## Testing
- Unit tests for business logic
- Widget tests for UI components
- Integration tests for user flows

## Project Structure
```
lib/
├── core/
│   ├── constants/
│   ├── theme/
│   └── utils/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── presentation/
│   ├── bloc/
│   ├── pages/
│   └── widgets/
└── main.dart
```

## Brand Guidelines
The HabitTune brand features a circular progress indicator with a gap bridged by a checkmark, symbolizing the completion of habits and tracking of progress. The color scheme uses Deep Purple (#673AB7) and Vibrant Blue (#2196F3) to represent adaptability and growth.

