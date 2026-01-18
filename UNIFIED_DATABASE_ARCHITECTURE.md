# 🗄️ UNIFIED DATABASE ARCHITECTURE

## Overview

All preparedness data in the app is now stored in **ONE CENTRAL DATABASE** managed by `ItemsService`. This ensures complete synchronization across all screens and eliminates data duplication.

---

## 📦 Single Source of Truth

### **ItemsService** (`lib/core/services/items_service.dart`)

**Storage:** SharedPreferences (JSON)  
**Key:** `all_preparedness_items`

This is the **ONLY** place where preparedness items are stored and managed.

```dart
class ItemsService {
  // Get all items (default + custom)
  Future<List<PreparednessItem>> getAllItems()
  
  // Get items by level (24h, 72h, 7d)
  Future<List<PreparednessItem>> getItemsByLevel(String level)
  
  // Get items by level AND category
  Future<List<PreparednessItem>> getItemsByLevelAndCategory({
    required String level,
    required String category,
  })
  
  // Toggle item completion
  Future<void> toggleItemCompletion(String itemId)
  
  // Add custom item
  Future<void> addCustomItem({...})
  
  // Delete custom item
  Future<void> deleteCustomItem(String itemId)
  
  // Get progress by level
  Future<Map<String, double>> getProgressByLevel()
  
  // Get category progress
  Future<double> getCategoryProgress({
    required String level,
    required String category,
  })
}
```

---

## 🔄 Data Flow

```
┌─────────────────────────────────────────────────┐
│         SINGLE UNIFIED DATABASE                 │
│            ItemsService                         │
│       (SharedPreferences JSON)                  │
└─────────────────────────────────────────────────┘
                      ▲
                      │ Read/Write
        ┌─────────────┼─────────────┐
        │             │             │
        ▼             ▼             ▼
┌──────────────┐ ┌──────────┐ ┌──────────────┐
│ HomeScreen   │ │  Level   │ │  Category    │
│              │ │  Detail  │ │  Detail      │
│ - Progress   │ │  Screen  │ │  Screen      │
│   Circles    │ │          │ │              │
│ - Categories │ │ - 24h    │ │ - Water      │
│              │ │ - 72h    │ │ - Food       │
│              │ │ - 7d     │ │ - etc.       │
└──────────────┘ └──────────┘ └──────────────┘
```

**All screens:**
- ✅ Read from ItemsService
- ✅ Write to ItemsService
- ✅ Show same data
- ✅ Update immediately

---

## 📱 Screen Integration

### **1. LevelDetailScreen** (`lib/features/levels/screens/level_detail_screen.dart`)

Shows all items for a specific level (24h, 72h, or 7d).

```dart
class _LevelDetailScreenState extends State<LevelDetailScreen> {
  final ItemsService _itemsService = ItemsService();
  
  Future<void> _loadItems() async {
    // Load items from unified database
    final levelItems = await _itemsService.getItemsByLevel(widget.level);
    final progressMap = await _itemsService.getProgressByLevel();
    // ...
  }
  
  Future<void> _toggleItem(PreparednessItem item) async {
    // Save to unified database
    await _itemsService.toggleItemCompletion(item.id);
    await _loadItems(); // Reload to show updates
  }
}
```

**Features:**
- ✅ Loads items from ItemsService
- ✅ Groups items by category
- ✅ Saves checkbox changes to ItemsService
- ✅ Shows real-time progress

---

### **2. CategoryDetailScreen** (`lib/features/preparedness/presentation/screens/category_detail_screen.dart`)

Shows items for a specific category, filtered by level tabs.

```dart
class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final ItemsService _itemsService = ItemsService();
  
  Future<void> _loadItems() async {
    // Load items from unified database
    final levelItems = await _itemsService.getItemsByLevelAndCategory(
      level: selectedLevel,
      category: widget.categoryId,
    );
    // ...
  }
  
  Future<void> _toggleItem(PreparednessItem item) async {
    // Save to unified database
    await _itemsService.toggleItemCompletion(item.id);
    await _loadItems(); // Reload to show updates
  }
  
  Future<void> _showAddCustomItemDialog() async {
    // Add custom item to unified database
    await _itemsService.addCustomItem(...);
    await _loadItems();
  }
}
```

**Features:**
- ✅ Loads items from ItemsService
- ✅ Filters by level (24h/72h/7d tabs)
- ✅ Saves checkbox changes to ItemsService
- ✅ Adds custom items to ItemsService
- ✅ Deletes custom items from ItemsService

---

