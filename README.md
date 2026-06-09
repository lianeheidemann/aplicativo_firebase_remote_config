# Firebase Remote Config Flutter Application

<div align="center">

A production-ready Flutter application demonstrating Firebase Remote Config integration for dynamic UI control and real-time configuration management without app redeployment.

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Latest-orange?style=for-the-badge&logo=firebase)](https://firebase.google.com)
[![Dart](https://img.shields.io/badge/Dart-3.0+-1f425f?style=for-the-badge&logo=dart)](https://dart.dev)

[Features](#features) • [Installation](#installation) • [Configuration](#configuration) • [Resources](#resources)

</div>

---

## Overview

This project provides a production-ready implementation of Firebase Remote Config in Flutter, enabling dynamic control of application UI elements without requiring new app releases. Configuration updates are deployed in real-time through Firebase Console.

**Primary Applications:**
- A/B testing UI variations
- Feature flag management
- Real-time promotional content deployment
- Dynamic theming and branding

---

## Features

**Core Functionality**
- Firebase initialization with `firebase_core`
- Automatic fetch and activation of Remote Config
- Real-time dynamic UI updates
- Manual refresh functionality

**UI Components**
- Background color customization
- Dynamic promotional images
- Graceful fallback to default values
- Production-ready error handling

---

## Demo

**Background Color Update**

<img align="left" src="https://github.com/lianeheidemann/aplicativo_firebaseremoteconfig/raw/main/assets/gifs/gif1_cor_FirebaseRemoteConfig.gif" width="400" alt="Background Color Update">

**Promotional Content Management**

<img align="left" src="https://github.com/lianeheidemann/aplicativo_firebaseremoteconfig/raw/main/assets/gifs/gif2_propaganda_FirebaseRemoteConfig.gif" width="400" alt="Promotional Content Management">

<br clear="left">

---

## Technology Stack

| Component | Purpose | Version |
|-----------|---------|---------|
| Flutter | Cross-platform UI framework | 3.0+ |
| firebase_core | Firebase initialization | Latest |
| firebase_remote_config | Configuration management | Latest |
| url_launcher | URL navigation | Latest |
| Dart | Programming language | 3.0+ |

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

#### 3. Firebase Configuration

**Using FlutterFire CLI (Recommended):**
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

**Manual Configuration:**
1. Download `google-services.json` from Firebase Console
2. Place in `android/app/`
3. Verify Firebase plugins in `android/build.gradle`

#### 4. Application Launch
```bash
flutter run
```

---

## Configuration

### Remote Configuration Parameters

#### Background Color (`cor_fundo`)

| Attribute | Specification |
|-----------|---------------|
| Type | String (Hexadecimal) |
| Format | `#RRGGBB` |
| Default Value | `#FFFFFF` |
| Application | Scaffold background color |
| Examples | `#FF5733`, `#3498DB`, `#2ECC71` |

#### Promotional Image (`propaganda`)

| Attribute | Specification |
|-----------|---------------|
| Type | String |
| Default Value | `default` |
| Valid Values | `alternativa` or custom |
| Behavior | `alternativa` → `propaganda_alt.png` |
| | Default → `propaganda.png` |

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

### Configuration Examples

**Configuration A - Red Theme:**
```json
{
  "cor_fundo": "#FF0000",
  "propaganda": "alternativa"
}
```

**Configuration B - Blue Theme:**
```json
{
  "cor_fundo": "#0000FF",
  "propaganda": "default"
}
```

**Configuration C - Green Theme:**
```json
{
  "cor_fundo": "#2ECC71",
  "propaganda": "default"
}
```

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

## Implementation

### Remote Config Initialization

```dart
final remoteConfig = FirebaseRemoteConfig.instance;

await remoteConfig.setDefaults({
  'cor_fundo': '#FFFFFF',
  'propaganda': 'default',
});

await remoteConfig.fetchAndActivate();
```

### Configuration Access

```dart
String backgroundColor = remoteConfig.getString('cor_fundo');
String imageType = remoteConfig.getString('propaganda');
```

### Manual Configuration Refresh

```dart
void _refreshConfig() async {
  try {
    await remoteConfig.fetchAndActivate();
    setState(() {});
  } catch (e) {
    print('Configuration refresh failed: $e');
  }
}
```

---

## Dependencies

**pubspec.yaml configuration:**

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^latest
  firebase_remote_config: ^latest
  url_launcher: ^latest
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

### Validation Checklist

- Hexadecimal color value testing
- Propaganda configuration variants
- Network error handling
- Firebase usage monitoring

---

## Use Cases

| Application | Description |
|-------------|-------------|
| A/B Testing | Color scheme variation testing |
| Feature Flags | Feature enablement control |
| Promotional Management | Dynamic promotional content |
| Theme Management | Real-time theme switching |
| Regional Customization | Region-specific content |
| Emergency Updates | Rapid UI updates without store deployment |

---

## Documentation

- [Firebase Remote Config Documentation](https://firebase.google.com/docs/remote-config)
- [Flutter Firebase Integration](https://firebase.flutter.dev)
- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Console](https://console.firebase.google.com)
- [FlutterFire CLI](https://firebase.flutter.dev/docs/cli)

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
