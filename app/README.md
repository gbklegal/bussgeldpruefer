# Bussgeldprüfer App

## First Installation

1. Install Xcode from the [App Store](https://apps.apple.com/de/app/xcode/id497799835)
2. Install Flutter via Homebrew ([brew.sh](https://formulae.brew.sh/cask/flutter#default))
3. Clone this respository
4. Before the first run make the [IDE Setup](#ide-setup)
5. Open `/lib/main.dart` and `Run Without Debugging`

## IDE Setup

1. Install VS Code via Homebrew ([brew.sh](https://formulae.brew.sh/cask/visual-studio-code#default))
2. Install the following 2 extensions:
	- [Dart](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code)
	- [Flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)

---

## Getting Started (Flutter Docs)

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

---

## File Structure

(Source: [Article](https://www.geeksforgeeks.org/flutter-file-structure/))  
(New File Structure: [Article](https://medium.com/flutter-community/flutter-scalable-folder-files-structure-8f860faafebd))

1. Assets: Static assets for the app

- /assets
	- /fonts
	- /images
		- /icons
	- /videos

> This directory is on the root level will contain all the static assets that are used in the application, for example, fonts, icons, logos, background images, demo videos, etc. It is very much recommended that we should have different directories for a different type of data for example images, videos & logos, should have a different folder of their own so that it becomes easier to maintain and access them.

2. Screens: Screen /UI of the app

- /lib
	- /screens

> This directory will contain the actual layout of the UI for the entire application. It can further be distributed into two-three folders. One which stored the flash screen and onboarding pages such as login/sign-up screen, the second folder can store the home screen and other generally used screens, and the third folder can contain screens that are not that important.

3. Utilities: Function or logic used in the app

- /lib
	- /utilities

> This directory will hold all the app logic or business logic of our entire application. Again a good example in the weather app would be when a user selects a different location the weather data should also change accordingly. Or in the case of the social media app when logins the app data should also change accordingly.

4. Widgets: Widgets / Layouts used in the app

- /lib
	- /widgets

> It becomes clear all by the name itself that this folder will hold all the static widgets or the widgets that are used multiple times in the application. For example, if it is a social media app like Instagram, the list view of all the suggested friends are always the same, the only thing that changes in the data. Or if it is a weather app the tile which shows a particular location is same for all the location, the only thing that change is the name of the place.
