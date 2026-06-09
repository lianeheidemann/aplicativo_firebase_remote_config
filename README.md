# Firebase Remote Config Flutter App

<div align="center">

A Flutter demonstration app showcasing Firebase Remote Config for dynamic, real-time UI updates without redeployment.

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-11.0+-orange?style=for-the-badge&logo=firebase)](https://firebase.google.com)
[![Dart](https://img.shields.io/badge/Dart-3.11+-1f425f?style=for-the-badge&logo=dart)](https://dart.dev)

</div>

---

## 📱 What This App Does

Updates **background color** and **promotional images** in real-time by fetching configuration from Firebase Remote Config. No app reinstall needed—just refresh!

### Demo
- **Left GIF**: Background color changing via Firebase Console
- **Right GIF**: Promotional image switching via Firebase Console

---

## ⚡ Quick Start

```bash
# Clone and install
git clone https://github.com/lianeheidemann/aplicativo_firebaseremoteconfig.git
cd aplicativo_firebaseremoteconfig
flutter pub get

# Configure Firebase
flutterfire configure

# Run
flutter run
```

---

## 🎛️ Configuration

Configure these parameters in [Firebase Console](https://console.firebase.google.com) → Remote Config:

| Parameter | Type | Format | Example |
|-----------|------|--------|---------|
| `cor_fundo` | String | Hex color `#RRGGBB` | `#FF0000` |
| `propaganda` | String | `default` or `alternativa` | `alternativa` |

**How it works:**
1. Set parameters in Firebase Console
2. Click **Publish**
3. Tap **Refresh** button in app
4. Watch UI update instantly ✨

---

## 💻 Implementation

The app fetches config on startup and allows manual refresh:

```dart
// Fetch and activate remote config
await remoteConfig.fetchAndActivate();

// Access values
String backgroundColor = remoteConfig.getString('cor_fundo');
String imageType = remoteConfig.getString('propaganda');
```

Default values fallback if network fails:
- `cor_fundo`: `#FFFFFF` (white)
- `propaganda`: `default`

---

## 📦 Tech Stack

| Component | Version |
|-----------|---------|
| Flutter | 3.0+ |
| firebase_core | 4.10+ |
| firebase_remote_config | 6.5+ |
| Dart | 3.11+ |

See [pubspec.yaml](pubspec.yaml) for complete dependencies.

---

## 📚 Resources

- [Firebase Remote Config Docs](https://firebase.google.com/docs/remote-config)
- [Flutter Firebase Integration](https://firebase.flutter.dev)
- [Full Implementation](lib/main.dart)

---

## 👤 Author

**Liane Heidemann** — [@lianeheidemann](https://github.com/lianeheidemann)

---

<div align="center">

Educational project • Flutter • Firebase

</div>
