import 'dart:io';
import 'dart:convert';

/// Validates that requirements are met in the codebase
class RequirementValidator {
  /// Validate all requirement specifications
  Future<RequirementComplianceResults> validateAll() async {
    final results = RequirementComplianceResults();

    // Load and validate Phase 1 requirements
    await _validatePhase('test/requirement_specs/phase_1_requirements.json', results);

    // Load and validate Phase 2 requirements
    await _validatePhase('test/requirement_specs/phase_2_requirements.json', results);

    return results;
  }

  Future<void> _validatePhase(String specPath, RequirementComplianceResults results) async {
    final file = File(specPath);
    
    if (!await file.exists()) {
      print('  ⚠️  Requirement spec not found: $specPath');
      return;
    }

    try {
      final content = await file.readAsString();
      final spec = jsonDecode(content) as Map<String, dynamic>;
      final requirements = spec['requirements'] as List<dynamic>;

      for (final req in requirements) {
        final requirement = req as Map<String, dynamic>;
        final result = await _checkRequirement(requirement);
        results.addRequirement(result);
      }
    } catch (e) {
      print('  ⚠️  Error loading spec $specPath: $e');
    }
  }

  Future<RequirementResult> _checkRequirement(Map<String, dynamic> requirement) async {
    final id = requirement['id'] as String;
    final description = requirement['description'] as String;
    final checkType = requirement['check_type'] as String;
    final checkValue = requirement['check_value'] as String;

    bool met = false;
    String? notes;

    switch (checkType) {
      case 'file_exists':
        met = await _checkFileExists(checkValue);
        notes = met ? 'File found' : 'File not found';
        break;

      case 'screen_exists':
        met = await _checkScreenExists(checkValue);
        notes = met ? 'Screen file found' : 'Screen file not found';
        break;

      case 'class_exists':
        met = await _checkClassExists(checkValue);
        notes = met ? 'Class found in codebase' : 'Class not found';
        break;

      case 'function_exists':
        met = await _checkFunctionExists(checkValue);
        notes = met ? 'Function found in codebase' : 'Function not found';
        break;

      case 'color_defined':
        met = await _checkColorDefined(checkValue);
        notes = met ? 'Color defined' : 'Color not defined';
        break;

      default:
        notes = 'Unknown check type: $checkType';
    }

    return RequirementResult(
      id: id,
      description: description,
      met: met,
      notes: notes,
    );
  }

  Future<bool> _checkFileExists(String path) async {
    final file = File('lib/$path');
    return await file.exists();
  }

  Future<bool> _checkScreenExists(String screenName) async {
    final possiblePaths = [
      'lib/features/onboarding/presentation/screens/${screenName}.dart',
      'lib/features/home/presentation/screens/${screenName}.dart',
      'lib/features/preparedness/presentation/screens/${screenName}.dart',
      'lib/features/crisis_guide/presentation/screens/${screenName}.dart',
      'lib/features/area/presentation/screens/${screenName}.dart',
    ];

    for (final path in possiblePaths) {
      final file = File(path);
      if (await file.exists()) {
        return true;
      }
    }
    return false;
  }

  Future<bool> _checkClassExists(String className) async {
    return await _searchCodebase(className);
  }

  Future<bool> _checkFunctionExists(String functionName) async {
    return await _searchCodebase(functionName);
  }

  Future<bool> _checkColorDefined(String colorName) async {
    final file = File('lib/core/theme/app_colors.dart');
    if (!await file.exists()) {
      return false;
    }

    final content = await file.readAsString();
    return content.contains(colorName);
  }

  Future<bool> _searchCodebase(String searchTerm) async {
    final libDir = Directory('lib');
    if (!await libDir.exists()) {
      return false;
    }

    await for (final entity in libDir.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        final content = await entity.readAsString();
        if (content.contains(searchTerm)) {
          return true;
        }
      }
    }

    return false;
  }
}

/// Results of requirement compliance validation
class RequirementComplianceResults {
  final List<RequirementResult> requirements = [];

  void addRequirement(RequirementResult result) {
    requirements.add(result);
  }

  int get totalCount => requirements.length;

  int get metCount => requirements.where((r) => r.met).length;

  int get notMetCount => requirements.where((r) => !r.met).length;

  int get partialCount => 0; // For future use

  List<RequirementResult> get metRequirements =>
      requirements.where((r) => r.met).toList();

  List<RequirementResult> get notMetRequirements =>
      requirements.where((r) => !r.met).toList();
}

/// Result for a single requirement
class RequirementResult {
  final String id;
  final String description;
  final bool met;
  final String? notes;

  RequirementResult({
    required this.id,
    required this.description,
    required this.met,
    this.notes,
  });
}
