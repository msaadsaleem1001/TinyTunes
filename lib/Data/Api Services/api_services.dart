
import 'dart:convert';
import 'dart:io';
import '../../res/app_urls/app_urls.dart';
import '../app_exceptions.dart';
import 'base_api_services.dart';

class ApiServices extends BaseApiServices{

  // @override
  // Future<dynamic> getApi(String endPoint) async{
  //   try{
  //     final response = await http.get(
  //       BrukulUrls.baseUrl+endPoint,
  //     ).timeout(const Duration(seconds: 10));
  //
  //     switch(response.statusCode){
  //       case 200:
  //         return jsonDecode(response.data);
  //       case 400:
  //         throw InvalidUrlException();
  //       case 401:
  //         throw UnAuthorizedException();
  //       case 404:
  //         throw NotFoundException();
  //       case 503:
  //         throw ServiceUnavailableException();
  //       default:
  //         throw DefaultException();
  //         // throw FetchDataException('Error while fetching data + ${response.statusCode.toString()}');
  //     }
  //   }
  //   on SocketException{
  //     throw InternetException();
  //   }on RequestTimeOut{
  //     throw RequestTimeOut();
  //   }
  // }

}