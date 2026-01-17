import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../app.dart';
import 'privacy_policy_screen.dart';
import 'notification_types_screen.dart';
import 'about_screen.dart';
import '../../../home/presentation/providers/home_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String _postalCode = '11522';
  int _adults = 3;
  int _children = 0;
  int _infants = 0;
  String _housingType = 'Lägenhet';
  bool _shareAnonymousData = true;
  bool _notificationsEnabled = true;
  String _frequency = 'Veckovis';
  Map<String, bool> _notificationTypes = {
    'maintenance': true,
    'expiration': true,
    'tips': false,
    'area': false,
  };
  TimeOfDay _quietStart = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _quietEnd = const TimeOfDay(hour: 8, minute: 0);
  DateTime _lastSync = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final profile = await StorageService.getHouseholdProfile();
    if (profile != null && mounted) {
      setState(() {
        _postalCode = profile.postalCode;
        _adults = profile.adultCount;
        _children = profile.childCount;
        _infants = profile.infantCount;
        _housingType = _getHousingTypeLabel(profile.housingType);
        _shareAnonymousData = profile.allowAggregation;
      });
    }
  }

  String _getHousingTypeLabel(dynamic type) {
    if (type.toString().contains('apartment')) return 'Lägenhet';
    if (type.toString().contains('house')) return 'Villa';
    if (type.toString().contains('rural')) return 'Lantbruk';
    return 'Lägenhet';
  }

  String _getHouseholdSummary() {
    final parts = <String>[];
    if (_adults > 0) parts.add('$_adults ${_adults == 1 ? "vuxen" : "vuxna"}');
    if (_children > 0) parts.add('$_children barn');
    if (_infants > 0) parts.add('$_infants spädbarn');
    return parts.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.t('settings')),
      ),
      body: ListView(
        children: [
          // PROFIL Section
          _buildSectionHeader(l10n.t('profile')),
          _buildListTile(
            l10n.t('postal_code'),
            _postalCode,
            Icons.location_on,
            _editPostalCode,
          ),
          _buildListTile(
            l10n.t('household'),
            _getHouseholdSummary(),
            Icons.people,
            _editHousehold,
          ),
          _buildListTile(
            l10n.t('housing_type'),
            _housingType,
            Icons.home,
            _editHousingType,
          ),
          const Divider(height: 32),

          // INTEGRITET Section
          _buildSectionHeader(l10n.t('privacy_caps')),
          _buildSwitchTile(
            l10n.t('share_data'),
            l10n.t('share_data_desc'),
            _shareAnonymousData,
            (value) {
              setState(() => _shareAnonymousData = value);
            },
          ),
          _buildListTile(
            l10n.t('privacy_policy'),
            null,
            Icons.privacy_tip,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyScreen(),
                ),
              );
            },
          ),
          const Divider(height: 32),

          // NOTIFIKATIONER Section
          _buildSectionHeader(l10n.t('notifications')),
          _buildSwitchTile(
            l10n.t('enable_notifications'),
            l10n.t('notification_subtitle'),
            _notificationsEnabled,
            (value) {
              setState(() => _notificationsEnabled = value);
            },
          ),
          _buildListTile(
            l10n.t('frequency'),
            _frequency,
            Icons.schedule,
            _selectFrequency,
          ),
          _buildListTile(
            l10n.t('types'),
            null,
            Icons.notifications_active,
            _selectNotificationTypes,
          ),
          _buildListTile(
            l10n.t('quiet_hours'),
            '${_quietStart.format(context)} - ${_quietEnd.format(context)}',
            Icons.nightlight_round,
            _selectQuietHours,
          ),
          const Divider(height: 32),

          // DATA & SYNK Section
          _buildSectionHeader(l10n.t('data_sync')),
          _buildListTile(
            l10n.t('last_sync'),
            'Idag, ${_lastSync.hour}:${_lastSync.minute.toString().padLeft(2, '0')}',
            Icons.sync,
            null,
          ),
          _buildActionTile(
            l10n.t('sync_now'),
            Icons.refresh,
            _syncNow,
          ),
          _buildListTile(
            l10n.t('clear_cache'),
            null,
            Icons.cleaning_services,
            _clearCache,
          ),
          const Divider(height: 32),

          // APP Section
          _buildSectionHeader(l10n.t('app')),
          _buildSwitchTile(
            l10n.t('dark_theme'),
            l10n.t('use_dark_theme'),
            isDark,
            (value) async {
              // Save theme preference
              await StorageService.saveThemeMode(value ? 'dark' : 'light');
              
              // Update app theme
              ref.read(themeModeProvider.notifier).state = 
                value ? ThemeMode.dark : ThemeMode.light;
            },
          ),
          _buildListTile(
            l10n.t('version'),
            '1.0.0',
            Icons.info,
            null,
          ),
          _buildListTile(
            l10n.t('about'),
            null,
            Icons.help,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              );
            },
          ),
          const Divider(height: 32),

          // KONTO Section
          _buildSectionHeader(l10n.t('account')),
          _buildListTile(
            l10n.t('export_data'),
            null,
            Icons.download,
            _exportData,
          ),
          _buildDestructiveTile(
            l10n.t('delete_account'),
            Icons.delete_forever,
            () {
              _showDeleteAccountDialog();
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppTheme.textSecondary(context),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildListTile(
    String title,
    String? subtitle,
    IconData icon,
    VoidCallback? onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.textSecondary(context)),
      title: Text(
        title,
        style: TextStyle(color: AppTheme.textPrimary(context)),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(color: AppTheme.textSecondary(context)),
            )
          : null,
      trailing: onTap != null
          ? Icon(Icons.chevron_right, color: AppTheme.textSecondary(context))
          : null,
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: TextStyle(color: AppTheme.textPrimary(context)),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: AppTheme.textSecondary(context)),
      ),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildActionTile(
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.primary),
      onTap: onTap,
    );
  }

  Widget _buildDestructiveTile(
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppColors.error),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.error,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.error),
      onTap: onTap,
    );
  }

  Future<void> _editPostalCode() async {
    final controller = TextEditingController(text: _postalCode);
    
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Ändra postnummer', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          maxLength: 5,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: '11522',
            hintStyle: TextStyle(color: Colors.white38),
            counterStyle: TextStyle(color: Colors.white38),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Avbryt', style: TextStyle(color: Colors.white60)),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.length == 5) {
                Navigator.pop(context, controller.text);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Postnummer måste vara 5 siffror')),
                );
              }
            },
            child: const Text('Spara'),
          ),
        ],
      ),
    );
    
    if (result != null) {
      setState(() => _postalCode = result);
    }
  }

  Future<void> _editHousehold() async {
    int adults = _adults;
    int children = _children;
    int infants = _infants;
    
    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text('Ändra hushåll', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Vuxna', style: TextStyle(color: Colors.white)),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, color: Colors.white),
                        onPressed: adults > 1
                          ? () => setDialogState(() => adults--)
                          : null,
                      ),
                      Text('$adults', style: const TextStyle(color: Colors.white, fontSize: 18)),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () => setDialogState(() => adults++),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Barn', style: TextStyle(color: Colors.white)),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, color: Colors.white),
                        onPressed: children > 0
                          ? () => setDialogState(() => children--)
                          : null,
                      ),
                      Text('$children', style: const TextStyle(color: Colors.white, fontSize: 18)),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () => setDialogState(() => children++),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Spädbarn', style: TextStyle(color: Colors.white)),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, color: Colors.white),
                        onPressed: infants > 0
                          ? () => setDialogState(() => infants--)
                          : null,
                      ),
                      Text('$infants', style: const TextStyle(color: Colors.white, fontSize: 18)),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () => setDialogState(() => infants++),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Avbryt', style: TextStyle(color: Colors.white60)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _adults = adults;
                  _children = children;
                  _infants = infants;
                });
              },
              child: const Text('Spara'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editHousingType() async {
    final types = ['Lägenhet', 'Villa', 'Lantbruk'];
    
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Välj boendetyp', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: types.map((type) => RadioListTile<String>(
            title: Text(type, style: const TextStyle(color: Colors.white)),
            value: type,
            groupValue: _housingType,
            onChanged: (value) => Navigator.pop(context, value),
          )).toList(),
        ),
      ),
    );
    
    if (result != null) {
      setState(() => _housingType = result);
    }
  }

  Future<void> _selectFrequency() async {
    final frequencies = ['Daglig', 'Veckovis', 'Månatlig'];
    
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Välj frekvens', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: frequencies.map((freq) => RadioListTile<String>(
            title: Text(freq, style: const TextStyle(color: Colors.white)),
            value: freq,
            groupValue: _frequency,
            onChanged: (value) => Navigator.pop(context, value),
          )).toList(),
        ),
      ),
    );
    
    if (result != null) {
      setState(() => _frequency = result);
    }
  }

  Future<void> _selectNotificationTypes() async {
    final result = await Navigator.push<Map<String, bool>>(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationTypesScreen(
          initialTypes: _notificationTypes,
        ),
      ),
    );
    
    if (result != null) {
      setState(() => _notificationTypes = result);
    }
  }

  Future<void> _selectQuietHours() async {
    final startTime = await showTimePicker(
      context: context,
      initialTime: _quietStart,
      helpText: 'Välj starttid',
    );
    
    if (startTime == null) return;
    
    final endTime = await showTimePicker(
      context: context,
      initialTime: _quietEnd,
      helpText: 'Välj sluttid',
    );
    
    if (endTime == null) return;
    
    setState(() {
      _quietStart = startTime;
      _quietEnd = endTime;
    });
  }

  Future<void> _syncNow() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    
    try {
      await ref.read(homeProvider.notifier).loadData();
      await ref.read(homeProvider.notifier).refreshProgress();
      
      if (mounted) {
        Navigator.pop(context);
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Synkad!'),
              ],
            ),
            backgroundColor: Color(0xFF4CAF50),
          ),
        );
        
        setState(() => _lastSync = DateTime.now());
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Synkning misslyckades'),
            backgroundColor: Color(0xFFF44336),
          ),
        );
      }
    }
  }

  Future<void> _clearCache() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Rensa cache?', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Detta kommer att radera tillfälliga filer och frigöra utrymme. Dina inställningar och data påverkas inte.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Avbryt'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Rensa'),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cache rensad')),
      );
    }
  }

  Future<void> _exportData() async {
    try {
      final profile = await StorageService.getHouseholdProfile();
      final user = await StorageService.getUserProfile();
      
      final userData = {
        'profile': {
          'postal_code': _postalCode,
          'adults': _adults,
          'children': _children,
          'infants': _infants,
          'housing_type': _housingType,
        },
        'settings': {
          'notifications_enabled': _notificationsEnabled,
          'notification_frequency': _frequency,
        },
        'exported_at': DateTime.now().toIso8601String(),
      };
      
      final jsonString = jsonEncode(userData);
      
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/civil_beredskap_export_${DateTime.now().millisecondsSinceEpoch}.json');
      await file.writeAsString(jsonString);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data exporterad: ${file.path}'),
            backgroundColor: const Color(0xFF4CAF50),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Export misslyckades'),
            backgroundColor: Color(0xFFF44336),
          ),
        );
      }
    }
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Ta bort konto?', style: TextStyle(color: Colors.white)),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detta kommer att permanent radera:',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 8),
            Text(
              '• Din profil och inställningar\n'
              '• All beredskapsstatus\n'
              '• Alla checklistor och progress\n'
              '• Alla påminnelser',
              style: TextStyle(color: Colors.white60, fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              'Denna åtgärd kan inte ångras!',
              style: TextStyle(
                color: Color(0xFFF44336),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Avbryt'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Konto raderat (demo)'),
                  backgroundColor: Color(0xFF4CAF50),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF44336),
            ),
            child: const Text('Ta bort'),
          ),
        ],
      ),
    );
  }
}
