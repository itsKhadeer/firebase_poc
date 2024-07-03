# flutterfirebaseproject

A new Flutter project for Firebase Authentication Proof of Concept.

## Getting Started

To get started with this project, follow these steps:

1. Create a new Firebase project in the Firebase console. You can choose any name for your project.
2. Enable or disable analytics based on your preference.
3. In the project overview page, click on the Flutter icon under "Add apps to the project".
4. Follow the instructions provided to integrate your Flutter project (which you have already created) with Firebase using the FlutterFire tool.
5. Enable email/password authentication and sign in with Google authentication in the project's authentication page.
6. Go to the SDK setup and configurations of the Android app in your project. Add the SHA certificate fingerprint.
    - To do this, open the terminal and navigate to the path where the `app-debug.apk` file is located:
      `C:\....\flutter_firebase_project\flutterfirebaseproject\build\app\outputs\apk\debug>`
    - In the terminal, run the following command:
      `keytool -printcert -jarfile app-debug.apk`
    - Copy the SHA-1 key and paste it in the fingerprint adding section of your Firebase project's Android app SDK setup and configuration.
    - This will enable Google Sign-In and other OAuth functionalities.
7. Your Firebase project is now set up.

8. Copy the `google-services.json` file to the Android app and the `GoogleService-Info.plist` file to the iOS app.
9. You are now ready to go!

For more information, you can refer to the [Firebase documentation](https://firebase.google.com/docs/flutter/setup) and the [FlutterFire documentation](https://firebase.flutter.dev/).
