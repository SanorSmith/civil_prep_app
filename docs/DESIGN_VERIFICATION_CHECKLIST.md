# Design Verification Checklist
## Civil Preparedness App - Complete Design Requirements

This document contains ALL design requirements organized by phase. Use this checklist to verify that every feature meets design specifications.

---

## PHASE 0: DESIGN SYSTEM

### Color Palette
- [ ] Primary color: `#005AA0` (Swedish blue)
- [ ] Success color: `#4CAF50` (green)
- [ ] Warning color: `#FF9800` (orange)
- [ ] Error color: `#F44336` (red)
- [ ] Background: `#FFFFFF` (white)
- [ ] Surface: `#F5F5F5` (light gray)
- [ ] Text primary: `#212121` (dark gray)
- [ ] Text secondary: `#757575` (medium gray)

**Verify:** Check `lib/core/theme/app_colors.dart` contains all colors

### Typography System
- [ ] H1: 32sp, bold, primary text color
- [ ] H2: 24sp, bold, primary text color
- [ ] H3: 20sp, semi-bold, primary text color
- [ ] Body: 16sp, regular, primary text color
- [ ] Body small: 14sp, regular, secondary text color
- [ ] Caption: 12sp, regular, secondary text color
- [ ] Button: 16sp, medium, white on primary

**Verify:** Check `lib/core/theme/app_text_styles.dart` defines all styles

### Spacing System (8dp Grid)
- [ ] XXS: 4dp
- [ ] XS: 8dp
- [ ] S: 16dp
- [ ] M: 24dp
- [ ] L: 32dp
- [ ] XL: 48dp
- [ ] XXL: 64dp

**Verify:** Check `lib/core/theme/app_spacing.dart` defines spacing constants

### Component Styles

#### Buttons
- [ ] Height: 48dp minimum
- [ ] Border radius: 8dp
- [ ] Padding horizontal: 24dp
- [ ] Elevation: 2dp (primary), 0dp (text)
- [ ] Disabled opacity: 0.38

**Verify:** All buttons use consistent styling

#### Cards
- [ ] Border radius: 12dp
- [ ] Elevation: 2dp
- [ ] Padding: 16dp
- [ ] Border: 1dp solid for outlined cards

**Verify:** All cards follow this pattern

#### Input Fields
- [ ] Height: 56dp
- [ ] Border radius: 8dp
- [ ] Border: 1dp solid (normal), 2dp (focused), red (error)
- [ ] Padding horizontal: 16dp
- [ ] Label: floating above when focused

**Verify:** All text inputs follow this pattern

---

## PHASE 1: ONBOARDING FLOW (6 Screens)

### Screen 1: Welcome Screen

**Layout Requirements:**
- [ ] Shield icon centered at top (size: 120dp)
- [ ] App title "Civil Beredskap" below icon (H1 style)
- [ ] Subtitle "Var förberedd för det oväntade" (Body style)
- [ ] "Kom igång" button (primary, full width)
- [ ] "Hoppa över" button (text button, centered below)
- [ ] Vertical spacing: icon→title (24dp), title→subtitle (8dp), subtitle→button (48dp)

**Styling Requirements:**
- [ ] Background: white
- [ ] Icon color: primary blue
- [ ] Button uses primary color
- [ ] Text button uses primary color text

**Functionality Requirements:**
- [ ] "Kom igång" navigates to postal code screen
- [ ] "Hoppa över" navigates to home dashboard with mock data
- [ ] No data validation needed

**Test Requirements:**
- [ ] Screen renders without errors
- [ ] All text displays in Swedish
- [ ] Buttons are tappable
- [ ] Navigation works correctly

**Verify:** Run `flutter test test/widget/onboarding/welcome_screen_test.dart`

---

### Screen 2: Postal Code Entry

**Layout Requirements:**
- [ ] Progress indicator "Steg 1 av 4" at top
- [ ] Title "Var bor du?" (H2 style)
- [ ] Description text explaining postal code purpose
- [ ] Text input field with label "Postnummer"
- [ ] Real-time validation feedback (checkmark or error icon)
- [ ] Error message below input (if invalid)
- [ ] "Nästa" button at bottom (enabled only when valid)
- [ ] Back button in AppBar

