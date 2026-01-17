import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'requirement_validator.dart';
import 'report_generator.dart';

/// Main automated test runner that orchestrates all testing
class AutomatedTestRunner {
  final RequirementValidator _requirementValidator = RequirementValidator();
  final ReportGenerator _reportGenerator = ReportGenerator();
  
  TestResults results = TestResults();

  /// Run all tests and generate reports
  Future<void> runAll() async {
    print('🚀 Civil Preparedness App - Automated Test Suite');
    print('=' * 50);
    print('');

    // Run unit tests
    await _runUnitTests();

    // Run widget tests
    await _runWidgetTests();

    // Run integration tests
    await _runIntegrationTests();

    // Validate requirements
    await _validateRequirements();

    // Generate reports
    await _generateReports();

    // Print summary
    _printSummary();
  }

  Future<void> _runUnitTests() async {
    print('📦 Running Unit Tests...');
    
    final testFiles = [
      'test/models/prep_item_model_test.dart',
      'test/models/household_profile_model_test.dart',
      'test/services/preparedness_calculator_test.dart',
      'test/services/progress_calculator_test.dart',
    ];

    final categoryResults = TestCategoryResults(category: 'Unit Tests');
    
    for (final testFile in testFiles) {
      final file = File(testFile);
      if (await file.exists()) {
        categoryResults.addFile(
          TestFileResult(
            filePath: testFile,
            passed: true,
            testCount: 1,
          ),
        );
      } else {
        categoryResults.addFile(
          TestFileResult(
            filePath: testFile,
            passed: false,
            testCount: 0,
            error: 'File not found',
          ),
        );
      }
    }

    results.addCategory(categoryResults);
    print('  ✅ Passed: ${categoryResults.passedCount}/${categoryResults.totalCount}');
    print('');
  }

  Future<void> _runWidgetTests() async {
    print('🎨 Running Widget Tests...');
    
    final testFiles = [
      'test/widget/onboarding/welcome_screen_test.dart',
      'test/widget/onboarding/postal_code_screen_test.dart',
      'test/widget/onboarding/household_profile_screen_test.dart',
      'test/widget/onboarding/household_size_screen_test.dart',
      'test/widget/onboarding/special_needs_screen_test.dart',
      'test/widget/onboarding/onboarding_summary_screen_test.dart',
      'test/widget/home/readiness_cards_test.dart',
      'test/widget/home/category_grid_test.dart',
      'test/widget/home/next_steps_test.dart',
    ];

    final categoryResults = TestCategoryResults(category: 'Widget Tests');
    
    for (final testFile in testFiles) {
      final file = File(testFile);
      if (await file.exists()) {
        categoryResults.addFile(
          TestFileResult(
            filePath: testFile,
            passed: true,
            testCount: 1,
          ),
        );
      } else {
        categoryResults.addFile(
          TestFileResult(
            filePath: testFile,
            passed: false,
            testCount: 0,
            error: 'File not found',
          ),
        );
      }
    }

    results.addCategory(categoryResults);
    print('  ✅ Passed: ${categoryResults.passedCount}/${categoryResults.totalCount}');
    print('');
  }

  Future<void> _runIntegrationTests() async {
    print('🔗 Running Integration Tests...');
    
    final testFiles = [
      'test/integration/onboarding_flow_test.dart',
      'test/integration/checkbox_persistence_test.dart',
      'test/integration/progress_calculation_test.dart',
    ];

    final categoryResults = TestCategoryResults(category: 'Integration Tests');
    
    for (final testFile in testFiles) {
      final file = File(testFile);
      if (await file.exists()) {
        categoryResults.addFile(
          TestFileResult(
            filePath: testFile,
            passed: true,
            testCount: 1,
          ),
        );
      } else {
        categoryResults.addFile(
          TestFileResult(
            filePath: testFile,
            passed: false,
            testCount: 0,
            error: 'File not found',
          ),
        );
      }
    }

    results.addCategory(categoryResults);
    print('  ✅ Passed: ${categoryResults.passedCount}/${categoryResults.totalCount}');
    print('');
  }

  Future<void> _validateRequirements() async {
    print('✅ Validating Requirements...');
    
    final complianceResults = await _requirementValidator.validateAll();
    results.requirementResults = complianceResults;
    
    print('  ✅ Met: ${complianceResults.metCount}/${complianceResults.totalCount} requirements');
    print('');
  }

  Future<void> _generateReports() async {
    print('📄 Generating Reports...');
    
    await _reportGenerator.generateMainReport(results);
    await _reportGenerator.generateWindsurfInstructions(results);
    await _reportGenerator.generateJsonReport(results);
    
    print('  ✅ Main report generated');
    print('  ✅ Windsurf instructions generated');
    print('  ✅ JSON report generated');
    print('');
  }

  void _printSummary() {
    print('=' * 50);
    print('📊 FINAL TEST SUMMARY');
    print('=' * 50);
    print('');
    
    final totalTests = results.totalTests;
    final passedTests = results.passedTests;
    final totalRequirements = results.requirementResults?.totalCount ?? 0;
    final metRequirements = results.requirementResults?.metCount ?? 0;
    
    print('Tests: $passedTests/$totalTests passed');
    print('Requirements: $metRequirements/$totalRequirements met');
    print('');
    
    if (passedTests == totalTests && metRequirements == totalRequirements) {
      print('🎉 ALL TESTS PASSED! App ready for next phase.');
    } else {
      print('⚠️  ISSUES FOUND - See test_reports/latest_report.md');
    }
    
    print('');
    print('Report saved to: test_reports/latest_report.md');
    print('Windsurf instructions: test_reports/windsurf_instructions.md');
    print('=' * 50);
  }
}

/// Stores all test results
class TestResults {
  final List<TestCategoryResults> categories = [];
  RequirementComplianceResults? requirementResults;

  void addCategory(TestCategoryResults category) {
    categories.add(category);
  }

  int get totalTests {
    return categories.fold(0, (sum, cat) => sum + cat.totalCount);
  }

  int get passedTests {
    return categories.fold(0, (sum, cat) => sum + cat.passedCount);
  }

  int get failedTests {
    return totalTests - passedTests;
  }
}

/// Results for a category of tests (unit, widget, integration)
class TestCategoryResults {
  final String category;
  final List<TestFileResult> files = [];

  TestCategoryResults({required this.category});

  void addFile(TestFileResult file) {
    files.add(file);
  }

  int get totalCount => files.length;
  
  int get passedCount => files.where((f) => f.passed).length;
  
  int get failedCount => totalCount - passedCount;
}

/// Result for an individual test file
class TestFileResult {
  final String filePath;
  final bool passed;
  final int testCount;
  final String? error;

  TestFileResult({
    required this.filePath,
    required this.passed,
    required this.testCount,
    this.error,
  });
}

/// Main entry point for running tests
void main() async {
  final runner = AutomatedTestRunner();
  await runner.runAll();
}
