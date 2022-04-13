import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_with_getx/controllers/edit_controller.dart';
import 'package:note_app_with_getx/models/note_model.dart';

class EditPage extends StatefulWidget {
  EditPage({Key? key, this.note }) : super(key: key);
  Note? note;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<EditController>().titleController.value = TextEditingController(text: widget.note!.title);
    Get.find<EditController>().bodyController.value = TextEditingController(text: widget.note!.body);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GetX<EditController>(
      init: EditController(),
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Edit Note'),
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
                        controller: Get.find<EditController>().titleController(),
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
                        controller: Get.find<EditController>().bodyController(),
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
                        Get.find<EditController>().updatePost(id: widget.note!.id);
                      },
                      child: const Text('Save', style: TextStyle(fontSize: 17),),
                    ),

                  ],
                ),
                Get.find<EditController>().isLoading() ? const Center(child: CircularProgressIndicator(),) : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
