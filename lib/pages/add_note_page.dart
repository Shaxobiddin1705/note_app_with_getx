import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_with_getx/controllers/add_note_controller.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GetX<AddNoteController>(
      init: AddNoteController(),
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add Note'),
          centerTitle: true,
          actions: [
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              onPressed: (){
                Get.back();
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.amber),),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            height: height,
            width: width ,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    //#title
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Get.isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800
                      ),
                      child: TextField(
                        controller: Get.find<AddNoteController>().titleController(),
                        decoration: const InputDecoration(
                            hintText: 'Title',
                            border: InputBorder.none
                        ),
                      ),
                    ),

                    const SizedBox(height: 20,),

                    //#body
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Get.isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800
                      ),
                      child: TextField(
                        controller: Get.find<AddNoteController>().bodyController(),
                        decoration: const InputDecoration(
                            hintText: 'Body',
                            border: InputBorder.none
                        ),
                      ),
                    ),

                    const SizedBox(height: 30,),

                    MaterialButton(
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minWidth: width - 50,
                      height: 45,
                      onPressed: (){
                        Get.find<AddNoteController>().uploadNote();
                      },
                      child: const Text('Save', style: TextStyle(fontSize: 17),),
                    ),

                  ],
                ),
                Get.find<AddNoteController>().isLoading() ? const Center(child: CircularProgressIndicator(),) : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
