
// App Constants that are Expense table name and its column names.
class AppConstants {

  static const String confirmationSave = 'Are you sure to save these categories?';

  static const String confirmationSaveDefault = 'Are you sure to save default settings?';

  static const String tableName = 'tiny_tunes';

  // Table column names.
  static const String id = 'id';
  static const String title = 'title';
  static const String url = 'url';
  static const String duration = 'duration';
  static const String category = 'category';
  static const String lang = 'lang';
  static const String videoId = 'video_id';
  static const String channelName = 'channel_name';
  static const String createdAt = 'created_at';

  static const List<String> langList = ['ENGLISH', 'HINDI'];
  static const Map<String, String> langListValue = {'ENGLISH': 'ENG', 'HINDI': 'HI'};

  static const List<String> categoryList = ['ISLAMIC', 'FUN LEARNING', 'CRAFTS', 'POEMS', 'TOYS', 'ANIMALS', 'OTHERS'];

}