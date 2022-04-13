import 'package:get/get.dart';
import 'package:note_app_with_getx/controllers/add_note_controller.dart';
import 'package:note_app_with_getx/controllers/edit_controller.dart';
import 'package:note_app_with_getx/controllers/home_controller.dart';

class DIService{

  static Future<void> init() async{
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<AddNoteController>(() => AddNoteController(), fenix: true);
    Get.lazyPut<EditController>(() => EditController(), fenix: true);
  }

}