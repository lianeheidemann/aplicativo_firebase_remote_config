# Firebase Remote Config Flutter Application

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Latest-orange?style=for-the-badge&logo=firebase)](https://firebase.google.com)
[![Dart](https://img.shields.io/badge/Dart-3.0+-1f425f?style=for-the-badge&logo=dart)](https://dart.dev)

---

> This project provides a production-ready implementation of Firebase Remote Config in Flutter, enabling dynamic control of application UI elements without requiring new app releases.

**Primary Applications:**
- A/B testing UI variations
- Feature flag management
- Real-time promotional content deployment
- Dynamic theming and branding

---

## Demo

**Background Color Update**

<img src="https://github.com/lianeheidemann/aplicativo_firebaseremoteconfig/raw/main/assets/gifs/gif1_cor_FirebaseRemoteConfig.gif" width="45%" alt="Background Color Update">

**Promotional Content Management**

<img src="https://github.com/lianeheidemann/aplicativo_firebaseremoteconfig/raw/main/assets/gifs/gif2_propaganda_FirebaseRemoteConfig.gif" width="45%" alt="Promotional Content Management">

---

## Installation

### System Requirements

- Flutter SDK 3.0 or higher
- Firebase CLI
- Android SDK or iOS SDK
- Active Firebase project

### Setup Instructions

#### 1. Repository Setup
```bash
git clone https://github.com/lianeheidemann/aplicativo_firebaseremoteconfig.git
cd aplicativo_firebaseremoteconfig
```

#### 2. Dependency Installation
```bash
flutter pub get
```


#### 3. Application Launch
```bash
flutter run
```

---

## Configuration

### Firebase Console Configuration

1. Navigate to Firebase Console → Remote Config
2. Select **Create Configuration**
3. Add parameters:

| Parameter | Value | Type |
|-----------|-------|------|
| cor_fundo | #FF0000 | String |
| propaganda | alternativa | String |

4. Click **Publish Configuration**
5. Allow 5-10 seconds for propagation
6. Open application and select **Refresh** button


---

## Project Structure

```
aplicativo_firebaseremoteconfig/
├── lib/
│   ├── main.dart                    # Application entry point
│   └── firebase_options.dart        # Firebase configuration
├── android/
│   ├── app/
│   │   └── google-services.json     # Firebase credentials
│   └── build.gradle                 # Build configuration
├── assets/
│   └── images/
│       ├── propaganda.png
│       ├── propaganda_alt.png
│       ├── gif1_cor_FirebaseRemoteConfig.gif
│       └── gif2_propaganda_FirebaseRemoteConfig.gif
├── pubspec.yaml                     # Dependencies
├── firebase.json                    # Firebase settings
└── README.md                        # Documentation
```

---

## Dependencies

**pubspec.yaml configuration:**

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^4.10.0
  firebase_remote_config: ^6.5.2
  url_launcher: ^6.3.1
```

**Update dependencies:**
```bash
flutter pub upgrade
```

---

## Testing and Validation

### Local Testing Procedure

1. Execute `flutter run`
2. Open Firebase Console
3. Publish new configuration
4. Select **Refresh** button in application
5. Verify UI updates

---

## Author

**Liane Heidemann**

- GitHub: [@lianeheidemann](https://github.com/lianeheidemann)
- Repository: [aplicativo_firebaseremoteconfig](https://github.com/lianeheidemann/.aplicativo_firebaseremoteconfig)

---

<div align="center">

Developed using Flutter and Firebase

[Back to Top](#firebase-remote-config-flutter-application)

</div>
