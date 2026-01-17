import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/app_localizations.dart';

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
        if (!_isValid) {
          final l10n = AppLocalizations.of(context);
          _errorMessage = l10n.t('invalid_postal');
        } else {
          _errorMessage = null;
        }
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
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.t('app_name')),
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
              Text(
                l10n.t('step_1_of_4'),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.t('postal_code'),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.t('enter_postal_code'),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
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
                  labelText: l10n.t('postal_code'),
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
                child: Text(
                  l10n.t('next_btn'),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.go('/onboarding'),
                child: Text(l10n.t('back')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
