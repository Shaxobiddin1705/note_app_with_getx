import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_with_getx/models/note_model.dart';
import 'package:note_app_with_getx/services/http_service.dart';

class EditController extends GetxController{

  var isLoading = false.obs;

  var titleController = TextEditingController().obs;
  var bodyController = TextEditingController().obs;

  void updatePost({required id}) async{
    isLoading.value = true;
    String title = titleController().text.trim().toString();
    String body = bodyController().text.trim().toString();
    Note note = Note(title: title, body: body);
    if(title.isNotEmpty && body.isNotEmpty) {
      await Network.UPDATE(Network.API_UPDATE + id, Network.paramsUpdate(note)).then((value){
        getResponse();
      });
    }
  }

  void getResponse() {
    isLoading.value = false;
    Get.back(result: true);
  }

}