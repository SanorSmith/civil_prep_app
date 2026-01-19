# 🛡️ Civil Beredskap - Emergency Preparedness App

A comprehensive emergency preparedness application built with Flutter, helping Swedish citizens prepare for crisis situations according to MSB (Swedish Civil Contingencies Agency) guidelines.

![Civil Beredskap Banner](screenshots/banner.png)

## 📱 About

Civil Beredskap is a mobile application designed to help individuals and families prepare for emergencies by tracking essential supplies across different time periods (24h, 72h, 7 days). The app provides a structured approach to emergency preparedness with bilingual support (Swedish/English).

## ✨ Features

### 🌍 Bilingual Support
- **Swedish (Svenska)** and **English** interface
- Seamless language switching
- All content fully translated

### 👤 User Profile Management
- **Create multiple profiles** - Different users on same device
- **Login/Logout** - Switch between profiles
- **Guest mode** - Use without saving progress
- **Delete profiles** - Reset all data when needed
- **Auto-save** - Progress saved automatically

### 📊 Preparedness Tracking
- **9 Essential Categories**:
  - 💧 Water
  - 🍴 Food
  - 🔦 Light
  - 🔥 Heat
  - 📻 Radio
  - 💵 Cash
  - 💊 Medicine
  - 🧼 Hygiene
  - 🏥 First Aid

### ⏱️ Time-Based Planning
- **24 hours** - Immediate preparedness
- **72 hours** - Short-term crisis
- **7 days** - Extended emergency

### 📈 Progress Monitoring
- Visual progress circles per time period
- Category completion percentages
- Real-time updates

### 🎯 Smart Recommendations
- Next step hero card with priority actions
- Contextual guidance (why, how, tips)
- Automatic progression to next items
- Celebration on completion

### 📝 Custom Items
- Add personal items to any category
- Bilingual custom item support
- Edit and delete custom entries

### 💾 Data Persistence
- Local storage using SharedPreferences
- Per-profile data isolation
- Guest mode with no data retention
- Export/import capabilities

## 📸 Screenshots

### Language Selection & Onboarding
<table>
  <tr>
    <td><img src="screenshots/language-selection.png" alt="Language Selection" width="250"/></td>
    <td><img src="screenshots/profile-selection.png" alt="Profile Selection" width="250"/></td>
    <td><img src="screenshots/welcome.png" alt="Welcome Screen" width="250"/></td>
  </tr>
  <tr>
    <td align="center"><b>Choose Language</b></td>
    <td align="center"><b>Select/Create Profile</b></td>
    <td align="center"><b>Welcome Screen</b></td>
  </tr>
</table>

### Main Features
<table>
  <tr>
    <td><img src="screenshots/home-screen.png" alt="Home Screen" width="250"/></td>
    <td><img src="screenshots/hero-card.png" alt="Next Step Card" width="250"/></td>
    <td><img src="screenshots/categories.png" alt="Categories" width="250"/></td>
  </tr>
  <tr>
    <td align="center"><b>Home Dashboard</b></td>
    <td align="center"><b>Next Step Guidance</b></td>
    <td align="center"><b>Category Overview</b></td>
  </tr>
</table>

### Category Details & Progress
<table>
  <tr>
    <td><img src="screenshots/category-detail.png" alt="Category Detail" width="250"/></td>
    <td><img src="screenshots/progress-tracking.png" alt="Progress" width="250"/></td>
    <td><img src="screenshots/custom-item.png" alt="Add Custom Item" width="250"/></td>
  </tr>
  <tr>
    <td align="center"><b>Water Category</b></td>
    <td align="center"><b>Progress Tracking</b></td>
    <td align="center"><b>Add Custom Items</b></td>
  </tr>
</table>

### Profile Management
<table>
  <tr>
    <td><img src="screenshots/profile-management.png" alt="Profiles" width="250"/></td>
    <td><img src="screenshots/settings.png" alt="Settings" width="250"/></td>
    <td><img src="screenshots/guest-mode.png" alt="Guest Mode" width="250"/></td>
  </tr>
  <tr>
    <td align="center"><b>Multiple Profiles</b></td>
    <td align="center"><b>Settings</b></td>
    <td align="center"><b>Guest Mode</b></td>
  </tr>
</table>

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>= 3.0.0)
- Dart (>= 3.0.0)
- Chrome (for web development)
- Android Studio / Xcode (for mobile)

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/SanorSmith/civil_prep_app.git
cd civil_prep_app
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
# Web
flutter run -d chrome

# Android
flutter run -d android

