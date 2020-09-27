# en_garde

En Garde Application using flutter

## Getting Started

In order to be able to run this project, you will have to install flutter, you can find how to install it and set up your editor at the getting started page of flutter https://flutter.dev/docs/get-started/install

Once it is installed, it is also possible that you need Android SDK and the iOS SDK installed.

Then finally clone the project.

Then using your terminal navigate to your project and run `flutter pub get` to install all the dependencies.

## Running your application (debug mode)

### Android

After installing all the SDK and installing flutter dependencies you will be able to run it in your device or even in the android emulator with the following commands.

It is possible that you need to add the SHA1 or SHA-256 hash of your device (of the devices which generates the APK) to be able to login into the app, more info at https://firebase.google.com/docs/flutter/setup?platform=android and https://developers.google.com/android/guides/client-auth

1. Open an Android emulator.
2. Execute `flutter run`.
3. If you have more than one emulator open it will ask you to select one if not then it should run in the only device connected.

### iOS

Mostly the same as the steps described for Android, but instead you need to launch the iOS simulator.

1. Launch iOS simulator.
2. Execute `flutter run`.
3. If you have more than one emulator open it will ask you to select one if not then it should run in the only device connected.

## Generate APK (Android)

Just run `flutter build apk`, it should not need you sign it but when you install it in your mobile device, it is possible your device ask you to confirm if you want to install it from an unknown source.

You can install it, just running `flutter install` and then select your connected device.

## Generate IPA (iOS)

Just run `flutter build ios` but in this case you need to sign the application which can be done using xcode and your free Apple developer account although you should have added devices to your Apple developer account and you will only be able to install it in those devices (after you trust your own certificate).

You can all use a paid Apple developer account certificate which will allow you to install the application in any device and even try to publish it in the apple store.
