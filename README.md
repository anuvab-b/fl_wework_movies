# WeWorks Movies Mobile Application

WeWorks Movies Mobile application for Android and IOS, built with Flutter, a cross-platform SDK.

## Project Preview
<p>
  <img src="https://github.com/anuvab-b/fl_wework_movies/assets/29280254/66474ea2-431f-480d-9be3-90acd9626bec" height= 400 width= 200 hspace="1"/>
  <img src="https://github.com/anuvab-b/fl_wework_movies/assets/29280254/27e26267-d26b-4fea-b6ee-1ddd895a4d5e" height= 400 width= 200 hspace="1"/>
  <img src="https://github.com/anuvab-b/fl_wework_movies/assets/29280254/7b4c2903-9f47-4b0a-9ed8-3d1b4cf143b5" height= 400 width= 200 hspace="1"/>
  <img src="https://github.com/anuvab-b/fl_wework_movies/assets/29280254/a5c8f3c0-5bf3-49a4-a7d2-4d3d120a7b7d" height= 400 width= 200 hspace="1"/>
</p>

## Features
- **Fetching Location**: Fetching user location and reverse geocoding to get the user's primary and secondary address.
- **Now Playing Movie Watchlist**: Stay updated with now playing movies.
- **Top Rated Movie Watchlist**: Stay updated with top-rated movies.
- **Search**: Search for movies by name.
- **Caching & Pull to Refresh**: Data is cached to be displayed in offline state. Pull to refresh functionality fetches the latest data.

## File Structure

```bash
app
├── android
├── ios
├── assets
├── ios
├── lib
│   ├── bloc
│   │   ├── home
│   │   ├── now_playing
│   │   ├── splash
│   │   ├── top_rated
│   ├── database
│   │   ├── database.dart
│   │   ├── database.g.dart
│   ├── domain
│   ├── infrastructure
│   ├── network
│   ├── presentation
│   ├── utils
│   main.dart
├── test
├── README.MD
├── pubspec.yaml
└── .gitignore
```
***
***android***: folder contains a complete Android native app project and is used when building your Flutter application for Android. In this case the Flutter code is compiled and then injected in this Android project, so that the result is a native Android application.
***
***assets***: folder in the root of the project which we will use to store images, translation files, custom font files, HTML files.
***
***icons***: This Folder contains all the icons used in the project.
>After creating the assets/icons folder we need to add all the assets/icons path in **_pubspec.yaml_** file so that flutter recognizes where the assets/icons/images are present.
***
***ios***: folder contains a complete XCode iOS native project which is used when building your Flutter application for iOS. It’s used in the same way as the project which is contained in the anroid folder is used when building for Android.

***test***: folder is containing code which is written for the Flutter application in order to perform automated test when building the application.
***
***libs***:Inside this folder you’ll find the Dart files which contain the code of your Flutter application. By default this folder is containing the file _main.dart_:


->***network*** : this folder contain all the network layer files.
* _response.dart_ this file contains a custom response class for all http requests which mainly has the properties success, message and data

* _network_.dart it content all common network methods like GET, PUT, POST and handle the API response according to the response code .It gives the custom ApiBaseHelper class for making those requests.

->***src***: This folder contains UI pages and Business logic files with caching mechanism.

- **Models**: It contains all data models which do serialization and deserialization of JSON data.
  >- To auto generate JSON Data models we use `json_annotation` package. [Know more](https://pub.dev/packages/json_annotation). use following command to generate model.
     `flutter pub run build_runner build --delete-conflicting-outputs`
  >- if model file is model_1.dart then it will auto generate file as model_1.g.dart.
- **bloc**:
    - It contains all business logic code which connect with the UI pages or Widgets.
    - Every bloc contains a corresponding event and state class.

- **presentation**:
    - It contains all UI pages
    - Every module has its own presentation folder and all the UI related to that particular module present inside that folder.

***
***pubspec.yaml***: file is the project’s configuration file.
This file contains:
-   general project settings like name, description and version of the project
-   project dependencies
-   assets (e.g. images, icons, fonts etc.) which should be available in your Flutter application
- E.g. when adding new dependencies (Flutter Packages) to the project this file will be used to add the name of the package in the dependencies section and then the Flutter SDK will take care of downloading and adding this package afterwards.

>`Version: 1.2.01` indicates application changes/progress like **[major.minor.patch]** .every time when we upload a build on production we need to change the version accordingly.
>-   `patch`  is for minor changes or bug fixes
>-   `minor`  is for new functionality
>-   `major`  is for major changes, like a rewrite of the project or architechtural changes.

## Libraries Or Packages Used

[dio: 5.3.3](https://pub.dev/packages/dio)  : A package for making HTTP requests.
***
[cupertino_icons: ^1.0.0](https://pub.dev/packages/cupertino_icons)  : This package provides icons for cupertino[IOS] theme.
***
[flutter_svg: 1.1.6](https://pub.dev/packages/flutter_svg)  : This package helps to render .svg files
***
[flutter_bloc: 8.1.5](https://pub.dev/packages/flutter_svg)  : This package helps to implement BLoC Design Pattern in Flutter.
***
[path_provider: 2.0.11](https://pub.dev/packages/path_provider): Plugin for finding commonly used locations on the filesystem
***
[get_it: 7.6.0](https://pub.dev/packages/get_it) :  Accessing service objects like REST API clients or databases so that they easily can be mocked.
***
[floor: 7.6.0](https://pub.dev/packages/get_it) : This provides a wrapper around the sqflite plugin which is used for storing application data in an in-app DB.

## Architecture
### TDD Pattern

**Application** : The **`application`** folder contains all the controllers which contain the business logic needed for a module/app.

**Domain**: The  **`domain`**  folder contains custom models which also have helper methods for json serialization and de serialization.

**Infrastructure**:  The  **`infrastructure`**  folder contains handling of api request calls and responses and sending them back to application layer

**Presentation**:  The  **`presentation`**  folder contains our UI widgets and pages.

## App Build and Release
###  Android Build Release
```
flutter build apk --release
```
### IOS Build Release

- To launch the app on an iOS device you need the third-party CocoaPods dependency manager. Run the following to install and setup CocoaPods:
  `$ sudo gem install cocoapods
  $ pod setup`

- Open iOS folder in Xcode directly from Android Studio or run the following command to open the workspace project in XCode:
  `$ open ios/Runner.xcworkspace`

- The runner project opens up in your XCode editor. Click on the Runner folder to go to the project settings page. Click on the Runner from TARGETS and go to Signing & Capabilities section.

- We also need an Apple Developer account to deploy the app on iOS device and Apple Distributor private key to upload the app on App Store. So, choose an account from Team dropdown. Alternatively, you can also create a new account from the same dropdown by selecting Add an Account… option.

- The next step is to specify a unique name for your app bundle. Replace the default bundle identifier com.example.demoApp to your own name (should be unique).

- Ensure that Status message disappears and a new Signing Certificate is created for the app.

- To Upload the app on App store we need to create app archive, after successful creation of archive we need to validate the archive with App distributor private key(this key should be install on your machine).

- After validation we are ready to upload the app on App store.
