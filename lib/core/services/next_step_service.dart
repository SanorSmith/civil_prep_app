import '../models/preparedness_item.dart';
import 'items_service.dart';

class NextStepService {
  final ItemsService _itemsService = ItemsService();
  
  /// Get the single most important next step
  Future<NextStepRecommendation?> getNextStep() async {
    final items = await _itemsService.getNextSteps(count: 1);
    
    if (items.isEmpty) {
      return null; // All complete!
    }
    
    final item = items.first;
    
    return NextStepRecommendation(
      item: item,
      actionTitleSv: _getActionTitle(item, 'sv'),
      actionTitleEn: _getActionTitle(item, 'en'),
      whyImportantSv: _getWhyImportant(item, 'sv'),
      whyImportantEn: _getWhyImportant(item, 'en'),
      howToCompleteSv: _getHowToComplete(item, 'sv'),
      howToCompleteEn: _getHowToComplete(item, 'en'),
      tipsSv: _getTips(item, 'sv'),
      tipsEn: _getTips(item, 'en'),
    );
  }
  
  /// Map item to action-oriented title
  String _getActionTitle(PreparednessItem item, String lang) {
    final level = item.level;
    final category = item.category;
    final key = '${category}_$level';
    
    if (lang == 'en') {
      final actionTitlesEn = {
        'water_24h': 'Secure water for 24h',
        'water_72h': 'Prepare extra water for 72h',
        'water_7d': 'Secure water for a full week',
        'food_24h': 'Get food for 24h',
        'food_72h': 'Prepare food for 72h',
        'food_7d': 'Secure food for a week',
        'light_24h': 'Arrange light sources for 24h',
        'light_72h': 'Prepare extra lighting',
        'light_7d': 'Secure long-term lighting',
        'heat_24h': 'Prepare to stay warm',
        'heat_72h': 'Secure heat and cooking',
        'heat_7d': 'Arrange long-term heating solution',
        'radio_24h': 'Get radio for information',
        'radio_72h': 'Secure communication',
        'radio_7d': 'Arrange long-term communication',
        'cash_24h': 'Withdraw cash',
        'cash_72h': 'Secure extra cash',
        'cash_7d': 'Prepare cash reserve',
        'medicine_24h': 'Secure basic medicine',
        'medicine_72h': 'Prepare extended medicine',
        'medicine_7d': 'Secure medicine for a week',
        'hygiene_24h': 'Arrange basic hygiene',
        'hygiene_72h': 'Prepare hygiene equipment',
        'hygiene_7d': 'Secure hygiene for a week',
      };
      return actionTitlesEn[key] ?? 'Prepare ${item.nameEn}';
    } else {
      final actionTitlesSv = {
        'water_24h': 'Säkra vatten för 24h',
        'water_72h': 'Förbered extra vatten för 72h',
        'water_7d': 'Säkra vatten för en hel vecka',
        'food_24h': 'Skaffa mat för 24h',
        'food_72h': 'Förbered mat för 72h',
        'food_7d': 'Säkra mat för en vecka',
        'light_24h': 'Ordna ljuskällor för 24h',
        'light_72h': 'Förbered extra belysning',
        'light_7d': 'Säkra långsiktig belysning',
        'heat_24h': 'Förbered för att hålla värmen',
        'heat_72h': 'Säkra värme och matlagning',
        'heat_7d': 'Ordna långsiktig värmelösning',
        'radio_24h': 'Skaffa radio för information',
        'radio_72h': 'Säkra kommunikation',
        'radio_7d': 'Ordna långsiktig kommunikation',
        'cash_24h': 'Ta ut kontanter',
        'cash_72h': 'Säkra extra kontanter',
        'cash_7d': 'Förbered kontantreserv',
        'medicine_24h': 'Säkra grundläggande medicin',
        'medicine_72h': 'Förbered utökad medicin',
        'medicine_7d': 'Säkra medicin för en vecka',
        'hygiene_24h': 'Ordna grundläggande hygien',
        'hygiene_72h': 'Förbered hygienutrustning',
        'hygiene_7d': 'Säkra hygien för en vecka',
      };
      return actionTitlesSv[key] ?? 'Förbered ${item.nameSv}';
    }
  }
  
