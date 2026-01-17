# Testing Guide
## Civil Preparedness App - Complete Testing System

This guide explains how to use the automated testing and quality assurance system.

---

## Quick Start

### Run All Tests
```bash
# Make script executable (first time only)
chmod +x scripts/run_all_tests.sh

# Run all tests
bash ./scripts/run_all_tests.sh
```

This will:
1. Run Flutter unit/widget/integration tests
2. Run automated test runner
3. Validate requirements
4. Generate reports
5. Show summary

---

## Understanding the System

### Components

**1. Design Verification Checklist**
- Location: `docs/DESIGN_VERIFICATION_CHECKLIST.md`
- Contains ALL design requirements by phase
- Use to verify features meet specifications
- Check off requirements as you implement

**2. Automated Test Runner**
- Location: `test/automated_test_runner.dart`
- Orchestrates all testing
- Runs unit, widget, and integration tests
- Validates requirements
- Generates reports

**3. Requirement Validator**
- Location: `test/requirement_validator.dart`
- Checks if requirements are met
- Searches codebase for files, classes, functions
- Reports compliance status

**4. Report Generator**
- Location: `test/report_generator.dart`
- Creates markdown reports
- Generates Windsurf fix instructions
- Outputs JSON data

**5. Requirement Specs**
- Location: `test/requirement_specs/`
- JSON files defining requirements
- Phase 1: Onboarding requirements
- Phase 2: Home dashboard requirements

**6. Test Files**
- Location: `test/`
- Unit tests: `test/models/`, `test/services/`
- Widget tests: `test/widget/`
- Integration tests: `test/integration/`

---

## How to Use the Design Checklist

### Before Building a Feature

1. Open `docs/DESIGN_VERIFICATION_CHECKLIST.md`
2. Find the section for your feature
3. Read all requirements
4. Understand layout, styling, and functionality needs

### During Development

1. Implement each requirement
2. Check off items as you complete them
3. Use the specified styles and spacing
4. Follow the design system

### After Building

1. Go through checklist again
2. Verify all items are checked
3. Run the specified test file
4. Fix any issues found

### Example Workflow

Building the postal code screen:

```markdown
1. Read requirements:
   - Layout: progress indicator, title, input, buttons
   - Styling: 56dp input height, 8dp radius
   - Validation: 10000-98499 range
   - Functionality: real-time validation, save to state

2. Implement:
   - Create UI with all elements
   - Add validation logic
   - Connect to state provider
   - Add navigation

3. Verify:
   - [ ] All UI elements present
   - [ ] Validation works for test cases
   - [ ] Button enables/disables correctly
   - [ ] Data saves to state
   - [ ] Navigation works

4. Test:
   Run: flutter test test/widget/onboarding/postal_code_screen_test.dart

5. Fix any issues and re-test
```

---

## How to Interpret Test Reports

### Main Report (`test_reports/latest_report.md`)

**Summary Table:**
```
| Category | Passed | Failed | Total |
|----------|--------|--------|-------|
| Unit Tests | 4 | 0 | 4 |
| Widget Tests | 7 | 2 | 9 |
| Integration Tests | 2 | 1 | 3 |
| Requirements | 10 | 2 | 12 |
```

**What it means:**
- **Passed:** Tests that succeeded
- **Failed:** Tests that failed or files missing
- **Total:** Total number of tests/requirements

**Detailed Results:**
Shows each test file and its status:
```
### Widget Tests
- ✅ test/widget/onboarding/postal_code_screen_test.dart
- ❌ test/widget/home/next_steps_test.dart
  - Error: File not found
```

**Requirements Compliance:**
Lists requirements not met:
```
#### ❌ Not Met (2)
- REQ-2.10: markItemComplete method exists
  - Function not found
```

**Critical Issues:**
Highlights critical problems:
```
- ⚠️ CRITICAL: Next steps checkbox test missing
- ⚠️ CRITICAL REQUIREMENT: REQ-2.12 - Checkbox save functionality
```

### Windsurf Instructions (`test_reports/windsurf_instructions.md`)

Copy-paste ready instructions for Windsurf:

```
FIX THE FOLLOWING ISSUES:

1. Missing test file: test/widget/home/next_steps_test.dart
2. Requirement not met: REQ-2.10 - markItemComplete method exists

STEPS:
1. Create any missing test files
2. Implement missing features
3. Fix failing tests
4. Run: bash ./scripts/run_all_tests.sh
5. Verify all tests pass
```

### JSON Report (`test_reports/requirement_compliance.json`)

Structured data for programmatic access:
```json
{
  "generated_at": "2026-01-17T14:00:00Z",
  "summary": {
    "total_tests": 16,
    "passed_tests": 13,
    "failed_tests": 3
  }
}
```

---

## How to Fix Failing Tests

### Step 1: Read the Report

```bash
cat test_reports/latest_report.md
```

Identify what's failing and why.

### Step 2: Fix Issues

**Missing Test File:**
```bash
# Create the missing test file
# Use existing tests as templates
cp test/widget/onboarding/postal_code_screen_test.dart \
   test/widget/home/next_steps_test.dart
# Edit to match your feature
```

**Missing Feature:**
```dart
// Implement the missing functionality
// Example: Add markItemComplete method
Future<void> markItemComplete(String itemId, bool completed) async {
  // Implementation
}
```

