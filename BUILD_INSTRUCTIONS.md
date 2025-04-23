# HabitTune App - APK Build Instructions

This document provides simplified instructions for building the HabitTune app APK.

## Prerequisites

Before building the APK, ensure you have the following installed:

1. **Flutter SDK** (version 2.17.0 or higher)
2. **Android SDK** with build tools
3. **Java Development Kit (JDK)** (version 11 recommended)
4. **Android Studio** (recommended for managing Android SDK components)

## Setup Steps

1. **Verify Flutter Installation**
   ```bash
   flutter --version
   ```
   Make sure Flutter is properly installed and on the stable channel.

2. **Check Flutter Setup**
   ```bash
   flutter doctor
   ```
   Resolve any issues reported by the Flutter doctor command.

3. **Connect a Device or Start an Emulator**
   Either connect a physical Android device via USB with USB debugging enabled,
   or start an Android emulator.

## Building the APK

### Option 1: Debug APK (Faster build, larger size)

```bash
# Navigate to the project directory
cd /path/to/habittune_flutter_project

# Get dependencies
flutter pub get

# Build debug APK
flutter build apk --debug
```

The debug APK will be located at:
`build/app/outputs/flutter-apk/app-debug.apk`

### Option 2: Release APK (Optimized for distribution)

```bash
# Navigate to the project directory
cd /path/to/habittune_flutter_project

# Get dependencies
flutter pub get

# Build release APK
flutter build apk --release
```

The release APK will be located at:
`build/app/outputs/flutter-apk/app-release.apk`

### Option 3: Split APKs by ABI (Smaller size per APK)

```bash
# Build split APKs for different CPU architectures
flutter build apk --split-per-abi --release
```

This will generate three APKs:
- `build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk`
- `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk`
- `build/app/outputs/flutter-apk/app-x86_64-release.apk`

## Installing the APK

### On a Connected Device

```bash
# Install the APK on a connected device
flutter install
```

### Manual Installation

Transfer the APK to your Android device and install it by tapping on the file.

## Troubleshooting

If you encounter build issues:

1. **Clean the project**
   ```bash
   flutter clean
   flutter pub get
   ```

2. **Check for dependency conflicts**
   ```bash
   flutter pub outdated
   ```

3. **Verify Android SDK setup**
   ```bash
   flutter doctor --android-licenses
   ```

4. **Check Gradle configuration**
   If you encounter Gradle-related issues, check the following files:
   - `android/build.gradle`
   - `android/app/build.gradle`
   - `android/gradle/wrapper/gradle-wrapper.properties`
