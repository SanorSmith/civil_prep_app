import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Om Civil Beredskap'),
        backgroundColor: const Color(0xFF1E1E1E),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF2196F3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.shield, size: 60, color: Colors.white),
            ),
          ),
          const SizedBox(height: 24),
          
          const Text(
            'Civil Beredskap',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Version 1.0.0',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white60,
            ),
          ),
          
          const SizedBox(height: 32),
          
          _buildInfoSection(
            'Om appen',
            'Civil Beredskap hjälper svenska hushåll att förbereda sig för kriser och nödsituationer enligt MSB:s (Myndigheten för samhällsskydd och beredskap) rekommendationer.',
          ),
          
          _buildInfoSection(
            'Funktioner',
            '• Anpassade checklister baserat på ditt hushåll\n'
            '• Påminnelser om underhåll och rotering\n'
            '• Områdesstatistik med k-anonymitet\n'
            '• Offline-tillgänglig krisguide\n'
            '• 24h, 72h och 7-dagars beredskapsnivåer',
          ),
          
          _buildInfoSection(
            'Dataskydd',
            'Din data skyddas med k-anonymitet. Vi visar endast områdesstatistik när minst 50 hushåll deltar. All data är krypterad och du kan exportera eller radera din data när som helst.',
          ),
          
          const SizedBox(height: 24),
          
          _buildLinkButton('MSB.se', () {}),
          _buildLinkButton('Kontakta support', () {}),
          _buildLinkButton('Rapportera bugg', () {}),
          
          const SizedBox(height: 24),
          
          const Text(
            '© 2026 Civil Beredskap\nUtvecklad för svenska hushåll',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white38,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2196F3),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLinkButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF2196F3),
          side: const BorderSide(color: Color(0xFF2196F3)),
          minimumSize: const Size(double.infinity, 48),
        ),
        child: Text(text),
      ),
    );
  }
}
