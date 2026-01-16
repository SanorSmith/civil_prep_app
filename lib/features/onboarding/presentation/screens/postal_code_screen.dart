import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PostalCodeScreen extends ConsumerStatefulWidget {
  const PostalCodeScreen({super.key});

  @override
  ConsumerState<PostalCodeScreen> createState() => _PostalCodeScreenState();
}

class _PostalCodeScreenState extends ConsumerState<PostalCodeScreen> {
  final _postalCodeController = TextEditingController();
  bool _isValid = false;
  String? _errorMessage;

  @override
  void dispose() {
    _postalCodeController.dispose();
    super.dispose();
  }

  bool _validateSwedishPostalCode(String postalCode) {
    if (postalCode.length != 5) return false;
    
    final code = int.tryParse(postalCode);
    if (code == null) return false;
    
    return code >= 10000 && code <= 98499;
  }

  void _onPostalCodeChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        _isValid = false;
        _errorMessage = null;
      } else if (value.length == 5) {
        _isValid = _validateSwedishPostalCode(value);
        _errorMessage = _isValid ? null : 'Ogiltigt svenskt postnummer';
      } else {
        _isValid = false;
        _errorMessage = null;
      }
    });
  }

  void _onNextPressed() {
    if (_isValid) {
      context.go('/onboarding/household-profile', extra: {
        'postalCode': _postalCodeController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Civil Beredskap'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/onboarding'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Steg 1 av 4',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Ditt postnummer',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Vi använder detta för att beräkna dina behov och visa områdesstatistik',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _postalCodeController,
                keyboardType: TextInputType.number,
                maxLength: 5,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: _onPostalCodeChanged,
                decoration: InputDecoration(
                  labelText: 'Postnummer',
                  hintText: '11522',
                  prefixIcon: const Icon(Icons.location_on),
                  suffixIcon: _isValid
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  errorText: _errorMessage,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  counterText: '',
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _isValid ? _onNextPressed : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Nästa',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.go('/onboarding'),
                child: const Text('Tillbaka'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
