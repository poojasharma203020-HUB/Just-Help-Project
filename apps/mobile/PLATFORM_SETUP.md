# Platform Setup Guide

## Prerequisites

1. Flutter SDK 3.13+
2. Android SDK API 21+
3. Xcode 14+ (for iOS)
4. CocoaPods

## Setup Steps

```bash
# 1. Get dependencies
cd apps/mobile
flutter pub get

# 2. Generate code
dart run build_runner build --delete-conflicting-outputs

# 3. Setup Firebase
# - Download google-services.json to android/app/
# - Download GoogleService-Info.plist to ios/Runner/

# 4. Setup Android Keystore
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias justhelp-release

# 5. Run app
flutter run --dart-define-from-file=env/dev.json
```

## Building for Production

### Android
```bash
flutter build apk --release --dart-define-from-file=env/prod.json
```

### iOS
```bash
flutter build ios --release --dart-define-from-file=env/prod.json
```
