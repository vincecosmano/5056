# Oneapptredie Flutter App

## Setup Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/vincecosmano/5056.git
   cd 5056
   ```
2. Install Flutter from [flutter.dev](https://flutter.dev/docs/get-started/install).
3. Install the necessary packages:
   ```bash
   flutter pub get
   ```

## Features Overview
- User Authentication via Google OAuth
- Real-time data synchronization with Firebase
- Comprehensive UI with responsive design
- Integration with third-party libraries for enhanced functionality

## Development Guide
- Use Visual Studio Code or Android Studio for development.
- Run the app on an emulator or connected device:
   ```bash
   flutter run
   ```
- Follow the best practices for Flutter development.

## Firebase Setup
1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
2. Register your app in the Firebase project.
3. Download the `google-services.json` for Android and place it in `android/app/`.
4. Configure Firebase in the Flutter app according to the official documentation:
   - [Add Firebase to Your Flutter App](https://firebase.flutter.dev/docs/overview/)

## Google OAuth Setup
1. Go to [Google Cloud Console](https://console.cloud.google.com/).
2. Create a new project or select an existing one.
3. Enable "Google+ API" in your project.
4. Set up OAuth 2.0 credentials and download the `client_id.json`.
5. Add the necessary configuration to your Flutter app:
   - Follow the instructions in [Google Sign-In for Flutter](https://pub.dev/packages/google_sign_in)

## Deployment Instructions
1. Build the app for release:
   ```bash
   flutter build apk --release
   ```
2. Deploy the APK to desired app stores or distribute it directly.
3. Follow platform-specific guidelines for deployment (Google Play Store, etc.).

---

### License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Acknowledgements
- Flutter team
- Firebase team
- Google Cloud team
