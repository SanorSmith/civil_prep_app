# Setup Guide

## Prerequisites

### Required Software

1. **Flutter SDK** (>=3.2.0)
   - Download from: https://flutter.dev/docs/get-started/install
   - Add to PATH

2. **Dart SDK** (included with Flutter)

3. **IDE** (choose one):
   - Android Studio (recommended)
   - VS Code with Flutter extension
   - IntelliJ IDEA

4. **Platform-specific tools**:
   - **Android**: Android Studio, Android SDK
   - **iOS**: Xcode (macOS only), CocoaPods

5. **Supabase Account**
   - Sign up at: https://supabase.com

## Installation Steps

### 1. Install Flutter

**Windows:**
```powershell
# Download Flutter SDK
# Extract to C:\src\flutter
# Add to PATH: C:\src\flutter\bin

flutter doctor
```

**macOS/Linux:**
```bash
# Download Flutter SDK
cd ~/development
unzip flutter_sdk.zip
export PATH="$PATH:`pwd`/flutter/bin"

flutter doctor
```

### 2. Verify Installation

```bash
flutter doctor -v
```

Fix any issues reported by `flutter doctor`.

### 3. Clone Project

```bash
cd civil_prep_app
```

### 4. Install Dependencies

```bash
flutter pub get
```

### 5. Configure Supabase

1. Create a new project at https://supabase.com
2. Copy your project URL and anon key
3. Create `.env` file:

```bash
cp .env.example .env
```

Edit `.env`:
```
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
ENV=dev
```

### 6. Run Code Generation

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 7. Run the App

```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>

# Run in debug mode
flutter run

# Run in release mode
flutter run --release
```

## Platform-Specific Setup

### Android Setup

1. **Install Android Studio**
   - Download from: https://developer.android.com/studio

2. **Install Android SDK**
   - Open Android Studio
   - Tools → SDK Manager
   - Install Android SDK (API 33+)

3. **Create Virtual Device**
   - Tools → AVD Manager
   - Create Virtual Device
   - Select device and system image

4. **Configure Signing** (for release builds)
   
   Create `android/key.properties`:
   ```properties
   storePassword=<password>
   keyPassword=<password>
   keyAlias=key
   storeFile=<path-to-keystore>
   ```

   Generate keystore:
   ```bash
   keytool -genkey -v -keystore ~/civil-prep-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
   ```

### iOS Setup (macOS only)

1. **Install Xcode**
   - Download from App Store
   - Install command line tools:
   ```bash
   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
   sudo xcodebuild -runFirstLaunch
   ```

2. **Install CocoaPods**
   ```bash
   sudo gem install cocoapods
   ```

3. **Install iOS dependencies**
   ```bash
   cd ios
   pod install
   cd ..
   ```

4. **Configure Signing**
   - Open `ios/Runner.xcworkspace` in Xcode
   - Select Runner → Signing & Capabilities
   - Select your development team

## Development Setup

### VS Code Extensions

Install these extensions:
- Flutter
- Dart
- Flutter Intl
- Error Lens
- GitLens

### Android Studio Plugins

Install these plugins:
- Flutter
- Dart
- Flutter Intl

### Git Hooks (Optional)

Create `.git/hooks/pre-commit`:
```bash
#!/bin/sh
flutter analyze
flutter test
```

Make executable:
```bash
chmod +x .git/hooks/pre-commit
```

## Supabase Setup

### 1. Database Schema

Run these SQL commands in Supabase SQL Editor:

```sql
-- Alerts table
CREATE TABLE alerts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  severity TEXT NOT NULL,
  postal_codes TEXT[],
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  expires_at TIMESTAMP WITH TIME ZONE,
  is_active BOOLEAN DEFAULT TRUE
);

-- Checklist templates
CREATE TABLE checklist_templates (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  description TEXT,
  category TEXT NOT NULL,
  items JSONB NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Info articles
CREATE TABLE info_articles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  category TEXT NOT NULL,
  language TEXT DEFAULT 'sv',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Aggregated statistics (anonymous)
CREATE TABLE aggregated_stats (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  postal_code_prefix TEXT NOT NULL,
  metric_type TEXT NOT NULL,
  metric_value INTEGER NOT NULL,
  date DATE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE alerts ENABLE ROW LEVEL SECURITY;
ALTER TABLE checklist_templates ENABLE ROW LEVEL SECURITY;
ALTER TABLE info_articles ENABLE ROW LEVEL SECURITY;
ALTER TABLE aggregated_stats ENABLE ROW LEVEL SECURITY;

-- Public read access policies
CREATE POLICY "Public read access" ON alerts
  FOR SELECT USING (is_active = TRUE);

CREATE POLICY "Public read access" ON checklist_templates
  FOR SELECT USING (TRUE);

CREATE POLICY "Public read access" ON info_articles
  FOR SELECT USING (TRUE);

-- No direct access to stats (admin only)
CREATE POLICY "No public access" ON aggregated_stats
  FOR SELECT USING (FALSE);
```

### 2. Storage Buckets

Create these storage buckets:
- `images` (public)
- `icons` (public)

### 3. API Settings

- Enable Realtime (for alerts)
- Set JWT expiry to 1 hour
- Configure CORS for your domain

## Environment Configuration

### Development
```env
SUPABASE_URL=https://dev-project.supabase.co
SUPABASE_ANON_KEY=dev-key
ENV=dev
```

### Production
```env
SUPABASE_URL=https://prod-project.supabase.co
SUPABASE_ANON_KEY=prod-key
ENV=production
```

## Testing Setup

### Run Tests

```bash
# All tests
flutter test

# Specific test file
flutter test test/widget_test.dart

# With coverage
flutter test --coverage
```

### Integration Tests

```bash
# Run integration tests
flutter test integration_test

# On specific device
flutter test integration_test -d <device-id>
```

## Troubleshooting

### Common Issues

**1. Flutter doctor shows issues**
```bash
flutter doctor -v
# Follow the instructions to fix each issue
```

**2. Pub get fails**
```bash
flutter clean
flutter pub cache repair
flutter pub get
```

**3. Build fails**
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

**4. iOS build fails**
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter build ios
```

**5. Android build fails**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter build apk
```

### Getting Help

- Flutter documentation: https://flutter.dev/docs
- Supabase documentation: https://supabase.com/docs
- Project issues: [GitHub Issues]

## Next Steps

1. Read `ARCHITECTURE.md` for project structure
2. Review `README.md` for development guidelines
3. Check `docs/` for feature-specific documentation
4. Start developing!

## Useful Commands

```bash
# Check Flutter version
flutter --version

# Upgrade Flutter
flutter upgrade

# List devices
flutter devices

# Run with hot reload
flutter run

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release

# Analyze code
flutter analyze

# Format code
flutter format .

# Generate code
flutter pub run build_runner build

# Watch for changes
flutter pub run build_runner watch

# Clean build
flutter clean

# Update dependencies
flutter pub upgrade
```
