# Architecture Documentation

## Overview

The Civil Preparedness App follows Clean Architecture principles with a feature-based folder structure, ensuring maintainability, testability, and scalability.

## Core Principles

### 1. Offline-First Architecture
- All data stored locally by default
- Background synchronization when online
- Graceful degradation without network
- Optimistic UI updates

### 2. Privacy by Design
- No GPS tracking (postal code only)
- Encrypted local storage
- Anonymous data aggregation
- Minimal data collection

### 3. Clean Architecture Layers

```
┌─────────────────────────────────────┐
│      Presentation Layer             │
│  (UI, Pages, Widgets, Providers)    │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│       Domain Layer                  │
│  (Entities, Use Cases, Interfaces)  │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│        Data Layer                   │
│  (Repositories, Data Sources, DTOs) │
└─────────────────────────────────────┘
```

## Project Structure

```
lib/
├── core/                    # Shared across features
│   ├── config/             # App-wide configuration
│   ├── l10n/               # Internationalization
│   ├── models/             # Shared models
│   ├── providers/          # Global Riverpod providers
│   ├── router/             # Navigation configuration
│   ├── services/           # Core services
│   │   ├── storage_service.dart      # Local storage
│   │   ├── sync_service.dart         # Background sync
│   │   └── network_service.dart      # Connectivity
│   ├── theme/              # UI theming
│   └── utils/              # Helper functions
│
├── features/               # Feature modules
│   ├── alerts/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── alert_local_datasource.dart
│   │   │   │   └── alert_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── alert_model.dart
│   │   │   └── repositories/
│   │   │       └── alert_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── alert.dart
│   │   │   ├── repositories/
│   │   │   │   └── alert_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_alerts.dart
│   │   │       └── mark_alert_read.dart
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── widgets/
│   │       └── providers/
│   │
│   ├── checklist/          # Similar structure
│   ├── home/
│   ├── onboarding/
│   └── settings/
│
└── main.dart               # App entry point
```

## Data Flow

### Read Operation (Offline-First)
```
User Action
    ↓
Provider (Riverpod)
    ↓
Use Case
    ↓
Repository
    ↓
Local DataSource (Hive) → Return cached data
    ↓
Remote DataSource (Supabase) → Fetch if online
    ↓
Update Local Cache
    ↓
Return to UI
```

### Write Operation
```
User Action
    ↓
Provider (Riverpod)
    ↓
Use Case
    ↓
Repository
    ↓
Local DataSource (Hive) → Save immediately
    ↓
Sync Queue → Add to pending sync
    ↓
Background Sync (when online)
    ↓
Remote DataSource (Supabase)
```

## State Management

### Riverpod Architecture

```dart
// Provider types used:

// 1. Provider - Immutable, cached values
final configProvider = Provider<AppConfig>((ref) => AppConfig());

// 2. StateProvider - Simple mutable state
final counterProvider = StateProvider<int>((ref) => 0);

// 3. FutureProvider - Async data loading
final alertsProvider = FutureProvider<List<Alert>>((ref) async {
  return ref.read(alertRepositoryProvider).getAlerts();
});

// 4. StreamProvider - Real-time updates
final connectivityProvider = StreamProvider<ConnectivityStatus>((ref) {
  return ref.read(networkServiceProvider).connectivityStream;
});

// 5. NotifierProvider - Complex state logic
final alertNotifierProvider = NotifierProvider<AlertNotifier, AlertState>(
  () => AlertNotifier(),
);
```

## Storage Strategy

### Local Storage (Hive)

**Encrypted Boxes:**
- `settings` - User preferences, postal code
- `user_data` - Personal checklists, notes

**Unencrypted Boxes:**
- `cache` - Public data (alerts, info articles)

**Encryption:**
- AES-256 encryption
- Key stored in Flutter Secure Storage
- Per-device encryption keys

### Remote Storage (Supabase)

**Tables:**
- `alerts` - Emergency alerts
- `checklist_templates` - Default checklists
- `info_articles` - Information resources
- `aggregated_stats` - Anonymous usage data