### **3. HomeScreen** (`lib/features/home/presentation/screens/home_screen.dart`)

Shows progress circles and category cards.

```dart
class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ItemsService _itemsService = ItemsService();
  
  Map<String, double> progressByLevel = {
    '24h': 0.0,
    '72h': 0.0,
    '7d': 0.0,
  };
  
  Future<void> _loadProgress() async {
    // Load progress from unified database
    final progress = await _itemsService.getProgressByLevel();
    setState(() {
      progressByLevel = progress;
    });
  }
  
  // Navigation with refresh
  onTap: () async {
    await Navigator.push(...);
    await _loadProgress(); // Refresh after returning
  }
}
```

**Features:**
- ✅ Loads progress from ItemsService
- ✅ Shows accurate percentages
- ✅ Refreshes after returning from detail screens
- ✅ Always synchronized

---

### **4. HomeProvider** (`lib/features/home/presentation/providers/home_provider.dart`)

State management for home screen.

```dart
class HomeNotifier extends StateNotifier<HomeState> {
  final _itemsService = ItemsService();
  
  Future<void> refreshProgress() async {
    // Use unified ItemsService for all progress tracking
    final progressByLevel = await _itemsService.getProgressByLevel();
    
    state = state.copyWith(
      progress24h: progressByLevel['24h'] ?? 0.0,
      progress72h: progressByLevel['72h'] ?? 0.0,
      progress7d: progressByLevel['7d'] ?? 0.0,
    );
  }
  
  Future<void> markItemComplete(String itemId, bool completed) async {
    // Save to unified ItemsService database
    await _itemsService.toggleItemCompletion(itemId);
    await refreshProgress();
  }
}
```

**Features:**
- ✅ Uses ItemsService for progress
- ✅ Uses ItemsService for item updates
- ✅ No more Hive usage for prep items

---

## 🗑️ Deprecated/Removed Systems

### **❌ Old Systems (DO NOT USE)**

1. **Hive `prep_items` box** - Replaced by ItemsService
2. **Old ProgressService** - Now uses ItemsService internally
3. **Separate category providers** - Replaced by direct ItemsService usage

### **⚠️ Migration Notes**

- Old `PrepItem` model still exists for backward compatibility
- HomeProvider still uses old models but reads from ItemsService
- Onboarding may still write to Hive (needs update)

---

## ✅ Benefits of Unified Database

### **1. Complete Synchronization**
- Check item in Level screen → Updates Category screen
- Check item in Category screen → Updates Level screen
- All changes → Update Home screen progress

### **2. No Data Duplication**
- Single storage location
- No conflicts between systems
- Consistent data everywhere

### **3. Immediate Updates**
- Changes save instantly
- UI refreshes automatically
- Progress always accurate

### **4. Simplified Architecture**
- One service to manage
- Easy to debug
- Clear data flow

---

## 🧪 Testing Synchronization

### **Test 1: Level → Category Sync**
1. Open 24h preparedness screen
2. Check "Dricksvatten (24h)"
3. Go to Water category → 24h tab
4. ✅ Same item is checked

### **Test 2: Category → Level Sync**
1. Open Water category → 72h tab
2. Check "Vattenreningstabletter"
3. Go to 72h preparedness screen
4. ✅ Same item is checked

### **Test 3: Progress Updates**
1. Check 3 items in 24h screen
2. Go to home screen
3. ✅ 24h circle shows ~30%
4. Check 2 more items in Water category
5. Go to home screen
6. ✅ 24h circle shows ~50%

### **Test 4: Persistence**
1. Check several items
2. Refresh page (F5)
3. ✅ All items still checked
4. ✅ Progress still accurate

---

## 📋 Summary

**Before:**
- ❌ Multiple storage systems (Hive, SharedPreferences, ProgressService)
- ❌ Data duplication
- ❌ Synchronization issues
- ❌ Inconsistent progress

**After:**
- ✅ Single unified database (ItemsService)
- ✅ No duplication
- ✅ Complete synchronization
- ✅ Accurate progress everywhere

**All screens now read and write to the SAME database!**

---

## 🔧 Future Improvements

1. **Migrate Onboarding** - Update to use ItemsService instead of Hive
2. **Remove Old Models** - Deprecate PrepItem in favor of PreparednessItem
3. **Clean Up Providers** - Simplify HomeProvider to use only ItemsService
4. **Add Sync Indicator** - Show when data is being saved/loaded

---

**Last Updated:** January 18, 2026  
**Architecture Version:** 2.0 - Unified Database