**Styling Requirements:**
- [ ] Input field: 56dp height, 8dp radius
- [ ] Green checkmark icon when valid
- [ ] Red error icon when invalid
- [ ] Error text in error color
- [ ] Button disabled state: 0.38 opacity

**Functionality Requirements:**
- [ ] Accepts only 5-digit numbers
- [ ] Validates range: 10000-98499 (Swedish postal codes)
- [ ] Real-time validation on input change
- [ ] Shows green checkmark for valid code
- [ ] Shows error message for invalid code
- [ ] "Nästa" button disabled until valid
- [ ] Saves postal code to onboarding state
- [ ] Navigates to housing type screen

**Validation Rules:**
- [ ] Invalid: "12345" (too low)
- [ ] Invalid: "99999" (too high)
- [ ] Invalid: "ABC12" (non-numeric)
- [ ] Invalid: "1234" (too short)
- [ ] Valid: "11522" (Stockholm)
- [ ] Valid: "41301" (Göteborg)
- [ ] Valid: "21115" (Malmö)

**Test Requirements:**
- [ ] Input accepts numeric input only
- [ ] Validation works for all test cases
- [ ] Checkmark appears for valid code
- [ ] Error message appears for invalid code
- [ ] Button state changes correctly
- [ ] Data saves to state
- [ ] Navigation works

**Verify:** Run `flutter test test/widget/onboarding/postal_code_screen_test.dart`

---

### Screen 3: Housing Type Selection

**Layout Requirements:**
- [ ] Progress indicator "Steg 2 av 4"
- [ ] Title "Vilken typ av boende har du?"
- [ ] Description explaining why this matters
- [ ] 3 selection cards in vertical list:
  - Lägenhet (Apartment icon)
  - Villa/Radhus (House icon)
  - Lantbruk (Farm icon)
- [ ] Each card: icon (48dp), title (H3), description (Body small)
- [ ] Selected card: primary border (2dp), background tint
- [ ] "Nästa" button (enabled only when selection made)

**Styling Requirements:**
- [ ] Cards: 12dp radius, 16dp padding
- [ ] Unselected: 1dp gray border
- [ ] Selected: 2dp primary border, primary background (10% opacity)
- [ ] Icon color: primary
- [ ] Spacing between cards: 12dp

**Functionality Requirements:**
- [ ] Single selection (radio button behavior)
- [ ] Tap anywhere on card to select
- [ ] Visual feedback on selection
- [ ] Saves housing type to state
- [ ] "Nästa" disabled until selection made
- [ ] Navigates to household size screen

**Test Requirements:**
- [ ] All 3 cards render
- [ ] Only one card can be selected
- [ ] Selection persists visually
- [ ] Button enables after selection
- [ ] Data saves correctly
- [ ] Navigation works

**Verify:** Run `flutter test test/widget/onboarding/housing_type_screen_test.dart`

---

### Screen 4: Household Size

**Layout Requirements:**
- [ ] Progress indicator "Steg 3 av 4"
- [ ] Title "Hur många bor i hushållet?"
- [ ] 3 counter rows:
  - Vuxna (Adults) - default: 1
  - Barn (Children 2-17 år) - default: 0
  - Spädbarn (Infants 0-2 år) - default: 0
- [ ] Each row: label (left), counter display (center), +/- buttons (right)
- [ ] Total summary "Totalt: X personer" below counters
- [ ] Info box explaining why this matters
- [ ] "Nästa" button (enabled when total ≥ 1)

**Styling Requirements:**
- [ ] Counter buttons: 40dp × 40dp, circular, primary color
- [ ] Counter display: 48dp width, centered text (H2)
- [ ] Minus button disabled when count = 0 (opacity 0.38)
- [ ] Total summary: bold text, primary color
- [ ] Info box: light blue background, 8dp radius

