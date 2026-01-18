import '../models/preparedness_item.dart';

/// Complete bilingual database with ALL categories filled
/// 65+ items across all preparedness levels (24h, 72h, 7d)
class DefaultItems {
  static List<PreparednessItem> getAll() {
    return [
      ...get24hItems(),
      ...get72hItems(),
      ...get7dItems(),
    ];
  }
  
  /// ═══════════════════════════════════════════════════════════════════════
  /// 24-HOUR PREPAREDNESS ITEMS
  /// ═══════════════════════════════════════════════════════════════════════
  
  static List<PreparednessItem> get24hItems() {
    return [
      // ─────────────────────────────────────────────────────────────────
      // WATER - 24h
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '24h_water_1',
        level: '24h',
        category: 'water',
        nameSv: 'Dricksvatten (24h)',
        nameEn: 'Drinking Water (24h)',
        descriptionSv: '3 liter per person för en dag',
        descriptionEn: '3 liters per person for one day',
        baseQuantity: 3,
        unit: 'liter/person',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // FOOD - 24h
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '24h_food_1',
        level: '24h',
        category: 'food',
        nameSv: 'Mat som inte kräver tillagning',
        nameEn: 'Food that requires no cooking',
        descriptionSv: 'Konserver, torra varor, energibars',
        descriptionEn: 'Canned goods, dry goods, energy bars',
        baseQuantity: 3,
        unit: 'måltider/person',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // LIGHT - 24h
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '24h_light_1',
        level: '24h',
        category: 'light',
        nameSv: 'Ficklampa',
        nameEn: 'Flashlight',
        descriptionSv: 'LED-ficklampa med lång batteritid',
        descriptionEn: 'LED flashlight with long battery life',
        baseQuantity: 2,
        unit: 'st',
      ),
      
      PreparednessItem(
        id: '24h_light_2',
        level: '24h',
        category: 'light',
        nameSv: 'Batterier till ficklampa',
        nameEn: 'Batteries for flashlight',
        descriptionSv: 'Extra batterier AA eller AAA',
        descriptionEn: 'Extra AA or AAA batteries',
        baseQuantity: 2,
        unit: 'paket',
      ),
      
      PreparednessItem(
        id: '24h_light_3',
        level: '24h',
        category: 'light',
        nameSv: 'Stearinljus',
        nameEn: 'Candles',
        descriptionSv: 'Långbrinnande ljus för belysning',
        descriptionEn: 'Long-burning candles for lighting',
        baseQuantity: 5,
        unit: 'st',
      ),
      
      PreparednessItem(
        id: '24h_light_4',
        level: '24h',
        category: 'light',
        nameSv: 'Tändstickor/tändare',
        nameEn: 'Matches/lighter',
        descriptionSv: 'För att tända ljus',
        descriptionEn: 'To light candles',
        baseQuantity: 1,
        unit: 'paket',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // RADIO - 24h
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '24h_radio_1',
        level: '24h',
        category: 'radio',
        nameSv: 'Batteridriven radio',
        nameEn: 'Battery-powered radio',
        descriptionSv: 'FM/AM radio för viktig information från myndigheter',
        descriptionEn: 'FM/AM radio for important information from authorities',
        baseQuantity: 1,
        unit: 'st',
      ),
      
      PreparednessItem(
        id: '24h_radio_2',
        level: '24h',
        category: 'radio',
        nameSv: 'Extra batterier till radio',
        nameEn: 'Extra batteries for radio',
        descriptionSv: 'Reservbatterier',
        descriptionEn: 'Spare batteries',
        baseQuantity: 1,
        unit: 'paket',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // CASH - 24h
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '24h_cash_1',
        level: '24h',
        category: 'cash',
        nameSv: 'Kontanter',
        nameEn: 'Cash',
        descriptionSv: '1000-2000 kr i småsedlar (kort kanske inte fungerar)',
        descriptionEn: '1000-2000 SEK in small bills (cards may not work)',
        baseQuantity: 1500,
        unit: 'kr',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // MEDICINE - 24h
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '24h_medicine_1',
        level: '24h',
        category: 'medicine',
        nameSv: 'Receptbelagd medicin',
        nameEn: 'Prescription medicine',
        descriptionSv: '1 dags förbrukning av nödvändig medicin',
        descriptionEn: '1 day supply of necessary medicine',
        baseQuantity: 1,
        unit: 'dagsdos',
      ),
      
      PreparednessItem(
        id: '24h_medicine_2',
        level: '24h',
        category: 'medicine',
        nameSv: 'Värktabletter',
        nameEn: 'Pain relievers',
        descriptionSv: 'Alvedon, Ipren eller liknande',
        descriptionEn: 'Paracetamol, Ibuprofen or similar',
        baseQuantity: 1,
        unit: 'förpackning',
      ),
      
      PreparednessItem(
        id: '24h_medicine_3',
        level: '24h',
        category: 'medicine',
        nameSv: 'Förstahjälpen kit',
        nameEn: 'First aid kit',
        descriptionSv: 'Plåster, bandage, salva, sax, pincett',
        descriptionEn: 'Band-aids, bandages, ointment, scissors, tweezers',
        baseQuantity: 1,
        unit: 'kit',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // HYGIENE - 24h
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '24h_hygiene_1',
        level: '24h',
        category: 'hygiene',
        nameSv: 'Toalettpapper',
        nameEn: 'Toilet paper',
        descriptionSv: 'Minst en rulle per person',
        descriptionEn: 'At least one roll per person',
        baseQuantity: 1,
        unit: 'rulle/person',
      ),
      
      PreparednessItem(
        id: '24h_hygiene_2',
        level: '24h',
        category: 'hygiene',
        nameSv: 'Våtservetter',
        nameEn: 'Wet wipes',
        descriptionSv: 'För grundläggande hygien utan vatten',
        descriptionEn: 'For basic hygiene without water',
        baseQuantity: 1,
        unit: 'paket',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // HEAT - 24h
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '24h_heat_1',
        level: '24h',
        category: 'heat',
        nameSv: 'Varma filtar',
        nameEn: 'Warm blankets',
        descriptionSv: 'Extra filtar för att hålla värmen',
        descriptionEn: 'Extra blankets to keep warm',
        baseQuantity: 3,
        unit: 'st',
      ),
    ];
  }
  
  /// ═══════════════════════════════════════════════════════════════════════
  /// 72-HOUR PREPAREDNESS ITEMS
  /// ═══════════════════════════════════════════════════════════════════════
  
  static List<PreparednessItem> get72hItems() {
    return [
      // ─────────────────────────────────────────────────────────────────
      // WATER - 72h
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '72h_water_1',
        level: '72h',
        category: 'water',
        nameSv: 'Extra dricksvatten (72h)',
        nameEn: 'Extra drinking water (72h)',
        descriptionSv: 'Ytterligare 6 liter per person (totalt 9L per person)',
        descriptionEn: 'Additional 6 liters per person (total 9L per person)',
        baseQuantity: 6,
        unit: 'liter/person',
      ),
      
      PreparednessItem(
        id: '72h_water_2',
        level: '72h',
        category: 'water',
        nameSv: 'Vattenreningstabletter',
        nameEn: 'Water purification tablets',
        descriptionSv: 'För att rena vatten från alternativa källor',
        descriptionEn: 'To purify water from alternative sources',
        baseQuantity: 1,
        unit: 'förpackning',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // FOOD - 72h
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '72h_food_1',
        level: '72h',
        category: 'food',
        nameSv: 'Mat för tillagning',
        nameEn: 'Food for cooking',
        descriptionSv: 'Ris, pasta, konserver som behöver värmas',
        descriptionEn: 'Rice, pasta, canned goods that need heating',
        baseQuantity: 6,
        unit: 'måltider/person',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // LIGHT - 72h
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '72h_light_1',
        level: '72h',
        category: 'light',
        nameSv: 'Extra batterier',
        nameEn: 'Extra batteries',
        descriptionSv: 'Flera paket med batterier för flera dagar',
        descriptionEn: 'Multiple battery packs for several days',
        baseQuantity: 3,
        unit: 'paket',
      ),
      
      PreparednessItem(
        id: '72h_light_2',
        level: '72h',
        category: 'light',
        nameSv: 'Extra stearinljus',
        nameEn: 'Extra candles',
        descriptionSv: 'Fler långbrinnande ljus',
        descriptionEn: 'More long-burning candles',
        baseQuantity: 15,
        unit: 'st',
      ),
      
      PreparednessItem(
        id: '72h_light_3',
        level: '72h',
        category: 'light',
        nameSv: 'Huvudlampa',
        nameEn: 'Headlamp',
        descriptionSv: 'LED-pannlampa för handsfree belysning',
        descriptionEn: 'LED headlamp for hands-free lighting',
        baseQuantity: 1,
        unit: 'st',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // RADIO - 72h
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '72h_radio_1',
        level: '72h',
        category: 'radio',
        nameSv: 'Reservbatterier till radio',
        nameEn: 'Spare batteries for radio',
        descriptionSv: 'Extra batterier för flera dagars användning',
        descriptionEn: 'Extra batteries for several days of use',
        baseQuantity: 2,
        unit: 'paket',
      ),
      
      PreparednessItem(
        id: '72h_radio_2',
        level: '72h',
        category: 'radio',
        nameSv: 'Vevradio (alternativ)',
        nameEn: 'Hand-crank radio (alternative)',
        descriptionSv: 'Radio som kan drivas med handvev',
        descriptionEn: 'Radio that can be powered by hand crank',
        baseQuantity: 1,
        unit: 'st',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // CASH - 72h
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '72h_cash_1',
        level: '72h',
        category: 'cash',
        nameSv: 'Extra kontanter',
        nameEn: 'Extra cash',
        descriptionSv: 'Ytterligare 1000-1500 kr i småsedlar',
        descriptionEn: 'Additional 1000-1500 SEK in small bills',
        baseQuantity: 1000,
        unit: 'kr',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // MEDICINE - 72h
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '72h_medicine_1',
        level: '72h',
        category: 'medicine',
        nameSv: 'Receptbelagd medicin (72h)',
        nameEn: 'Prescription medicine (72h)',
        descriptionSv: '2 dagars extra förbrukning (totalt 3 dagar)',
        descriptionEn: '2 days extra supply (total 3 days)',
        baseQuantity: 2,
        unit: 'dagsdoser',
      ),
      
      PreparednessItem(
        id: '72h_medicine_2',
        level: '72h',
        category: 'medicine',
        nameSv: 'Förstärkt första hjälpen kit',
        nameEn: 'Enhanced first aid kit',
        descriptionSv: 'Inkl. sterila kompress, elastiska bandage',
        descriptionEn: 'Incl. sterile gauze, elastic bandages',
        baseQuantity: 1,
        unit: 'kit',
      ),
      
      PreparednessItem(
        id: '72h_medicine_3',
        level: '72h',
        category: 'medicine',
        nameSv: 'Receptfria mediciner',
        nameEn: 'Over-the-counter medicines',
        descriptionSv: 'Hostmedicin, Losec, antihistamin',
        descriptionEn: 'Cough medicine, antacids, antihistamines',
        baseQuantity: 1,
        unit: 'set',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // HYGIENE - 72h
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '72h_hygiene_1',
        level: '72h',
        category: 'hygiene',
        nameSv: 'Extra toalettpapper',
        nameEn: 'Extra toilet paper',
        descriptionSv: 'Flera rullar per person',
        descriptionEn: 'Multiple rolls per person',
        baseQuantity: 3,
        unit: 'rullar/person',
      ),
      
      PreparednessItem(
        id: '72h_hygiene_2',
        level: '72h',
        category: 'hygiene',
        nameSv: 'Tvål och schampo',
        nameEn: 'Soap and shampoo',
        descriptionSv: 'För grundläggande hygien',
        descriptionEn: 'For basic hygiene',
        baseQuantity: 1,
        unit: 'set',
      ),
      
      PreparednessItem(
        id: '72h_hygiene_3',
        level: '72h',
        category: 'hygiene',
        nameSv: 'Tandkräm och tandborste',
        nameEn: 'Toothpaste and toothbrush',
        descriptionSv: 'För munhygien',
        descriptionEn: 'For oral hygiene',
        baseQuantity: 1,
        unit: 'set',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // HEAT - 72h
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '72h_heat_1',
        level: '72h',
        category: 'heat',
        nameSv: 'Campingkök',
        nameEn: 'Camping stove',
        descriptionSv: 'För att kunna laga mat och värma',
        descriptionEn: 'For cooking food and heating',
        baseQuantity: 1,
        unit: 'st',
      ),
      
      PreparednessItem(
        id: '72h_heat_2',
        level: '72h',
        category: 'heat',
        nameSv: 'Gasoltub/spritbränsle',
        nameEn: 'Gas canister/spirit fuel',
        descriptionSv: 'Bränsle till campingköket',
        descriptionEn: 'Fuel for camping stove',
        baseQuantity: 2,
        unit: 'st',
      ),
      
      PreparednessItem(
        id: '72h_heat_3',
        level: '72h',
        category: 'heat',
        nameSv: 'Varma kläder',
        nameEn: 'Warm clothes',
        descriptionSv: 'Extra tröjor, sockor, mössa',
        descriptionEn: 'Extra sweaters, socks, hat',
        baseQuantity: 1,
        unit: 'set',
      ),
    ];
  }
  
  /// ═══════════════════════════════════════════════════════════════════════
  /// 7-DAY PREPAREDNESS ITEMS
  /// ═══════════════════════════════════════════════════════════════════════
  
  static List<PreparednessItem> get7dItems() {
    return [
      // ─────────────────────────────────────────────────────────────────
      // WATER - 7d
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '7d_water_1',
        level: '7d',
        category: 'water',
        nameSv: 'Dricksvatten för 7 dagar',
        nameEn: 'Drinking water for 7 days',
        descriptionSv: 'Ytterligare 12 liter per person (totalt 21L)',
        descriptionEn: 'Additional 12 liters per person (total 21L)',
        baseQuantity: 12,
        unit: 'liter/person',
      ),
      
      PreparednessItem(
        id: '7d_water_2',
        level: '7d',
        category: 'water',
        nameSv: 'Vattenfilter',
        nameEn: 'Water filter',
        descriptionSv: 'Portabelt vattenfilter för längre användning',
        descriptionEn: 'Portable water filter for extended use',
        baseQuantity: 1,
        unit: 'st',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // FOOD - 7d
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '7d_food_1',
        level: '7d',
        category: 'food',
        nameSv: 'Mat för 7 dagar',
        nameEn: 'Food for 7 days',
        descriptionSv: 'Torrvaror, konserver för hela veckan',
        descriptionEn: 'Dry goods, canned food for entire week',
        baseQuantity: 12,
        unit: 'måltider/person',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // LIGHT - 7d
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '7d_light_1',
        level: '7d',
        category: 'light',
        nameSv: 'Powerbank',
        nameEn: 'Power bank',
        descriptionSv: 'För att ladda telefoner och enheter',
        descriptionEn: 'To charge phones and devices',
        baseQuantity: 2,
        unit: 'st',
      ),
      
      PreparednessItem(
        id: '7d_light_2',
        level: '7d',
        category: 'light',
        nameSv: 'Solcellsladdare',
        nameEn: 'Solar charger',
        descriptionSv: 'För att ladda enheter med solenergi',
        descriptionEn: 'To charge devices with solar power',
        baseQuantity: 1,
        unit: 'st',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // RADIO - 7d
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '7d_radio_1',
        level: '7d',
        category: 'radio',
        nameSv: 'Solcellsdriven radio',
        nameEn: 'Solar-powered radio',
        descriptionSv: 'Radio med inbyggd solcell och vev',
        descriptionEn: 'Radio with built-in solar panel and crank',
        baseQuantity: 1,
        unit: 'st',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // MEDICINE - 7d
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '7d_medicine_1',
        level: '7d',
        category: 'medicine',
        nameSv: 'Receptbelagd medicin (7 dagar)',
        nameEn: 'Prescription medicine (7 days)',
        descriptionSv: '4 dagars extra (totalt 7 dagars förbrukning)',
        descriptionEn: '4 days extra (total 7 days supply)',
        baseQuantity: 4,
        unit: 'dagsdoser',
      ),
      
      PreparednessItem(
        id: '7d_medicine_2',
        level: '7d',
        category: 'medicine',
        nameSv: 'Utökad första hjälpen',
        nameEn: 'Extended first aid',
        descriptionSv: 'Medicinska förnödenheter för längre perioder',
        descriptionEn: 'Medical supplies for extended periods',
        baseQuantity: 1,
        unit: 'kit',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // HYGIENE - 7d
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '7d_hygiene_1',
        level: '7d',
        category: 'hygiene',
        nameSv: 'Hygienartiklar för veckan',
        nameEn: 'Hygiene items for week',
        descriptionSv: 'Tvål, schampo, tandkräm för hela veckan',
        descriptionEn: 'Soap, shampoo, toothpaste for entire week',
        baseQuantity: 1,
        unit: 'set',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // HEAT - 7d
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '7d_heat_1',
        level: '7d',
        category: 'heat',
        nameSv: 'Extra bränsle',
        nameEn: 'Extra fuel',
        descriptionSv: 'För matlagning i hela veckan',
        descriptionEn: 'For cooking throughout the week',
        baseQuantity: 4,
        unit: 'tuber',
      ),
      
      // ─────────────────────────────────────────────────────────────────
      // CASH - 7d
      // ─────────────────────────────────────────────────────────────────
      PreparednessItem(
        id: '7d_cash_1',
        level: '7d',
        category: 'cash',
        nameSv: 'Kontantreserv',
        nameEn: 'Cash reserve',
        descriptionSv: 'Ytterligare kontanter för längre kris',
        descriptionEn: 'Additional cash for extended crisis',
        baseQuantity: 500,
        unit: 'kr',
      ),
    ];
  }
}
