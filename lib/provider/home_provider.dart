import 'package:flutter/material.dart';
import 'package:pixabay_application/controller/api_helper.dart';
import 'package:pixabay_application/modal/home_modal.dart';

class HomeProvider extends ChangeNotifier
{
  ApiHelper apiHelper=ApiHelper();
  late ApiModal apiModal;
  TextEditingController textEditingController=TextEditingController(text: "");
  // List<ApiModal> pixabayList=[];
  Future<ApiModal> fetchApiData()
  async {
    final list = await apiHelper.apiCalling(textEditingController.text);
    apiModal= ApiModal.fromJson(list);
    return apiModal;
  }
  void txtSearch()
  {
    notifyListeners();
  }
}