  /// Get why this step is important
  String _getWhyImportant(PreparednessItem item, String lang) {
    if (lang == 'en') {
      final whyTextsEn = {
        'water': 'Water is your most critical resource. Without water you can survive maximum 3 days. Secure water first before everything else.',
        'food': 'Food gives you energy and strength to handle crisis situations. Your body needs nutrition to function optimally.',
        'light': 'Lighting is critical for safety and navigation. In darkness, accident risk increases and you cannot perform basic tasks.',
        'heat': 'Staying warm is vital, especially in winter. Hypothermia can develop quickly without adequate heat.',
        'radio': 'Radio is your lifeline to authority information during crises. Mobile networks and internet can be knocked out.',
        'cash': 'Cash works when cards and payment apps don\'t. Electronic payment systems may be down during crises.',
        'medicine': 'Medicine keeps you healthy and functional. Without necessary medicine, health conditions can quickly worsen.',
        'hygiene': 'Good hygiene prevents diseases and infections. During crises, hygiene is extra important to stay healthy.',
      };
      return whyTextsEn[item.category] ?? 'This is an important step in your preparedness.';
    } else {
      final whyTextsSv = {
        'water': 'Vatten är din viktigaste resurs. Utan vatten överlever du maximalt 3 dagar. Säkra vatten först innan allt annat.',
        'food': 'Mat ger dig energi och kraft att hantera krissituationer. Kroppen behöver näring för att fungera optimalt.',
        'light': 'Belysning är kritiskt för säkerhet och navigation. I mörker ökar risken för olyckor och du kan inte utföra grundläggande uppgifter.',
        'heat': 'Att hålla värmen är livsviktigt, särskilt vintertid. Hypotermi kan utvecklas snabbt utan adekvat värme.',
        'radio': 'Radio är din livlina till myndighetsinformation under kriser. Mobilnät och internet kan slås ut.',
        'cash': 'Kontanter fungerar när kort och betalappar inte gör det. Elektriska betalningssystem kan vara nere under kriser.',
        'medicine': 'Medicin håller dig frisk och funktionsduglig. Utan nödvändig medicin kan hälsotillstånd förvärras snabbt.',
        'hygiene': 'God hygien förebygger sjukdomar och infektioner. Under kriser är hygien extra viktigt för att hålla sig frisk.',
      };
      return whyTextsSv[item.category] ?? 'Detta är ett viktigt steg i din beredskap.';
    }
  }
  
  /// Get how to complete this step
  String _getHowToComplete(PreparednessItem item, String lang) {
    if (lang == 'en') {
      final howTextsEn = {
        'water': 'Buy bottled water or fill clean, sealed containers with tap water. Plan for ${item.baseQuantity} liters.',
        'food': 'Choose food that doesn\'t require refrigeration and has long shelf life. Canned goods, dry goods, energy bars.',
        'light': 'Get LED flashlights with batteries, candles and matches. Test that everything works.',
        'heat': 'Have extra blankets, warm clothes and a heat source that works without electricity (gas stove, camping).',
        'radio': 'Buy a battery-powered FM/AM radio with extra batteries. Test that it works.',
        'cash': 'Withdraw ${item.baseQuantity} kr in small bills from ATM. Store safely at home.',
        'medicine': 'Review your prescriptions and get extra supply. Have over-the-counter medicines at home.',
        'hygiene': 'Have toilet paper, soap, toothpaste, wet wipes. Think about handling hygiene without water.',
      };
      return howTextsEn[item.category] ?? 'Follow recommendations to complete this.';
    } else {
      final howTextsSv = {
        'water': 'Köp flaskvatten eller fyll rena, tättslutande kärl med kranvatten. Räkna med ${item.baseQuantity} liter.',
        'food': 'Välj mat som inte kräver kylning och har lång hållbarhet. Konserver, torrvaror, energibars.',
        'light': 'Skaffa LED-ficklampor med batterier, stearinljus och tändstickor. Testa att allt fungerar.',
        'heat': 'Ha extra filtar, varma kläder och en värmekälla som fungerar utan el (spiskök, camping).',
        'radio': 'Köp en batteridriven FM/AM-radio med extra batterier. Testa att den fungerar.',
        'cash': 'Ta ut ${item.baseQuantity} kr i småsedlar från bankomat. Förvara säkert hemma.',
        'medicine': 'Se över dina recept och skaffa extra förbrukning. Ha receptfria mediciner hemma.',
        'hygiene': 'Ha toalettpapper, tvål, tandkräm, våtservetter. Tänk på att hantera hygien utan vatten.',
      };
      return howTextsSv[item.category] ?? 'Följ rekommendationerna för att komplettera detta.';
    }
  }
  
