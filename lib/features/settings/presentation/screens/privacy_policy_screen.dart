import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Integritetspolicy'),
        backgroundColor: const Color(0xFF1E1E1E),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Integritetspolicy för Civil Beredskap',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          
          _buildSection(
            'Datainsamling',
            'Vi samlar endast in den information du aktivt delar med oss:\n\n'
            '• Postnummer (för områdesstatistik)\n'
            '• Hushållsstorlek (för beräkning av beredskapsbehov)\n'
            '• Boendetyp (för anpassade rekommendationer)\n'
            '• Beredskapsstatus (för progress tracking)',
          ),
          
          _buildSection(
            'K-anonymitet',
            'Vi skyddar din integritet genom k-anonymitet:\n\n'
            '• Områdesstatistik visas endast när minst 50 hushåll deltar\n'
            '• Ingen individuell data kan identifieras\n'
            '• All data är anonymiserad och aggregerad',
          ),
          
          _buildSection(
            'Dataanvändning',
            'Din data används endast för:\n\n'
            '• Att beräkna dina beredskapsbehov\n'
            '• Att visa områdesstatistik (anonymiserad)\n'
            '• Att ge påminnelser om underhåll\n'
            '• Att förbättra appen',
          ),
          
          _buildSection(
            'Datalagring',
            'Din data lagras säkert:\n\n'
            '• Krypterad lagring\n'
            '• Regelbundna säkerhetskopior\n'
            '• Du kan exportera din data när som helst\n'
            '• Du kan radera ditt konto och all data',
          ),
          
          _buildSection(
            'Dina rättigheter',
            'Du har rätt att:\n\n'
            '• Se all data vi har om dig\n'
            '• Exportera din data\n'
            '• Radera ditt konto\n'
            '• Avstå från dataanonym delning',
          ),
          
          const SizedBox(height: 24),
          const Text(
            'Senast uppdaterad: 2026-01-17',
            style: TextStyle(color: Colors.white60, fontSize: 12),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSection(String title, String content) {
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
}
