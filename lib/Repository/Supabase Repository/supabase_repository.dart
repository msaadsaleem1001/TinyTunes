
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tiny_tunes/Models/videos_modal/video_modal.dart';
import 'package:tiny_tunes/res/app_constants/app_constants.dart';

class SupabaseRepository{

  final supabase = Supabase.instance.client;

  Future<List<VideoModal>> getAllVideos() async{
    final data = await supabase.from(AppConstants.tableName).select();
    final jsonResponse = jsonEncode(data);
    debugPrint('Data = $data');
    debugPrint('Response = ${jsonDecode(jsonResponse).toList()}');
    return jsonDecode(jsonResponse).toList();
  }

}