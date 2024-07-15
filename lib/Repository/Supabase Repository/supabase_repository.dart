import 'package:TinyTunes/Models/Category%20Setting%20Model/settings_model.dart';
import 'package:TinyTunes/Repository/Settings%20Repo/settings_repo.dart';
// import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Models/videos_model/video_model.dart';
import '../../res/app_constants/app_constants.dart';

class SupabaseRepository {
  // Initialization of Supabase Instance
  final supabase = Supabase.instance.client;
  // Function called by bloc event and it returns the list of video model
  Future<List<VideoModel>> getVideos() async {
    try {
      // Getting the selected categories from local database hive.
      SettingsModel settingsModel = CategoryDatabase.getCategoryBox();
      List<String> categoriesList = settingsModel.categories;
      // Temp List that we will return after execution
      List<VideoModel> videoList = [];
      // Get the videos of dynamic categories at the same time.
      /// Categories must between 1 - 7.
      final response = await Future.wait(List.generate(categoriesList.length, (index) {
        return supabase.from(AppConstants.tableName).select().eq(AppConstants.category, categoriesList[index]);
      }));
      // Run the nested loop because the each response have a complete list of a single category.
      for (var element in response) {
        // Temp list for each category
        List<VideoModel> currentList = [];
        for (var e in element) {
          Map<String, dynamic> map = e;
          currentList.add(VideoModel.fromJson(map));
        }
        // Concatenating the lists.
        videoList = [...videoList, ...currentList];
      }
      // debugPrint('Videos length: ${videoList.length}');
      // Finally return the final list.
      return videoList;
    } catch (e) {
      throw e.toString();
    }
  }
}
