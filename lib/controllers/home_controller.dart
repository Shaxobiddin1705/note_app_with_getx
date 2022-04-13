import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:note_app_with_getx/models/note_model.dart';
import 'package:note_app_with_getx/services/http_service.dart';

class HomeController extends GetxController{

  var isLoading = false.obs;
  var notes = <Note>[].obs;


  Future<void> apiPostList() async {
    isLoading.value = true;

    Network.GET(Network.API_GET, Network.paramsEmpty()).then((response) {
      if(response != null) {
        showResponse(response);
      } else {
        isLoading.value = false;
      }
    });
  }

  void showResponse(String? response) {
    isLoading.value = false;

    if (response != null) {
      notes.value = Network.parseResponse(response);
    }
  }

  void apiDeletePost(Note note) {
    notes.remove(note);

    Network.DELETE(Network.API_DELETE + note.id, Network.paramsEmpty()).then((response) {
      if(response != null) {
        if (kDebugMode) {
          print(response);
        }
        apiPostList();
      }
    });
  }

}