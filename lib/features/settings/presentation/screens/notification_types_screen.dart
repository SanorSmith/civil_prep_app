import 'package:flutter/material.dart';

class NotificationTypesScreen extends StatefulWidget {
  final Map<String, bool> initialTypes;
  
  const NotificationTypesScreen({
    super.key,
    required this.initialTypes,
  });
  
  @override
  State<NotificationTypesScreen> createState() => _NotificationTypesScreenState();
}

class _NotificationTypesScreenState extends State<NotificationTypesScreen> {
  late Map<String, bool> types;
  
  @override
  void initState() {
    super.initState();
    types = Map.from(widget.initialTypes);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Notifikationstyper'),
        backgroundColor: const Color(0xFF1E1E1E),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, types),
            child: const Text('Spara', style: TextStyle(color: Color(0xFF2196F3))),
          ),
        ],
      ),
      body: ListView(
        children: [
          CheckboxListTile(
            title: const Text('Underhåll & rotering', style: TextStyle(color: Colors.white)),
            subtitle: const Text(
              'Påminnelser om att rotera vatten, kontrollera mat, etc.',
              style: TextStyle(color: Colors.white60, fontSize: 12),
            ),
            value: types['maintenance'] ?? true,
            onChanged: (val) => setState(() => types['maintenance'] = val!),
          ),
          CheckboxListTile(
            title: const Text('Utgångsdatum', style: TextStyle(color: Colors.white)),
            subtitle: const Text(
              'Varningar när mat eller medicin snart går ut',
              style: TextStyle(color: Colors.white60, fontSize: 12),
            ),
            value: types['expiration'] ?? true,
            onChanged: (val) => setState(() => types['expiration'] = val!),
          ),
          CheckboxListTile(
            title: const Text('Beredskapstips', style: TextStyle(color: Colors.white)),
            subtitle: const Text(
              'Användbara tips och råd om beredskap',
              style: TextStyle(color: Colors.white60, fontSize: 12),
            ),
            value: types['tips'] ?? false,
            onChanged: (val) => setState(() => types['tips'] = val!),
          ),
          CheckboxListTile(
            title: const Text('Områdesuppdateringar', style: TextStyle(color: Colors.white)),
            subtitle: const Text(
              'Information om beredskapsnivå i ditt område',
              style: TextStyle(color: Colors.white60, fontSize: 12),
            ),
            value: types['area'] ?? false,
            onChanged: (val) => setState(() => types['area'] = val!),
          ),
        ],
      ),
    );
  }
}
