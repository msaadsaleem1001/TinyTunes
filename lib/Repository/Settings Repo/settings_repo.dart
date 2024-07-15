import 'package:TinyTunes/res/app_constants/app_constants.dart';
// import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import '../../Models/Category Setting Model/settings_model.dart';

class CategoryDatabase {
  static const String categoryBox = "categoryBox";

  /// Initialize Hive and open the box
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SettingsModelAdapter());
    await Hive.openBox<SettingsModel>(categoryBox);
  }

  /// Add a new categoryBox to the box
  static Future<void> addCategoryBox(SettingsModel newCategoryBox) async {
    var box = Hive.box<SettingsModel>(categoryBox);
    await box.add(newCategoryBox);
  }

  /// Get categoryBox from the box
  static SettingsModel getCategoryBox() {
    try{
      // debugPrint('Called try');
      var box = Hive.box<SettingsModel>(categoryBox);
      // debugPrint('Values: ${box.values.single.type}');
      // debugPrint('Values: ${box.values.single.categories}');
      return box.values.single;
    }catch(e){
      // debugPrint('Catch Called: ${e.toString()}');
      return SettingsModel(type: 'Default', categories: AppConstants.categoryList);
    }
  }

  /// Update a categoryBox
  static Future<void> updateCategoryBox(SettingsModel newCategoryBox) async {
    // debugPrint('Update called');
    // debugPrint('Update type: ${newCategoryBox.type}');
    // debugPrint('Update cat.: ${newCategoryBox.categories}');
    var box = Hive.box<SettingsModel>(categoryBox);
    await box.put(0, newCategoryBox).whenComplete((){
      // debugPrint('Successfully Updated');
    });
  }

}
