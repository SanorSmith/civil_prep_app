# Civil Preparedness App

A mobile application for Swedish civil preparedness, designed with offline-first capabilities and privacy-preserving features aligned with MSB (Swedish Civil Contingencies Agency) guidelines.

## Overview

This app provides Swedish citizens with:
- **Emergency alerts** and warnings
- **Preparedness checklists** for various scenarios
- **Information resources** for crisis management
- **Offline functionality** - full features without internet
- **Privacy-first design** - no GPS tracking, postal code only

## Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Supabase (PostgreSQL, Auth, Storage)
- **State Management**: Riverpod
- **Local Storage**: Hive (encrypted)
- **Deployment**: App Store + Google Play

## Key Features

### Privacy & Security
- No GPS tracking - postal code based location
- Encrypted local storage using Hive
- Anonymous data aggregation (k-anonymity ≥50)
- GDPR compliant
- No persistent user messaging

### Offline-First
- Full functionality without internet connection
- Background sync when online
- Local caching of all critical data
- Works on 3G networks

### Localization
- Swedish (primary)
- English (secondary)

## Project Structure

```
lib/
├── core/
│   ├── config/          # App configuration
│   ├── l10n/            # Localization
│   ├── models/          # Core data models
│   ├── providers/       # Global providers
│   ├── router/          # Navigation
│   ├── services/        # Core services
│   ├── theme/           # App theming
│   └── utils/           # Utilities
├── features/
│   ├── alerts/          # Emergency alerts
│   ├── checklist/       # Preparedness checklists
│   ├── home/            # Home screen
│   ├── onboarding/      # First-time user flow
│   └── settings/        # App settings
└── main.dart            # App entry point
```

## Getting Started

### Prerequisites

- Flutter SDK (>=3.2.0)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Supabase account (for backend)

### Installation

1. **Install Flutter**
   ```bash
   # Follow instructions at https://flutter.dev/docs/get-started/install
   ```

2. **Clone and setup**
   ```bash
   cd civil_prep_app
   flutter pub get
   ```

3. **Configure environment**
   Create a `.env` file:
   ```
   SUPABASE_URL=your_supabase_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   ENV=dev
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Build

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## Development

### Code Generation

Run code generators for Riverpod and Hive:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Watch mode for development:
```bash
flutter pub run build_runner watch
```

### Testing

```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test
```

### Linting

```bash
flutter analyze
```

## Architecture

The app follows **Clean Architecture** principles with feature-based organization:

- **Presentation Layer**: UI components (pages, widgets)
- **Domain Layer**: Business logic (use cases, entities)
- **Data Layer**: Data sources (local, remote, repositories)

### State Management

Using **Riverpod** for:
- Dependency injection
- State management
- Reactive programming

### Data Flow

1. **Offline-first**: All data stored locally in Hive
2. **Background sync**: Periodic sync when online
3. **Conflict resolution**: Last-write-wins with timestamps
4. **Cache expiry**: 7-day default for non-critical data

## Privacy & Data Handling

### Data Collection
- **Postal code only** (no GPS coordinates)
- **Anonymous usage statistics** (aggregated)
- **No personal identifiers**

### Data Storage
- **Local**: Encrypted Hive boxes
- **Remote**: Supabase (anonymized)
- **Retention**: 90 days for aggregated data

### K-Anonymity
Minimum threshold of 50 users per postal code area before data aggregation.

## Configuration

### App Constants
See `lib/core/config/app_config.dart`:
- `kAnonymityThreshold`: 50
- `syncInterval`: 6 hours
- `cacheExpiry`: 7 days

## Deployment

### Android
1. Configure signing in `android/app/build.gradle`
2. Build release APK/AAB
3. Upload to Google Play Console

### iOS
1. Configure signing in Xcode
2. Build release IPA
3. Upload to App Store Connect

## Contributing

This is a government-aligned project. Contributions should follow:
- MSB guidelines for civil preparedness
- GDPR compliance requirements
- Accessibility standards (WCAG 2.1 AA)
- Swedish language standards

## License

[To be determined based on project requirements]

## Contact

[To be added]

## Acknowledgments

- MSB (Swedish Civil Contingencies Agency)
- Flutter community
- Supabase team
