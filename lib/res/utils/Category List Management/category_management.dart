
import 'package:TinyTunes/res/app_constants/app_constants.dart';

class CategoryManagement {

  static List<bool> getBoolListAgainstCategoryList(List<String> categories){
    List<bool> boolList = [];
    if(categories.length < AppConstants.categoryList.length){
     for(var element in AppConstants.categoryList){
       if(categories.contains(element)){
         boolList.add(true);
       }else{
         boolList.add(false);
       }
     }
     return boolList;
    }else{
      int i = 0;
      while(i < AppConstants.categoryList.length) {
        boolList.add(true);
        i++;
      }
      return boolList;
    }
  }

  static List<String> getStringListFromBoolList(List<bool> boolList){
    List<String> newCategoryList = [];
    for(int i = 0; i < AppConstants.categoryList.length; i++){
      if(boolList[i] == true){
        newCategoryList.add(AppConstants.categoryList[i]);
      }
    }
    return newCategoryList;
  }

}