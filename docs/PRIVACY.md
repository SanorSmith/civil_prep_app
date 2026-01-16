# Privacy & Data Protection

## Overview

The Civil Preparedness App is designed with **privacy by default** and follows GDPR principles. This document outlines our privacy measures and data handling practices.

## Core Privacy Principles

### 1. Data Minimization
We collect only the absolute minimum data required:
- **Postal code** (4 digits) - for location-based alerts
- **App preferences** - stored locally only
- **Anonymous usage statistics** - aggregated only

### 2. No Personal Identifiers
We explicitly **DO NOT** collect:
- ❌ Name
- ❌ Email address
- ❌ Phone number
- ❌ GPS coordinates
- ❌ Device identifiers
- ❌ IP addresses (not logged)
- ❌ User accounts

### 3. Local-First Storage
- All user data stored on device
- Encrypted sensitive data
- No cloud backup of personal data
- User controls all data

## Data Categories

### Stored Locally (Encrypted)
| Data Type | Purpose | Encryption | Retention |
|-----------|---------|------------|-----------|
| Postal code | Location-based alerts | AES-256 | Until user deletes |
| User preferences | App settings | AES-256 | Until user deletes |
| Personal checklists | User customization | AES-256 | Until user deletes |
| Notes | User annotations | AES-256 | Until user deletes |

### Stored Locally (Unencrypted Cache)
| Data Type | Purpose | Encryption | Retention |
|-----------|---------|------------|-----------|
| Alert cache | Offline access | None (public data) | 7 days |
| Info articles | Offline access | None (public data) | 7 days |
| Checklist templates | Offline access | None (public data) | 7 days |

### Stored Remotely (Supabase)
| Data Type | Purpose | Anonymization | Retention |
|-----------|---------|---------------|-----------|
| Aggregated statistics | Service improvement | K-anonymity (k≥50) | 90 days |
| Alert data | Public information | N/A (public) | Per alert expiry |
| Info articles | Public information | N/A (public) | Indefinite |

## K-Anonymity Implementation

### What is K-Anonymity?
K-anonymity ensures that any individual cannot be distinguished from at least k-1 other individuals in a dataset. We use **k=50** as our threshold.

### How We Implement It

```
Postal Code Area → User Count Check → Aggregation Decision

Example:
- Postal code 123: 75 users ✓ Can aggregate
- Postal code 456: 30 users ✗ Cannot aggregate
```

### Aggregated Data Examples

**Safe to aggregate:**
```json
{
  "postal_code_prefix": "12",
  "metric": "checklist_completion_rate",
  "value": 0.65,
  "user_count": 150,
  "date": "2024-01-15"
}
```

**Not aggregated (too few users):**
- Individual user data never sent
- Areas with <50 users excluded from statistics
- No cross-referencing possible

## Encryption Details

### Local Storage Encryption

**Algorithm:** AES-256-CBC
**Key Management:**
- Unique key per device
- Stored in Flutter Secure Storage
- Never transmitted
- Regenerated on app reinstall

**Encrypted Boxes:**
```dart
// Settings (postal code, preferences)
Box<dynamic> settings = await Hive.openBox(
  'settings',
  encryptionCipher: HiveAesCipher(encryptionKey),
);

// User data (checklists, notes)
Box<dynamic> userData = await Hive.openBox(
  'user_data',
  encryptionCipher: HiveAesCipher(encryptionKey),
);
```

### Network Encryption

- **HTTPS only** for all network requests
- **Certificate pinning** in production builds
- **TLS 1.3** minimum
- No fallback to HTTP

## Data Flow

### Alert Retrieval
```
1. User opens app
2. App checks local cache (encrypted)
3. If online: Fetch new alerts from Supabase
4. Filter by postal code (client-side)
5. Store in local cache
6. Display to user

No personal data sent to server
```

### Statistics Upload (Anonymous)
```
1. User completes checklist
2. App increments local counter
3. Background sync checks:
   - Is user online?
   - Is k-anonymity threshold met for postal code?
4. If yes: Upload aggregated count only
5. If no: Keep data local only

Server receives: {"postal_prefix": "12", "count": +1}
Server never receives: User ID, exact postal code, or individual data
```

## User Rights (GDPR)

### Right to Access
Users can view all stored data:
- Settings → Privacy → View My Data

### Right to Deletion
Users can delete all data:
- Settings → Privacy → Delete All Data
- Removes all local data
- No server-side data to delete (anonymous only)

### Right to Portability
Users can export data:
- Settings → Privacy → Export Data
- JSON format
- Includes all local data

### Right to Object
Users can disable statistics:
- Settings → Privacy → Disable Anonymous Statistics
- No data aggregation
- Full offline functionality maintained

## Third-Party Services

### Supabase (Backend)
- **Location:** EU region (GDPR compliant)
- **Data stored:** Public alerts, info articles, anonymous statistics
- **Privacy policy:** https://supabase.com/privacy
- **Data processing agreement:** Available

### Flutter Secure Storage
- **Purpose:** Encryption key storage
- **Location:** Device only
- **Data:** Encryption keys only

### No Analytics Services
We explicitly **DO NOT** use:
- ❌ Google Analytics
- ❌ Firebase Analytics
- ❌ Mixpanel
- ❌ Amplitude
- ❌ Any third-party analytics

## Network Requests

### What We Send
```http
GET /alerts?postal_prefix=12
Authorization: Bearer <anon_key>
```

### What We Don't Send
- ❌ Full postal code
- ❌ Device identifiers
- ❌ User identifiers
- ❌ Location coordinates
- ❌ Cookies
- ❌ Tracking headers

## Security Measures

### Application Security
1. **Code obfuscation** in release builds
2. **Root/jailbreak detection**
3. **SSL pinning**
4. **Secure random generation**
5. **Memory clearing** for sensitive data

### Data Protection
1. **Encrypted storage** for sensitive data
2. **Secure key management**
3. **No data in logs** (production)
4. **No screenshots** of sensitive screens
5. **Biometric protection** option

## Compliance

### GDPR Compliance
✅ Lawful basis: Legitimate interest (public safety)
✅ Data minimization
✅ Purpose limitation
✅ Storage limitation
✅ Integrity and confidentiality
✅ Accountability

### Swedish Data Protection Law
✅ Compliant with Dataskyddslagen
✅ Aligned with MSB guidelines
✅ No sensitive personal data processing

## Incident Response

### Data Breach Protocol
1. **Detection:** Automated monitoring
2. **Assessment:** Severity evaluation
3. **Notification:** Within 72 hours (if applicable)
4. **Mitigation:** Immediate action
5. **Documentation:** Full incident log

### User Notification
Users will be notified if:
- Personal data is compromised
- Security vulnerability affects them
- Changes to privacy policy

## Privacy by Design

### Development Practices
- Privacy impact assessments
- Security code reviews
- Penetration testing
- Regular audits
- Minimal permissions

### Default Settings
- Statistics: **Enabled** (anonymous only)
- Location: **Postal code only**
- Notifications: **User choice**
- Data sharing: **None**

## Transparency

### Open Source
- Code available for audit
- Security researchers welcome
- Responsible disclosure program

### Regular Updates
- Privacy policy reviews (quarterly)
- Security updates (as needed)
- User communication (transparent)

## Contact

For privacy concerns:
- Email: [privacy@civilprep.se]
- Data Protection Officer: [dpo@civilprep.se]
- Response time: 48 hours

## Changes to Privacy Policy

Users will be notified of:
- Material changes to data collection
- New third-party services
- Changes to retention periods

**Last updated:** 2024-01-16
**Version:** 1.0