**Functionality Requirements:**
- [ ] Plus button increments count
- [ ] Minus button decrements count (min: 0)
- [ ] Adults minimum: 1 (cannot go below)
- [ ] Children/infants minimum: 0
- [ ] Maximum per category: 10
- [ ] Total updates in real-time
- [ ] Saves all counts to state
- [ ] "Nästa" disabled if total = 0
- [ ] Navigates to special needs screen

**Test Requirements:**
- [ ] All counters render with correct defaults
- [ ] Increment/decrement works
- [ ] Minimums enforced
- [ ] Maximums enforced
- [ ] Total calculates correctly
- [ ] Data saves correctly
- [ ] Button state changes correctly

**Verify:** Run `flutter test test/widget/onboarding/household_size_screen_test.dart`

---

### Screen 5: Special Needs

**Layout Requirements:**
- [ ] Progress indicator "Steg 4 av 4"
- [ ] Title "Finns det särskilda behov?"
- [ ] Description "Valfritt - hjälper oss ge bättre rekommendationer"
- [ ] 4 checkboxes:
  - Medicinsk utrustning (Medical equipment icon)
  - Husdjur (Pet icon)
  - Rörelsehinder (Mobility icon)
  - Allergier/matrestriktioner (Allergy icon)
- [ ] Privacy section:
  - Divider line
  - Title "Dela anonym statistik"
  - Description explaining k-anonymity
  - Toggle switch
  - Privacy disclaimer text
- [ ] "Slutför" button at bottom

**Styling Requirements:**
- [ ] Checkboxes: 24dp, primary color when checked
- [ ] Icons: 24dp, gray (unchecked), primary (checked)
- [ ] Toggle switch: primary color when on
- [ ] Privacy disclaimer: small text, gray
- [ ] Divider: 1dp, light gray

**Functionality Requirements:**
- [ ] Multiple checkboxes can be selected
- [ ] Toggle switch for privacy preference
- [ ] All selections optional
- [ ] Saves all selections to state
- [ ] "Slutför" always enabled (all optional)
- [ ] Navigates to summary screen

**Test Requirements:**
- [ ] All checkboxes render
- [ ] Multiple selections work
- [ ] Toggle switch works
- [ ] Data saves correctly
- [ ] Navigation works

**Verify:** Run `flutter test test/widget/onboarding/special_needs_screen_test.dart`

---

### Screen 6: Profile Summary

**Layout Requirements:**
- [ ] Success icon (green checkmark, 80dp)
- [ ] Title "Profilen är klar!"
- [ ] Summary cards showing:
  - Postnummer: [value]
  - Boendetyp: [value]
  - Hushåll: [X vuxna, Y barn, Z spädbarn]
  - Dela statistik: [Ja/Nej]
- [ ] "Beredskapsnivåer" section:
  - 24 timmar: 0 av X
  - 72 timmar: 0 av Y
  - 7 dagar: 0 av Z
- [ ] Info box "Börja med 24-timmars beredskap för snabba resultat!"
- [ ] "Börja förbereda" button (primary, full width)

**Styling Requirements:**
- [ ] Success icon: green color
- [ ] Summary cards: white background, 1dp border, 12dp radius
- [ ] Info box: amber background, lightbulb icon
- [ ] Numbers in readiness levels: bold, primary color

**Functionality Requirements:**
- [ ] Displays all entered data correctly
- [ ] Calculates required items for each level
- [ ] Shows item counts (not 0%)
- [ ] "Börja förbereda" button:
  - Creates User profile
  - Creates HouseholdProfile
  - Generates all PrepItems based on household
  - Saves User to SharedPreferences
  - Saves HouseholdProfile to SharedPreferences
  - Saves PrepItems to Hive
  - Navigates to home dashboard
- [ ] Shows error message if save fails

**Test Requirements:**
- [ ] All data displays correctly
- [ ] Calculations are correct for household size
- [ ] Save process completes successfully
- [ ] User profile created
- [ ] HouseholdProfile created
- [ ] PrepItems generated (50+ items)
- [ ] Navigation to home works
- [ ] Data persists after navigation

