
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Models/videos_modal/video_modal.dart';
import '../../res/app_constants/app_constants.dart';

class SupabaseRepository{

  final supabase = Supabase.instance.client;

  Future<List<VideoModal>> getAllVideos() async{
    try{
      List<VideoModal> videoList = [];
      final data = await supabase.from(AppConstants.tableName).select();
      for(var video in data){
        Map<String, dynamic> map = video;
        videoList.add(VideoModal.fromJson(map));
      }
      // debugPrint('Videos length: ${videoList.length}');
      return videoList;
    }catch(e){
      // debugPrint('Error in nested: ${e.toString()}');
      throw e.toString();
    }
  }

}