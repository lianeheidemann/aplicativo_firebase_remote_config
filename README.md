# Firebase Remote Config Flutter Application

<div align="center">

A production-ready Flutter application demonstrating Firebase Remote Config integration for dynamic UI control and real-time configuration management without app redeployment.

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-11.0+-orange?style=for-the-badge&logo=firebase)](https://firebase.google.com)
[![Dart](https://img.shields.io/badge/Dart-3.0+-1f425f?style=for-the-badge&logo=dart)](https://dart.dev)

[Features](#features) • [Installation](#installation) • [Configuration](#configuration) • [Resources](#resources)

</div>

---

## Overview

This project provides a production-ready implementation of Firebase Remote Config in Flutter, enabling dynamic control of application UI elements without requiring new app releases. Configuration management supports:

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

<img src="https://github.com/lianeheidemann/aplicativo_firebaseremoteconfig/raw/main/assets/gifs/gif1_cor_FirebaseRemoteConfig.gif" width="45%" alt="Background Color Update">

**Promotional Content Management**

<img src="https://github.com/lianeheidemann/aplicativo_firebaseremoteconfig/raw/main/assets/gifs/gif2_propaganda_FirebaseRemoteConfig.gif" width="45%" alt="Promotional Content Management">

---

## Technology Stack

| Component | Purpose | Version |
|-----------|---------|---------|
| Flutter | Cross-platform UI framework | 3.0+ |
| firebase_core | Firebase initialization | 4.10+ |
| firebase_remote_config | Configuration management | 6.5+ |
| url_launcher | URL navigation | 6.3+ |
| Dart | Programming language | 3.11+ |

---

## Installation

### System Requirements

- Flutter SDK 3.0 or higher
- Dart SDK 3.11 or higher
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

### Firebase Setup

Before using this application, ensure you have:
1. Created a Firebase project in [Firebase Console](https://console.firebase.google.com)
2. Enabled Firebase Remote Config
3. Configured your app with `flutterfire configure` or manual setup

### Remote Configuration Parameters

#### Background Color (`cor_fundo`)

| Attribute | Specification |
|-----------|---------------|
| Type | String (Hexadecimal Color Code) |
| Format | `#RRGGBB` (6 digits) |
| Default Value | `#FFFFFF` (white) |
| Application | Scaffold background color |
| Validation | Must be valid hex format, invalid values default to white |
| Examples | `#FF0000` (red), `#0000FF` (blue), `#2ECC71` (green) |

**Color Parsing:**
- The application uses hex-to-RGB conversion internally
- Invalid hex values automatically fallback to white (`#FFFFFF`)
- The parser expects exactly 6 hexadecimal digits after `#`

#### Promotional Image (`propaganda`)

| Attribute | Specification |
|-----------|---------------|
| Type | String |
| Default Value | `default` |
| Valid Values | `alternativa` or `default` |
| Behavior | `alternativa` → displays `propaganda_alt.png` |
| | `default` → displays `propaganda.png` |
| Invalid Values | Default to `propaganda.png` if value not recognized |

### Remote Config Settings

This application uses optimized Remote Config settings:

```dart
RemoteConfigSettings(
  fetchTimeout: Duration(minutes: 1),        // Max time to fetch config
  minimumFetchInterval: Duration.zero,       // Allows immediate fetches
)
```

- **fetchTimeout**: Maximum 1 minute to retrieve config (prevents app hangs)
- **minimumFetchInterval**: Set to zero to allow manual refreshes without delays

### Firebase Console Configuration

#### Step-by-Step Setup:

1. **Navigate to Remote Config**
   - Open [Firebase Console](https://console.firebase.google.com)
   - Select your project
   - Go to **Remote Config** in the left sidebar

2. **Create Configuration**
   - Click **Create Configuration**
   - Add the following parameters:

| Parameter | Value | Type | Description |
|-----------|-------|------|-------------|
| `cor_fundo` | `#FF0000` | String | Background color (hex code) |
| `propaganda` | `alternativa` | String | Image variant selector |

3. **Publish Configuration**
   - Click **Publish Configuration**
   - Allow 5-10 seconds for propagation to all devices

4. **Refresh in Application**
   - Open the app
   - Click the **Refresh** button (top-right) to fetch latest config
   - Watch the UI update in real-time

### Configuration Examples

#### Configuration A - Red Theme with Alternative Image
```json
{
  "cor_fundo": "#FF0000",
  "propaganda": "alternativa"
}
```

#### Configuration B - Blue Theme with Default Image
```json
{
  "cor_fundo": "#0000FF",
  "propaganda": "default"
}
```

#### Configuration C - Green Theme with Default Image
```json
{
  "cor_fundo": "#2ECC71",
  "propaganda": "default"
}
```

#### Configuration D - Custom Purple Theme
```json
{
  "cor_fundo": "#9B59B6",
  "propaganda": "default"
}
```

### Troubleshooting Configuration

| Issue | Cause | Solution |
|-------|-------|----------|
| Colors not updating | Remote Config not fetched | Click **Refresh** button in app |
| Invalid color appears white | Hex code format error | Ensure format is `#RRGGBB` with 6 digits |
| Image not changing | Parameter name typo | Verify parameter is exactly `propaganda` |
| Config takes too long | Poor network connection | Check Firebase Console, wait 10 seconds |
| App crashes on startup | Firebase not initialized | Verify `flutterfire configure` was run |

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

// Configure fetch timeout and minimum fetch interval
await remoteConfig.setConfigSettings(
  RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: Duration.zero,
  ),
);

// Set default values
await remoteConfig.setDefaults({
  'cor_fundo': '#FFFFFF',
  'propaganda': 'default',
});

// Fetch and activate remote config
await remoteConfig.fetchAndActivate();
```

### Configuration Access

```dart
// Get string values from Remote Config
String backgroundColor = remoteConfig.getString('cor_fundo');
String imageType = remoteConfig.getString('propaganda');

// Parse hex color string
Color parseColor(String hex) {
  final value = hex.replaceAll('#', '').trim();
  if (value.length == 6) {
    return Color(int.parse('FF$value', radix: 16));
  }
  return Colors.white; // Fallback to white
}

// Apply parsed color
Color bgColor = parseColor(backgroundColor);
```

### Manual Configuration Refresh

```dart
void refreshConfig() async {
  try {
    await remoteConfig.fetchAndActivate();
    setState(() {}); // Update UI with new values
  } catch (e) {
    print('Configuration refresh failed: $e');
    // Show error to user or use cached values
  }
}
```

---

## Dependencies

**Current versions in pubspec.yaml:**

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^4.10.0
  firebase_remote_config: ^6.5.2
  url_launcher: ^6.3.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
```

**Update dependencies:**
```bash
flutter pub upgrade
```

---

## Testing

### Local Testing Procedure

1. **Launch Application**
   ```bash
   flutter run
   ```

2. **Configure in Firebase Console**
   - Navigate to Remote Config
   - Publish new configuration with test values

3. **Refresh Configuration in App**
   - Click the **Refresh** button (top-right icon)
   - Observe real-time UI updates

4. **Verify Changes**
   - Check background color change
   - Verify image switching between `default` and `alternativa`
   - Confirm no lag or errors in console

### Manual Testing Scenarios

- **Scenario 1**: Change color multiple times and refresh to verify updates
- **Scenario 2**: Switch promotional image variant and refresh
- **Scenario 3**: Disconnect network, try refresh (should show error gracefully)
- **Scenario 4**: Use invalid hex code (should fallback to white)

---

## Use Cases

This application demonstrates:

| Use Case | Implementation |
|----------|-----------------|
| A/B Testing | Color scheme variation testing via `cor_fundo` parameter |
| Feature Flags | Dynamic feature control without app redeployment |
| Promotional Management | Dynamic promotional content via `propaganda` parameter |
| Theme Management | Real-time theme switching with instant UI updates |

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
- Repository: [aplicativo_firebaseremoteconfig](https://github.com/lianeheidemann/aplicativo_firebaseremoteconfig)

---

<div align="center">

Developed using Flutter and Firebase

[Back to Top](#firebase-remote-config-flutter-application)

</div>