**Row Level Security (RLS):**
- Public read access for alerts/info
- No direct user data storage
- Aggregated data only

## Synchronization

### Background Sync Service

```dart
class SyncService {
  // Sync interval: 6 hours
  static const syncInterval = Duration(hours: 6);
  
  Future<void> sync() async {
    if (!await _isOnline()) return;
    
    await _syncAlerts();
    await _syncChecklists();
    await _syncInfoArticles();
    await _uploadPendingData();
  }
}
```

### Conflict Resolution
- **Strategy**: Last-write-wins
- **Timestamp**: Server timestamp as source of truth
- **Merge**: No automatic merging (user data is local-only)

## Privacy & Anonymization

### K-Anonymity Implementation

```dart
class AnonymizationService {
  static const int kThreshold = 50;
  
  Future<bool> canAggregate(String postalCode) async {
    final count = await _getUserCountForPostalCode(postalCode);
    return count >= kThreshold;
  }
  
  Future<void> aggregateData(Map<String, dynamic> data) async {
    // Only aggregate if k-anonymity threshold met
    // Remove all identifiers
    // Upload aggregated statistics
  }
}
```

### Data Minimization
- No user accounts required
- No email/phone collection
- No GPS coordinates
- Postal code only (4-digit)
- No cross-session tracking

## Network Strategy

### Connectivity States
1. **Online** - Full sync enabled
2. **Limited** (3G) - Essential data only
3. **Offline** - Local data only

### Adaptive Loading
```dart
class NetworkService {
  Future<void> fetchData() async {
    final connectivity = await getConnectivity();
    
    switch (connectivity) {
      case ConnectivityType.wifi:
        await _fetchFullData();
        break;
      case ConnectivityType.mobile:
        await _fetchEssentialData();
        break;
      case ConnectivityType.none:
        // Use cached data only
        break;
    }
  }
}
```

## Error Handling

### Error Types
1. **Network Errors** - Graceful offline fallback
2. **Storage Errors** - Retry with exponential backoff
3. **Validation Errors** - User-friendly messages
4. **System Errors** - Crash reporting (anonymous)

### Error Boundaries
```dart
class ErrorHandler {
  static void handle(Object error, StackTrace stack) {
    if (error is NetworkException) {
      // Show offline banner
    } else if (error is StorageException) {
      // Retry or clear cache
    } else {
      // Log to crash reporting
    }
  }
}
```

## Testing Strategy

### Unit Tests
- Use cases
- Repositories
- Services
- Utilities

### Widget Tests
- Individual widgets
- Page layouts
- User interactions

### Integration Tests
- Complete user flows
- Offline scenarios
- Sync operations

## Performance Considerations

### Optimization Strategies
1. **Lazy Loading** - Load data on demand
2. **Pagination** - Limit data fetching
3. **Caching** - Aggressive local caching
4. **Image Optimization** - Compressed assets
5. **Code Splitting** - Deferred loading

### Memory Management
- Dispose providers when not needed
- Clear caches periodically
- Limit in-memory data size

## Security Measures

1. **Local Encryption** - Hive AES-256
2. **Secure Storage** - Flutter Secure Storage for keys
3. **HTTPS Only** - All network requests
4. **Certificate Pinning** - Production builds
5. **No Hardcoded Secrets** - Environment variables

## Accessibility

- **Screen Reader Support** - Semantic labels
- **High Contrast** - Theme support
- **Text Scaling** - Respect system settings
- **Touch Targets** - Minimum 48x48dp
- **Keyboard Navigation** - Full support

## Localization

### Supported Languages
- Swedish (sv_SE) - Primary
- English (en_US) - Secondary

### Implementation
- Flutter's built-in localization
- Separate translation files
- RTL support (future)

## Future Considerations

1. **Push Notifications** - Critical alerts
2. **Widget Support** - Home screen widgets
3. **Wear OS** - Smartwatch companion
4. **Tablet Optimization** - Adaptive layouts
5. **Web Version** - Progressive Web App
