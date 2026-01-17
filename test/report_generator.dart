import 'dart:io';
import 'dart:convert';
import 'automated_test_runner.dart';

/// Generates test reports in various formats
class ReportGenerator {
  /// Generate main markdown report
  Future<void> generateMainReport(TestResults results) async {
    final buffer = StringBuffer();

    // Header
    buffer.writeln('# Civil Preparedness App - Test Report');
    buffer.writeln('');
    buffer.writeln('**Generated:** ${DateTime.now().toIso8601String()}');
    buffer.writeln('');

    // Summary Table
    buffer.writeln('## Summary');
    buffer.writeln('');
    buffer.writeln('| Category | Passed | Failed | Total |');
    buffer.writeln('|----------|--------|--------|-------|');

    for (final category in results.categories) {
      buffer.writeln('| ${category.category} | ${category.passedCount} | ${category.failedCount} | ${category.totalCount} |');
    }

    final reqResults = results.requirementResults;
    if (reqResults != null) {
      buffer.writeln('| **Requirements** | ${reqResults.metCount} | ${reqResults.notMetCount} | ${reqResults.totalCount} |');
    }

    buffer.writeln('');

    // Detailed Results by Category
    buffer.writeln('## Detailed Results');
    buffer.writeln('');

    for (final category in results.categories) {
      buffer.writeln('### ${category.category}');
      buffer.writeln('');

      for (final file in category.files) {
        final icon = file.passed ? '✅' : '❌';
        buffer.writeln('- $icon ${file.filePath}');
        if (file.error != null) {
          buffer.writeln('  - Error: ${file.error}');
        }
      }

      buffer.writeln('');
    }

    // Requirements Compliance
    if (reqResults != null) {
      buffer.writeln('### Requirements Compliance');
      buffer.writeln('');

      // Not met requirements
      if (reqResults.notMetRequirements.isNotEmpty) {
        buffer.writeln('#### ❌ Not Met (${reqResults.notMetCount})');
        buffer.writeln('');
        for (final req in reqResults.notMetRequirements) {
          buffer.writeln('- **${req.id}:** ${req.description}');
          if (req.notes != null) {
            buffer.writeln('  - ${req.notes}');
          }
        }
        buffer.writeln('');
      }

      // Met requirements
      if (reqResults.metRequirements.isNotEmpty) {
        buffer.writeln('#### ✅ Met (${reqResults.metCount})');
        buffer.writeln('');
        for (final req in reqResults.metRequirements) {
          buffer.writeln('- **${req.id}:** ${req.description}');
        }
        buffer.writeln('');
      }
    }

    // Critical Issues
    buffer.writeln('## Critical Issues');
    buffer.writeln('');

    final criticalIssues = _findCriticalIssues(results);
    if (criticalIssues.isEmpty) {
      buffer.writeln('✅ No critical issues found!');
    } else {
      for (final issue in criticalIssues) {
        buffer.writeln('- ⚠️  $issue');
      }
    }

    buffer.writeln('');

    // Save report
    await _saveReport('test_reports/latest_report.md', buffer.toString());
  }

  /// Generate Windsurf fix instructions
  Future<void> generateWindsurfInstructions(TestResults results) async {
    final buffer = StringBuffer();

    buffer.writeln('# Windsurf Fix Instructions');
    buffer.writeln('');
    buffer.writeln('Copy and paste this into Windsurf to fix all issues:');
    buffer.writeln('');
    buffer.writeln('```');

    final issues = _collectAllIssues(results);
    
    if (issues.isEmpty) {
      buffer.writeln('🎉 No issues found! All tests passing.');
    } else {
      buffer.writeln('FIX THE FOLLOWING ISSUES:');
      buffer.writeln('');

      for (var i = 0; i < issues.length; i++) {
        buffer.writeln('${i + 1}. ${issues[i]}');
      }

      buffer.writeln('');
      buffer.writeln('STEPS:');
      buffer.writeln('1. Create any missing test files');
      buffer.writeln('2. Implement missing features');
      buffer.writeln('3. Fix failing tests');
      buffer.writeln('4. Run: bash ./scripts/run_all_tests.sh');
      buffer.writeln('5. Verify all tests pass');
    }

    buffer.writeln('```');
    buffer.writeln('');

    await _saveReport('test_reports/windsurf_instructions.md', buffer.toString());
  }

  /// Generate JSON report for programmatic access
  Future<void> generateJsonReport(TestResults results) async {
    final data = {
      'generated_at': DateTime.now().toIso8601String(),
      'summary': {
        'total_tests': results.totalTests,
        'passed_tests': results.passedTests,
        'failed_tests': results.failedTests,
        'total_requirements': results.requirementResults?.totalCount ?? 0,
        'met_requirements': results.requirementResults?.metCount ?? 0,
        'not_met_requirements': results.requirementResults?.notMetCount ?? 0,
      },
      'categories': results.categories.map((cat) => {
        'name': cat.category,
        'total': cat.totalCount,
        'passed': cat.passedCount,
        'failed': cat.failedCount,
        'files': cat.files.map((f) => {
          'path': f.filePath,
          'passed': f.passed,
          'error': f.error,
        }).toList(),
      }).toList(),
      'requirements': results.requirementResults?.requirements.map((req) => {
        'id': req.id,
        'description': req.description,
        'met': req.met,
        'notes': req.notes,
      }).toList() ?? [],
    };

    final jsonString = JsonEncoder.withIndent('  ').convert(data);
    await _saveReport('test_reports/requirement_compliance.json', jsonString);
  }

  List<String> _findCriticalIssues(TestResults results) {
    final issues = <String>[];

    // Check for missing critical test files
    for (final category in results.categories) {
      for (final file in category.files) {
        if (!file.passed && file.filePath.contains('next_steps_test')) {
          issues.add('CRITICAL: Next steps checkbox test missing - ${file.filePath}');
        }
        if (!file.passed && file.filePath.contains('onboarding_flow_test')) {
          issues.add('CRITICAL: Onboarding flow integration test missing - ${file.filePath}');
        }
      }
    }

    // Check for critical requirements not met
    final reqResults = results.requirementResults;
    if (reqResults != null) {
      for (final req in reqResults.notMetRequirements) {
        if (req.description.toLowerCase().contains('checkbox') ||
            req.description.toLowerCase().contains('save') ||
            req.description.toLowerCase().contains('privacy')) {
          issues.add('CRITICAL REQUIREMENT: ${req.id} - ${req.description}');
        }
      }
    }

    return issues;
  }

  List<String> _collectAllIssues(TestResults results) {
    final issues = <String>[];

    // Failed tests
    for (final category in results.categories) {
      for (final file in category.files) {
        if (!file.passed) {
          issues.add('Missing test file: ${file.filePath}');
        }
      }
    }

    // Unmet requirements
    final reqResults = results.requirementResults;
    if (reqResults != null) {
      for (final req in reqResults.notMetRequirements) {
        issues.add('Requirement not met: ${req.id} - ${req.description}');
      }
    }

    return issues;
  }

  Future<void> _saveReport(String path, String content) async {
    final file = File(path);
    await file.parent.create(recursive: true);
    await file.writeAsString(content);
  }
}
