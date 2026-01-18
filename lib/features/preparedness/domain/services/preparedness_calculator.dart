import '../../../../models/household_profile_model.dart';
import '../../../../models/prep_category_model.dart';
import '../../../../models/prep_item_model.dart';

class PreparednessCalculator {
  // Calculate water needs based on MSB guidelines
  // Adults: 3L/day, Children: 2L/day, Infants: 1L/day
  double calculateWaterNeed({
    required int adults,
    required int children,
    required int infants,
    required int days,
  }) {
    final adultWater = adults * 3.0 * days;
    final childWater = children * 2.0 * days;
    final infantWater = infants * 1.0 * days;
    return adultWater + childWater + infantWater;
  }

  // Calculate food needs (in calories)
  // Adults: 2000 cal/day, Children: 1500 cal/day, Infants: 800 cal/day
  double calculateFoodNeed({
    required int adults,
    required int children,
    required int infants,
    required int days,
  }) {
    final adultCal = adults * 2000.0 * days;
    final childCal = children * 1500.0 * days;
    final infantCal = infants * 800.0 * days;
    return adultCal + childCal + infantCal;
  }

  // Generate all preparedness categories
  List<PrepCategory> generateCategories() {
    return PrepCategory.getAllCategories();
  }

  // Calculate all required items based on household profile
  List<PrepItem> calculateRequirements({
    required HouseholdProfile profile,
    required String userId,
  }) {
    final items = <PrepItem>[];
    final categories = generateCategories();

    for (final category in categories) {
      items.addAll(_generateItemsForCategory(
        category: category,
        profile: profile,
        userId: userId,
      ));
    }

    return items;
  }

  List<PrepItem> _generateItemsForCategory({
    required PrepCategory category,
    required HouseholdProfile profile,
    required String userId,
  }) {
    switch (category.id) {
      case 'water':
        return _generateWaterItems(profile, userId);
      case 'food':
        return _generateFoodItems(profile, userId);
      case 'heating':
        return _generateHeatingItems(profile, userId);
      case 'hygiene':
        return _generateHygieneItems(profile, userId);
      case 'communication':
        return _generateCommunicationItems(profile, userId);
      case 'first_aid':
        return _generateFirstAidItems(profile, userId);
      case 'lighting':
        return _generateLightingItems(profile, userId);
      case 'documents':
        return _generateDocumentItems(profile, userId);
      case 'cash':
        return _generateCashItems(profile, userId);
      default:
        return [];
    }
  }

  List<PrepItem> _generateWaterItems(HouseholdProfile profile, String userId) {
    final water24h = calculateWaterNeed(
      adults: profile.adultCount,
      children: profile.childCount,
      infants: profile.infantCount,
      days: 1,
    );

    final water72h = calculateWaterNeed(
      adults: profile.adultCount,
      children: profile.childCount,
      infants: profile.infantCount,
      days: 3,
    );

    final water7d = calculateWaterNeed(
      adults: profile.adultCount,
      children: profile.childCount,
      infants: profile.infantCount,
      days: 7,
    );

    return [
      PrepItem.create(
        userId: userId,
        categoryId: 'water',
        name: 'Dricksvatten (24h)',
        targetQuantity: water24h,
        unit: 'liter',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'water',
        name: 'Dricksvatten (72h)',
        targetQuantity: water72h,
        unit: 'liter',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'water',
        name: 'Dricksvatten (7 dagar)',
        targetQuantity: water7d,
        unit: 'liter',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'water',
        name: 'Vattenreningstabletter',
        targetQuantity: 1,
        unit: 'förpackning',
      ),
    ];
  }

  List<PrepItem> _generateFoodItems(HouseholdProfile profile, String userId) {
    final totalPeople = profile.adultCount + profile.childCount + profile.infantCount;

    return [
      PrepItem.create(
        userId: userId,
        categoryId: 'food',
        name: 'Konserver',
        targetQuantity: totalPeople * 6.0,
        unit: 'burkar',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'food',
        name: 'Knäckebröd',
        targetQuantity: totalPeople * 2.0,
        unit: 'paket',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'food',
        name: 'Pasta/Ris',
        targetQuantity: totalPeople * 1.0,
        unit: 'kg',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'food',
        name: 'Torkad frukt/Nötter',
        targetQuantity: totalPeople * 0.5,
        unit: 'kg',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'food',
        name: 'Energibars',
        targetQuantity: totalPeople * 10.0,
        unit: 'st',
      ),
    ];
  }

