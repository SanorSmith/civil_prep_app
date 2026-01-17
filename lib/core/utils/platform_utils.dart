import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class PlatformUtils {
  static bool get isWeb => kIsWeb;
  
  static bool get isMobile {
    if (kIsWeb) return false;
    try {
      return Platform.isAndroid || Platform.isIOS;
    } catch (e) {
      return false;
    }
  }
  
  static bool get isAndroid {
    if (kIsWeb) return false;
    try {
      return Platform.isAndroid;
    } catch (e) {
      return false;
    }
  }
  
  static bool get isIOS {
    if (kIsWeb) return false;
    try {
      return Platform.isIOS;
    } catch (e) {
      return false;
    }
  }
  
  static bool get supportsNotifications => !isWeb;
  static bool get supportsHaptics => !isWeb;
  static bool get supportsFileDownload => true; // Works on all platforms
  
  static String get platformName {
    if (isWeb) return 'Web';
    if (isAndroid) return 'Android';
    if (isIOS) return 'iOS';
    return 'Unknown';
  }
}
