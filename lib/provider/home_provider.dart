
import 'dart:typed_data';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:pixabay_application/controller/api_helper.dart';
import 'package:pixabay_application/modal/home_modal.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';
class HomeProvider extends ChangeNotifier
{
  //todo variables-;
  String result='';
  int selectIndex=0;
  ApiModal? apiModalSnap;
  GlobalKey imageKey=GlobalKey();
  ApiHelper apiHelper=ApiHelper();
  late ApiModal apiModal;
  TextEditingController textEditingController=TextEditingController(text: "");

  //todo Methods-
  Future<ApiModal> fetchApiData()
  async {
    final list = await apiHelper.apiCalling(textEditingController.text.replaceAll(' ', '+'));
    apiModal= ApiModal.fromJson(list);
    return apiModal;
  }
  void indexSelectingMethod(int index)
  {
    selectIndex = index;
    notifyListeners();
  }
  Future<void> wallpaperMethod(int value)
  async {
    await AsyncWallpaper.platformVersion ?? "Unknown platform version";
    try{
      result = await AsyncWallpaper.setWallpaper(url: apiModalSnap!.hits[selectIndex].largeImageURL,
        wallpaperLocation: (value==1)?AsyncWallpaper.HOME_SCREEN:(value==2)?AsyncWallpaper.LOCK_SCREEN:AsyncWallpaper.BOTH_SCREENS,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error()
      )?"Wallpaper set":"Failed to get Wallpaper" ;
    }on Error catch (_){
      result="Failed to get wallpaper";
    }
    print(result);
    notifyListeners();
  }
  Future<void> imageDownloadMethod()
  async {
    var response = await Dio().get(apiModalSnap!.hits[selectIndex].largeImageURL,
    options: Options(
      responseType: ResponseType.bytes,
    ),
    );
    final result= ImageGallerySaver.saveImage(Uint8List.fromList(response.data),quality: 60,name: "pixabay");
    print(result);
    notifyListeners();
  }
  void txtSearch()
  {
    notifyListeners();
  }
}
  // List<ApiModal> pixabayList=[];
