
import 'package:hive/hive.dart';
part 'settings_model.g.dart';

@HiveType(typeId: 0)
class SettingsModel {
  @HiveField(0)
  final String type;

  @HiveField(1)
  final List<String> categories;

  SettingsModel({required this.type, required this.categories});
}