**Verify:** Run `flutter test test/integration/onboarding_flow_test.dart`

---

## PHASE 2: HOME DASHBOARD

### AppBar
- [ ] Title: "Civil Beredskap"
- [ ] Settings icon button (top right)
- [ ] Refresh icon button (top right, left of settings)
- [ ] No back button
- [ ] Elevation: 0dp

**Verify:** AppBar renders with correct elements

### Greeting Section
- [ ] Time-based greeting:
  - 00:00-11:59: "God morgon!"
  - 12:00-17:59: "God dag!"
  - 18:00-23:59: "God kväll!"
- [ ] Subtitle: "Här är din beredskapsstatus"
- [ ] Greeting: H3 style, bold
- [ ] Subtitle: Body style, gray

**Verify:** Greeting changes based on time

### Readiness Cards (3 Cards)
- [ ] Horizontal row, equal width
- [ ] Cards: 24h, 72h, 7 dagar
- [ ] Each card contains:
  - Circular progress indicator (80dp diameter)
  - Percentage text in center (H2 style)
  - Level label below (Body small)
- [ ] Color coding:
  - 0-33%: Red
  - 34-66%: Orange
  - 67-100%: Green
- [ ] Spacing between cards: 12dp

**Styling Requirements:**
- [ ] Card: white background, 12dp radius, 2dp elevation
- [ ] Padding: 16dp
- [ ] Progress circle: 4dp stroke width
- [ ] Percentage: bold, colored based on progress

**Functionality Requirements:**
- [ ] Progress calculates from PrepItems
- [ ] Updates in real-time when items change
- [ ] Tappable (navigate to filtered category view)

**Test Requirements:**
- [ ] All 3 cards render
- [ ] Progress displays correctly
- [ ] Colors match progress level
- [ ] Calculations are accurate

**Verify:** Run `flutter test test/widget/home/readiness_cards_test.dart`

---

### Categories Grid
- [ ] Section title: "Kategorier" (H3, bold)
- [ ] "Visa alla" text button (right aligned)
- [ ] Grid: 2 columns
- [ ] 8-10 category cards:
  1. Vatten (Water drop icon)
  2. Mat (Food icon)
  3. Värme (Fire icon)
  4. Hygien (Soap icon)
  5. Radio (Radio icon)
  6. Medicin (Medical icon)
  7. Ljus (Lightbulb icon)
  8. Dokument (Document icon)
  9. Kontanter (Cash icon)
  10. Övrigt (Other icon)

**Card Layout:**
- [ ] Icon at top (48dp, primary color)
- [ ] Category name (H3 style)
- [ ] Progress bar (horizontal, full width)
- [ ] Progress percentage (Body small, right aligned)

**Styling Requirements:**
- [ ] Card: 12dp radius, 2dp elevation
- [ ] Aspect ratio: 1:1 (square)
- [ ] Padding: 16dp
- [ ] Grid spacing: 12dp
- [ ] Progress bar: 4dp height, 8dp radius

**Functionality Requirements:**
- [ ] Each card shows category progress
- [ ] Progress calculates from items in category
- [ ] Tap navigates to category detail screen
- [ ] "Visa alla" navigates to categories list

**Test Requirements:**
- [ ] All categories render
- [ ] Icons display correctly
- [ ] Progress bars show correct values
- [ ] Navigation works

**Verify:** Run `flutter test test/widget/home/category_grid_test.dart`

---

### Next Steps Section (CRITICAL)
- [ ] Section title: "Nästa viktiga steg" (H3, bold)
- [ ] List of 3-5 incomplete items
- [ ] Each item shows:
  - Checkbox (left)
  - Category icon (24dp, colored)
  - Item name (Body, bold)
  - Target quantity (Body small, gray)
  - Chevron icon (right)

**Styling Requirements:**
- [ ] Item container: 12dp radius, 1dp border
- [ ] Padding: 12dp
- [ ] Spacing between items: 12dp
- [ ] Checkbox: 24dp, primary color