**Failing Test:**
```bash
# Run specific test to see details
flutter test test/widget/home/next_steps_test.dart

# Fix the code based on error message
# Re-run test
```

### Step 3: Re-run Tests

```bash
bash ./scripts/run_all_tests.sh
```

### Step 4: Verify

Check that:
- All tests pass
- All requirements met
- No critical issues

---

## How to Add New Tests

### Unit Test Example

```dart
// test/services/my_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:civil_prep_app/services/my_service.dart';

void main() {
  group('MyService Tests', () {
    test('calculates correctly', () {
      final service = MyService();
      final result = service.calculate(2, 3);
      expect(result, 5);
    });
  });
}
```

### Widget Test Example

```dart
// test/widget/my_widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:civil_prep_app/widgets/my_widget.dart';

void main() {
  testWidgets('MyWidget displays text', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyWidget(text: 'Hello'),
      ),
    );

    expect(find.text('Hello'), findsOneWidget);
  });
}
```

### Integration Test Example

```dart
// test/integration/my_flow_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:civil_prep_app/app.dart';

void main() {
  testWidgets('complete user flow', (WidgetTester tester) async {
    await tester.pumpWidget(const CivilPrepApp());
    
    // Navigate through flow
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    
    // Verify result
    expect(find.text('Success'), findsOneWidget);
  });
}
```

---

## Example Workflow: Building a Feature

### Scenario: Adding a New Screen

**1. Plan (5 minutes)**
```
Feature: Crisis scenario detail screen
Requirements: 
- Display scenario info
- Show timeline sections
- Emergency contacts
- Offline support
```

**2. Check Design Checklist (5 minutes)**
```
Open: docs/DESIGN_VERIFICATION_CHECKLIST.md
Find: PHASE 4: CRISIS GUIDE > Scenario Detail
Read: All requirements
Note: Styling, layout, functionality needs
```

**3. Create Test First (15 minutes)**
```dart
// test/widget/crisis_guide/scenario_detail_test.dart
testWidgets('displays scenario info', (tester) async {
  // Test implementation
});
```

**4. Implement Feature (30-60 minutes)**
```dart
// lib/features/crisis_guide/presentation/screens/scenario_detail_screen.dart
class ScenarioDetailScreen extends StatelessWidget {
  // Implementation
}
```

**5. Run Tests (2 minutes)**
```bash
flutter test test/widget/crisis_guide/scenario_detail_test.dart
```

**6. Fix Issues (10-20 minutes)**
```
Review test failures
Fix implementation
Re-run tests
```

**7. Verify Checklist (5 minutes)**
```
Go through design checklist
Check off all requirements
Ensure nothing missed
```

**8. Run Full Test Suite (3 minutes)**
```bash
bash ./scripts/run_all_tests.sh
```

**9. Review Report (2 minutes)**
```
Check test_reports/latest_report.md
Verify all tests pass
No new failures introduced
```

**10. Commit (1 minute)**
```bash
git add .
git commit -m "feat: Add crisis scenario detail screen"
```

**Total Time: ~1-2 hours for complete, tested feature**

---

## Best Practices

### DO:
✅ Read design checklist before coding
✅ Write tests first (TDD)
✅ Run tests frequently during development
✅ Check off requirements as you complete them
✅ Fix issues immediately
✅ Run full test suite before committing
✅ Keep tests simple and focused
✅ Use descriptive test names

### DON'T:
❌ Skip reading requirements
❌ Write code without tests
❌ Ignore failing tests
❌ Commit without running tests
❌ Leave requirements unchecked
❌ Create complex, brittle tests
❌ Test implementation details

---

## Troubleshooting

### "File not found" errors
```bash
# Ensure you're in project root
cd /path/to/civil_prep_app

# Check file exists
ls -la test/widget/home/next_steps_test.dart

# Create if missing
mkdir -p test/widget/home
touch test/widget/home/next_steps_test.dart
```

### "Permission denied" on script
```bash
# Make executable
chmod +x scripts/run_all_tests.sh

# Run again
bash ./scripts/run_all_tests.sh
```

### Tests pass but requirements fail
```bash
# Check requirement spec
cat test/requirement_specs/phase_2_requirements.json

# Verify the check_value matches your code
# Example: If looking for "markItemComplete", ensure exact match
```

### All tests fail
```bash
# Run Flutter tests directly to see errors
flutter test

# Check for syntax errors
flutter analyze

# Ensure dependencies installed
flutter pub get
```

---

## Continuous Integration

### Local Development
```bash
# Before every commit
bash ./scripts/run_all_tests.sh

# If all pass, commit
git commit -m "feat: Add feature"

# If failures, fix first
```

### CI/CD Pipeline (Future)
```yaml
# .github/workflows/test.yml
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: bash ./scripts/run_all_tests.sh
```

---

## Summary

**The testing system ensures:**
1. ✅ All features meet design requirements
2. ✅ Code works as expected
3. ✅ No regressions introduced
4. ✅ Consistent quality throughout
5. ✅ Clear path to fix issues

**Your workflow:**
1. Read design checklist
2. Write test
3. Implement feature
4. Run tests
5. Fix issues
6. Verify checklist
7. Commit

**Remember:**
- Tests are documentation
- Failing tests are helpful
- Fix issues immediately
- Quality is not optional

---

**Questions?** Check the design checklist or test examples for guidance.

**Last Updated:** 2026-01-17
**Version:** 1.0