  /// Get practical tips
  List<String> _getTips(PreparednessItem item, String lang) {
    if (lang == 'en') {
      final tipsMapEn = {
        'water': ['Use clean, sealed containers', 'Store cool and dark', 'Replace water every 6 months', 'Label containers with date'],
        'food': ['Choose food your family likes', 'Check expiration dates regularly', 'Include can opener', 'Consider special diets'],
        'light': ['LED lamps last longer', 'Have multiple light sources', 'Store batteries cool', 'Test regularly'],
        'heat': ['Camping stove for indoor use', 'Ventilate when using gas burner', 'Have fire extinguisher at home', 'Multiple layers of clothes warm best'],
        'radio': ['FM/AM radio recommended', 'Hand-crank radio works without batteries', 'Learn to find P4', 'Test radio regularly'],
        'cash': ['Small bills are best', 'Store safely but accessible', 'Don\'t share where money is', 'Update when needed'],
        'medicine': ['Track expiration dates', 'Store according to instructions', 'Have list of medicines', 'Include over-the-counter medicines'],
        'hygiene': ['Wet wipes for hygiene without water', 'Hand sanitizer good complement', 'Think about sanitary products', 'Have garbage bags'],
      };
      return tipsMapEn[item.category] ?? ['Follow MSB recommendations'];
    } else {
      final tipsMapSv = {
        'water': ['Använd rena, tättslutande kärl', 'Förvar svalt och mörkt', 'Byt ut vatten var 6:e månad', 'Märk kärl med datum'],
        'food': ['Välj mat familjen gillar', 'Kolla utgångsdatum regelbundet', 'Ha med konservöppnare', 'Tänk på specialkost'],
        'light': ['LED-lampor håller längre', 'Ha flera ljuskällor', 'Förvara batterier svalt', 'Testa regelbundet'],
        'heat': ['Campingkök för inomhusbruk', 'Ventilera vid gasbrännare', 'Ha brandsläckare hemma', 'Flera lager kläder värmer bäst'],
        'radio': ['FM/AM-radio rekommenderas', 'Vevradio fungerar utan batterier', 'Lär dig hitta P4', 'Testa radion regelbundet'],
        'cash': ['Småsedlar är bäst', 'Förvara säkert men tillgängligt', 'Dela inte med andra om var pengarna är', 'Uppdatera vid behov'],
        'medicine': ['Håll koll på utgångsdatum', 'Förvara enligt anvisningar', 'Ha lista på mediciner', 'Inkludera receptfria mediciner'],
        'hygiene': ['Våtservetter för hygien utan vatten', 'Handsprit bra komplement', 'Tänk på sanitetsartiklar', 'Ha grovsopspåsar'],
      };
      return tipsMapSv[item.category] ?? ['Följ MSB:s rekommendationer'];
    }
  }
}

/// Model for next step recommendation (bilingual)
class NextStepRecommendation {
  final PreparednessItem item;
  final String actionTitleSv;
  final String actionTitleEn;
  final String whyImportantSv;
  final String whyImportantEn;
  final String howToCompleteSv;
  final String howToCompleteEn;
  final List<String> tipsSv;
  final List<String> tipsEn;
  
  NextStepRecommendation({
    required this.item,
    required this.actionTitleSv,
    required this.actionTitleEn,
    required this.whyImportantSv,
    required this.whyImportantEn,
    required this.howToCompleteSv,
    required this.howToCompleteEn,
    required this.tipsSv,
    required this.tipsEn,
  });
  
  String getActionTitle(String languageCode) {
    return languageCode == 'en' ? actionTitleEn : actionTitleSv;
  }
  
  String getWhyImportant(String languageCode) {
    return languageCode == 'en' ? whyImportantEn : whyImportantSv;
  }
  
  String getHowToComplete(String languageCode) {
    return languageCode == 'en' ? howToCompleteEn : howToCompleteSv;
  }
  
  List<String> getTips(String languageCode) {
    return languageCode == 'en' ? tipsEn : tipsSv;
  }
}