**Functionality Requirements (CRITICAL):**
- [ ] Checkbox tap updates item:
  - Checked: `currentQuantity = targetQuantity`
  - Unchecked: `currentQuantity = 0`
- [ ] Saves updated item to Hive storage
- [ ] Recalculates all progress values
- [ ] Updates UI immediately
- [ ] Item persists after app restart
- [ ] Item removes from list when complete
- [ ] Progress circles update
- [ ] Category progress updates

**Test Requirements:**
- [ ] Items render correctly
- [ ] Checkbox tap updates quantity
- [ ] Data saves to storage
- [ ] Progress recalculates
- [ ] UI refreshes
- [ ] Data persists after restart
- [ ] Item disappears when complete

**Verify:** Run `flutter test test/widget/home/next_steps_test.dart` (MUST PASS)

---

### Bottom Navigation
- [ ] 5 tabs:
  1. Hem (Home icon)
  2. Kategorier (Grid icon)
  3. Krisguide (Book icon)
  4. Område (Map icon)
  5. Inställningar (Settings icon)
- [ ] Selected tab: primary color
- [ ] Unselected tabs: gray
- [ ] Label below icon
- [ ] Height: 56dp

**Verify:** Navigation bar renders and switches screens

---

## PHASE 3: CATEGORY DETAIL SCREEN

### Header
- [ ] AppBar with category name and back button
- [ ] Progress summary card:
  - Large circular progress (120dp)
  - "X av Y klart" text
  - Percentage
  - Color-coded

**Verify:** Header displays correct category info

### Level Tabs
- [ ] 3 tabs: 24h, 72h, 7 dagar
- [ ] Tab indicator: primary color, 2dp height
- [ ] Selected tab: primary color text
- [ ] Unselected tabs: gray text

**Verify:** Tabs switch content correctly

### Item List
- [ ] Expandable item cards
- [ ] Each item shows:
  - Checkbox (left)
  - Item name
  - Current/target quantity
  - Progress bar
  - Expand icon
- [ ] Expanded state shows:
  - Quantity input with +/- buttons
  - Unit label
  - Priority badge (if high priority)
  - Delete button (if custom item)

**Styling Requirements:**
- [ ] Card: 12dp radius, 1dp border
- [ ] Expanded card: 2dp border, primary color
- [ ] Quantity buttons: 32dp, circular
- [ ] Progress bar: full width, 4dp height

**Functionality Requirements:**
- [ ] Checkbox updates quantity (0 or target)
- [ ] Plus button increments current quantity
- [ ] Minus button decrements (min: 0)
- [ ] Direct input allows typing quantity
- [ ] Changes save immediately
- [ ] Progress updates in real-time
- [ ] Delete removes custom items

**Test Requirements:**
- [ ] Items filter by selected level
- [ ] Expand/collapse works
- [ ] Quantity updates save
- [ ] Progress recalculates
- [ ] Delete works for custom items

**Verify:** Run `flutter test test/widget/category/category_detail_test.dart`

---

## PHASE 4: CRISIS GUIDE

### Scenario List
- [ ] 4 scenarios:
  1. Strömavbrott (Power outage)
  2. Vattenavbrott (Water outage)
  3. Extremt väder (Extreme weather)
  4. Kommunikationsstörning (Communication disruption)
- [ ] Each card shows:
  - Icon (48dp)
  - Scenario name (H3)
  - Brief description
  - "📵 Fungerar utan internet" badge
  - Chevron icon

**Styling Requirements:**
- [ ] Card: 12dp radius, 2dp elevation
- [ ] Offline badge: green background, white text
- [ ] Icon color: matches scenario severity

**Verify:** All scenarios render correctly

### Scenario Detail
- [ ] Scenario title (H2)
- [ ] Severity indicator (color-coded)
- [ ] Expandable timeline sections:
  - Första timmen (First hour)
  - Första dagen (First day)
  - Följande dagar (Following days)