  List<PrepItem> _generateHeatingItems(HouseholdProfile profile, String userId) {
    final items = <PrepItem>[
      PrepItem.create(
        userId: userId,
        categoryId: 'heat',
        name: 'Filtar',
        targetQuantity: (profile.adultCount + profile.childCount + profile.infantCount).toDouble(),
        unit: 'st',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'heat',
        name: 'Varma kläder',
        targetQuantity: (profile.adultCount + profile.childCount).toDouble(),
        unit: 'set',
      ),
    ];

    // Add heating source for houses and rural
    if (profile.housingType == HousingType.house || profile.housingType == HousingType.rural) {
      items.add(PrepItem.create(
        userId: userId,
        categoryId: 'heat',
        name: 'Alternativ värmekälla',
        targetQuantity: 1,
        unit: 'st',
      ));
    }

    return items;
  }

  List<PrepItem> _generateHygieneItems(HouseholdProfile profile, String userId) {
    final totalPeople = profile.adultCount + profile.childCount + profile.infantCount;

    return [
      PrepItem.create(
        userId: userId,
        categoryId: 'hygiene',
        name: 'Toalettpapper',
        targetQuantity: totalPeople * 4.0,
        unit: 'rullar',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'hygiene',
        name: 'Tvål',
        targetQuantity: 2,
        unit: 'st',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'hygiene',
        name: 'Handsprit',
        targetQuantity: 1,
        unit: 'flaska',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'hygiene',
        name: 'Våtservetter',
        targetQuantity: 2,
        unit: 'paket',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'hygiene',
        name: 'Tandborste och tandkräm',
        targetQuantity: totalPeople.toDouble(),
        unit: 'set',
      ),
    ];
  }

  List<PrepItem> _generateCommunicationItems(HouseholdProfile profile, String userId) {
    return [
      PrepItem.create(
        userId: userId,
        categoryId: 'radio',
        name: 'Batteridriven radio',
        targetQuantity: 1,
        unit: 'st',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'radio',
        name: 'Extra batterier (radio)',
        targetQuantity: 6,
        unit: 'st',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'radio',
        name: 'Powerbank',
        targetQuantity: 1,
        unit: 'st',
      ),
    ];
  }

  List<PrepItem> _generateFirstAidItems(HouseholdProfile profile, String userId) {
    return [
      PrepItem.create(
        userId: userId,
        categoryId: 'medicine',
        name: 'Första hjälpen-kit',
        targetQuantity: 1,
        unit: 'st',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'medicine',
        name: 'Smärtstillande',
        targetQuantity: 1,
        unit: 'förpackning',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'medicine',
        name: 'Plåster',
        targetQuantity: 1,
        unit: 'ask',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'medicine',
        name: 'Febernedsättande',
        targetQuantity: 1,
        unit: 'förpackning',
      ),
    ];
  }

  List<PrepItem> _generateLightingItems(HouseholdProfile profile, String userId) {
    return [
      PrepItem.create(
        userId: userId,
        categoryId: 'light',
        name: 'Ficklampa',
        targetQuantity: 2,
        unit: 'st',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'light',
        name: 'Batterier (ficklampa)',
        targetQuantity: 8,
        unit: 'st',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'light',
        name: 'Stearinljus',
        targetQuantity: 10,
        unit: 'st',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'light',
        name: 'Tändstickor',
        targetQuantity: 2,
        unit: 'askar',
      ),
    ];
  }

  List<PrepItem> _generateDocumentItems(HouseholdProfile profile, String userId) {
    return [
      PrepItem.create(
        userId: userId,
        categoryId: 'documents',
        name: 'Kopior av viktiga dokument',
        targetQuantity: 1,
        unit: 'set',
      ),
      PrepItem.create(
        userId: userId,
        categoryId: 'documents',
        name: 'Försäkringsbrev',
        targetQuantity: 1,
        unit: 'st',
      ),
    ];
  }

  List<PrepItem> _generateCashItems(HouseholdProfile profile, String userId) {
    return [
      PrepItem.create(
        userId: userId,
        categoryId: 'cash',
        name: 'Kontanter (små valörer)',
        targetQuantity: 500,
        unit: 'kr',
      ),
    ];
  }
}
