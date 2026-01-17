import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../app.dart';

class LanguageSelectionScreen extends ConsumerWidget {
  const LanguageSelectionScreen({super.key});

  Future<void> _selectLanguage(BuildContext context, WidgetRef ref, String languageCode) async {
    // Save language preference
    await StorageService.saveLanguage(languageCode);
    
    // Update app locale
    ref.read(localeProvider.notifier).state = Locale(languageCode);
    
    // Navigate to onboarding
    if (context.mounted) {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E1E1E),
              Color(0xFF121212),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Icon/Logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFF005AA0),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.shield,
                    size: 64,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                
                // App Name
                const Text(
                  'Civil Beredskap',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Subtitle in both languages
                const Text(
                  'Civil Preparedness',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFB0B0B0),
                  ),
                ),
                const SizedBox(height: 64),
                
                // Language Selection Title
                const Text(
                  'Välj språk / Choose Language',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                
                // Swedish Button
                _buildLanguageButton(
                  context: context,
                  ref: ref,
                  languageCode: 'sv',
                  flag: '🇸🇪',
                  languageName: 'Svenska',
                  subtitle: 'Swedish',
                ),
                const SizedBox(height: 16),
                
                // English Button
                _buildLanguageButton(
                  context: context,
                  ref: ref,
                  languageCode: 'en',
                  flag: '🇬🇧',
                  languageName: 'English',
                  subtitle: 'Engelska',
                ),
                
                const Spacer(),
                
                // Footer text
                const Text(
                  'Du kan ändra språket senare i inställningar\nYou can change the language later in settings',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF808080),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton({
    required BuildContext context,
    required WidgetRef ref,
    required String languageCode,
    required String flag,
    required String languageName,
    required String subtitle,
  }) {
    return InkWell(
      onTap: () => _selectLanguage(context, ref, languageCode),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF404040),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Flag
            Text(
              flag,
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(width: 20),
            
            // Language name and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    languageName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFB0B0B0),
                    ),
                  ),
                ],
              ),
            ),
            
            // Arrow icon
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF808080),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
