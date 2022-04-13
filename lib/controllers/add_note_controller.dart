import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_with_getx/models/note_model.dart';
import 'package:note_app_with_getx/services/http_service.dart';

class AddNoteController extends GetxController{

  var titleController = TextEditingController().obs;
  var bodyController = TextEditingController().obs;
  var isLoading = false.obs;
  var notes = <Note>[].obs;


  void apiCreatePost(Note note) {
    isLoading.value = true;
    Network.POST(Network.API_POST, Network.paramsPost(note)).then((response) {
      if(response != null) {
        isLoading.value = false;
      }

    });
  }

  void uploadNote() {
    if(titleController().text.trim().isNotEmpty && bodyController().text.trim().isNotEmpty) {
      apiCreatePost(
          Note(title: titleController().text.trim(),  body: bodyController().text.trim())
      );
      Get.back(result: true);
    } else {
      if (kDebugMode) {
        print("Please fill all of them");
      }
    }
  }

}