- [ ] Each section contains:
  - Checklist items
  - Warning boxes (red border)
  - Info boxes (blue background)
- [ ] Emergency contacts section:
  - 112 (Emergency)
  - 113 13 (Non-emergency)
  - 1177 (Healthcare)

**Styling Requirements:**
- [ ] Warning box: red border (2dp), light red background
- [ ] Info box: blue background, info icon
- [ ] Checklist: checkbox (non-interactive), text

**Functionality Requirements:**
- [ ] All content available offline
- [ ] Expandable sections
- [ ] Phone numbers are tappable (call)

**Test Requirements:**
- [ ] Content loads offline
- [ ] Sections expand/collapse
- [ ] Phone links work

**Verify:** Run `flutter test test/widget/crisis_guide/scenario_test.dart`

---

## PHASE 5: AREA READINESS

### Privacy Protection (CRITICAL)
- [ ] Check household count in area
- [ ] If < 50 households:
  - Show privacy message
  - Lock icon (48dp)
  - "För få hushåll i området för att visa statistik"
  - "Minst 50 hushåll krävs för att skydda din integritet"
  - No data displayed
- [ ] If ≥ 50 households:
  - Show ONLY binned data
  - Never show exact numbers

**Binning Rules:**
- [ ] Progress levels:
  - Låg: 0-33%
  - Medel: 34-66%
  - Hög: 67-100%
- [ ] Household counts:
  - Några: 1-10
  - Flera: 11-30
  - Många: 31+

**Display Requirements:**
- [ ] Area map (if available)
- [ ] Binned statistics cards:
  - "Beredskapsnivå: Medel" (NOT "45%")
  - "Deltagande: Flera hushåll" (NOT "23 households")
- [ ] Privacy disclaimer at bottom
- [ ] No exact percentages
- [ ] No exact counts

**Test Requirements:**
- [ ] Privacy check works
- [ ] < 50 households shows privacy message
- [ ] ≥ 50 households shows binned data only
- [ ] No exact numbers leak
- [ ] Binning is correct

**Verify:** Run `flutter test test/widget/area/privacy_test.dart` (CRITICAL)

---

## CROSS-CUTTING REQUIREMENTS

### Localization
- [ ] All text in Swedish
- [ ] Date format: YYYY-MM-DD
- [ ] Number format: Swedish (comma for decimal)
- [ ] Fallback to English if translation missing

**Verify:** Check `lib/l10n/app_sv.arb` contains all strings

### Offline Support
- [ ] App works without internet
- [ ] Crisis guide available offline
- [ ] Data syncs when online
- [ ] Offline indicator shown when disconnected

**Verify:** Test app in airplane mode

### Accessibility
- [ ] All interactive elements: min 48dp touch target
- [ ] Color contrast ratio: min 4.5:1
- [ ] Screen reader labels on all icons
- [ ] Keyboard navigation support

**Verify:** Run accessibility scanner

### Performance
- [ ] App launches in < 3 seconds
- [ ] Screen transitions: < 300ms
- [ ] No janky scrolling (60fps)
- [ ] Images optimized

**Verify:** Run performance profiler

---

## HOW TO USE THIS CHECKLIST

### For Each Feature:
1. **Before building:** Read requirements for that screen/component
2. **During building:** Check off requirements as you implement them
3. **After building:** Verify all checkboxes are checked
4. **Testing:** Run the specified test file
5. **Review:** Ensure all tests pass

### For Quality Assurance:
1. Go through each phase systematically
2. Check every requirement
3. Run all specified tests
4. Document any deviations
5. Fix issues before moving to next phase

### For Bug Fixes:
1. Find the relevant section
2. Check which requirements are not met
3. Fix the issue
4. Re-run tests
5. Update checklist

---

## REQUIREMENT STATUS TRACKING

Use this format to track status:

```
[ ] Not started
[~] In progress
[✓] Complete and tested
[!] Issue found
[?] Needs clarification
```

---

**Last Updated:** 2026-01-17  
**Version:** 1.0  
**Maintained by:** Development Team
