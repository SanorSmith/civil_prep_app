#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Civil Preparedness App - Automated Test Suite${NC}"
echo "=================================================="
echo ""

# Create test_reports directory
mkdir -p test_reports

# Track overall status
OVERALL_STATUS=0

# Run Flutter tests
echo -e "${BLUE}📦 Running Flutter Tests...${NC}"
flutter test
FLUTTER_STATUS=$?

if [ $FLUTTER_STATUS -eq 0 ]; then
    echo -e "${GREEN}✅ Flutter tests passed${NC}"
else
    echo -e "${RED}❌ Flutter tests failed${NC}"
    OVERALL_STATUS=1
fi
echo ""

# Run automated test runner
echo -e "${BLUE}🔧 Running Automated Test Runner...${NC}"
dart test/automated_test_runner.dart
RUNNER_STATUS=$?

if [ $RUNNER_STATUS -eq 0 ]; then
    echo -e "${GREEN}✅ Automated tests completed${NC}"
else
    echo -e "${YELLOW}⚠️  Some automated checks found issues${NC}"
    OVERALL_STATUS=1
fi
echo ""

# Display results
echo "=================================================="
echo -e "${BLUE}📊 FINAL TEST SUMMARY${NC}"
echo "=================================================="
echo ""

if [ $OVERALL_STATUS -eq 0 ]; then
    echo -e "${GREEN}🎉 ALL TESTS PASSED! App ready for next phase.${NC}"
else
    echo -e "${YELLOW}⚠️  ISSUES FOUND - See test_reports/latest_report.md${NC}"
fi

echo ""
echo "Report saved to: test_reports/latest_report.md"
echo "Windsurf instructions: test_reports/windsurf_instructions.md"
echo "=================================================="

exit $OVERALL_STATUS
