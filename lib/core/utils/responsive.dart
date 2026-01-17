import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }
  
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1200;
  }
  
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }
  
  static double getMaxWidth(BuildContext context) {
    if (isMobile(context)) return double.infinity;
    if (isTablet(context)) return 800;
    return 1200;
  }
  
  static EdgeInsets getScreenPadding(BuildContext context) {
    if (isMobile(context)) return const EdgeInsets.all(16);
    if (isTablet(context)) return const EdgeInsets.all(32);
    return const EdgeInsets.all(48);
  }
}