# iOS
flutter run -d ios
```

## 🏗️ Project Structure

```
civil_prep_app/
├── lib/
│   ├── core/
│   │   ├── models/           # Data models
│   │   │   └── preparedness_item.dart
│   │   ├── services/         # Business logic
│   │   │   ├── items_service.dart
│   │   │   ├── user_profile_service.dart
│   │   │   ├── next_step_service.dart
│   │   │   └── app_state_service.dart
│   │   ├── theme/            # App theming
│   │   │   └── app_theme.dart
│   │   └── widgets/          # Shared widgets
│   │       └── add_custom_item_dialog.dart
│   ├── features/
│   │   ├── onboarding/       # Language & profile selection
│   │   │   └── screens/
│   │   │       ├── language_selection_screen.dart
│   │   │       └── profile_selection_screen.dart
│   │   ├── home/             # Main dashboard
│   │   │   ├── presentation/
│   │   │   │   └── screens/
│   │   │   │       └── home_screen.dart
│   │   │   └── widgets/
│   │   │       ├── next_step_hero_card.dart
│   │   │       └── all_complete_card.dart
│   │   ├── preparedness/     # Category views
│   │   │   └── screens/
│   │   │       └── category_detail_screen.dart
│   │   └── levels/           # Time period views
│   │       └── screens/
│   │           └── level_detail_screen.dart
│   └── main.dart             # App entry point
├── assets/                   # Images, fonts, etc.
├── screenshots/              # App screenshots
└── README.md
```

## 🛠️ Tech Stack

- **Framework:** Flutter 3.x
- **Language:** Dart 3.x
- **State Management:** setState (StatefulWidget)
- **Local Storage:** SharedPreferences
- **Architecture:** Feature-first structure
- **Localization:** Manual bilingual implementation

### Key Packages

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2
  flutter_localizations:
    sdk: flutter
```

## 🎨 Design Philosophy

### MSB Guidelines Compliance
The app follows official Swedish Civil Contingencies Agency (MSB) recommendations for emergency preparedness, ensuring users have the essential supplies needed for different crisis durations.

### User-Centric Design
- **Intuitive navigation** - Clear information hierarchy
- **Visual feedback** - Progress indicators and celebrations
- **Accessibility** - High contrast, readable fonts
- **Responsive** - Works on all screen sizes

### Bilingual by Default
All content is available in both Swedish and English, making emergency preparedness accessible to both Swedish speakers and international residents.

## 📊 Features Breakdown

### Profile System
```
┌─────────────────────────────────┐
│ Profile Types:                  │
│ • Registered User (saved)       │
│ • Guest User (temporary)        │
│ • Multiple Users (family)       │
└─────────────────────────────────┘
```

### Data Isolation
- Each profile has separate data
- Guest mode uses no storage
- Switch profiles without data loss
- Delete profile removes all data

### Smart Prioritization
```
Priority Algorithm:
1. Time period (24h > 72h > 7d)
2. Category importance (Water > Food > Medicine...)
3. Completion status (uncompleted first)
```

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📱 Supported Platforms

- ✅ **Web** (Chrome, Firefox, Safari)
- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 12+)
- ✅ **Desktop** (Windows, macOS, Linux - with modifications)

## 🌟 Roadmap

### Version 2.0
- [ ] Cloud sync across devices
- [ ] Family sharing
- [ ] Shopping list generation
- [ ] Expiration date tracking
- [ ] Location-based recommendations
- [ ] Offline mode improvements
- [ ] PDF export of checklist
- [ ] Integration with emergency services

### Future Enhancements
- [ ] Dark mode
- [ ] Accessibility improvements
- [ ] More languages (Finnish, Norwegian, Danish)
- [ ] AR mode for storage visualization
- [ ] Community sharing features

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Development Guidelines
- Follow Flutter style guide
- Add tests for new features
- Update documentation
- Ensure bilingual support for new content

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Sanor**
- GitHub: [@SanorSmith](https://github.com/SanorSmith)

## 🙏 Acknowledgments

- **MSB (Swedish Civil Contingencies Agency)** - For emergency preparedness guidelines
- **Flutter Team** - For the amazing framework
- **Community Contributors** - For feedback and suggestions

## 📞 Contact & Support

- **Issues:** [GitHub Issues](https://github.com/SanorSmith/civil_prep_app/issues)
- **Discussions:** [GitHub Discussions](https://github.com/SanorSmith/civil_prep_app/discussions)

## 🌐 Resources

- [MSB Official Website](https://www.msb.se/)
- [MSB Crisis Preparedness Guide](https://www.dinsakerhet.se/)
- [Flutter Documentation](https://docs.flutter.dev/)

## 🌐 Live Demo

**Try the app now:** https://web-mu-coral.vercel.app

---

<p align="center">
  <b>Built with ❤️ for emergency preparedness</b><br>
  <sub>Helping people be ready when it matters most</sub>
</p>

---

## 📊 Project Stats

![GitHub stars](https://img.shields.io/github/stars/SanorSmith/civil_prep_app?style=social)
![GitHub forks](https://img.shields.io/github/forks/SanorSmith/civil_prep_app?style=social)
![GitHub issues](https://img.shields.io/github/issues/SanorSmith/civil_prep_app)
![GitHub license](https://img.shields.io/github/license/SanorSmith/civil_prep_app)

**Made in Sweden 🇸🇪 | Available in Swedish & English**
