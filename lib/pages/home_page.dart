import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:note_app_with_getx/controllers/home_controller.dart';
import 'package:note_app_with_getx/pages/add_note_page.dart';
import 'package:note_app_with_getx/pages/edit_page.dart';
import 'package:note_app_with_getx/services/theme_mode.dart';
import 'package:note_app_with_getx/services/theme_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Get.find<HomeController>().apiPostList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final themeChanger = Provider.of<ThemeChanger>(context);

    return GetX<HomeController>(
      init: HomeController(),
      builder: (context) => Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text('Notes'),
          centerTitle: true,
          actions: [
            PopupMenuButton(
                icon: const Icon(Icons.menu),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () {
                      if(Get.isDarkMode) {
                        Get.changeThemeMode(ThemeMode.dark);
                        ThemeService().switchTheme();
                      }
                    },
                    child: const Text('Dark mode'),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      if(!Get.isDarkMode){
                        Get.changeThemeMode(ThemeMode.light);
                        ThemeService().switchTheme();
                      }
                    },
                    child: const Text('Light mode'),
                  ),
                ]
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(const AddNotePage())?.then((value) async{
              if(value != null) {
                  if (kDebugMode) {
                    print("This is message from AddPostPage $value");
                  }
                  await Get.find<HomeController>().apiPostList();
              }
            });
            // Get.snackbar("Shahobbiddin", "Nima gaplar?");
          },
          child: const Icon(Icons.add),
        ),
        body: Get.find<HomeController>().isLoading() ? const SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(child: CircularProgressIndicator(),),
        ) : RefreshIndicator(
            onRefresh: () async{
              Get.find<HomeController>().apiPostList();
            },
          child: ListView.builder(
          itemCount: Get.find<HomeController>().notes.length,
          itemBuilder: (BuildContext context, int index) {
            return Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.2,
                children: [
                  SlidableAction(
                    onPressed: (_){
                      Get.to(EditPage(note: Get.find<HomeController>().notes[index],))?.then((value) {
                        Get.find<HomeController>().apiPostList();
                      });
                    },
                    icon: Icons.edit,
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.2,
                children: [
                  SlidableAction(
                    onPressed: (_){
                      Get.find<HomeController>().apiDeletePost(Get.find<HomeController>().notes[index]);
                    },
                    icon: Icons.delete,
                  ),
                ],
              ),
              child: ListTile(
                title: Text(Get.find<HomeController>().notes[index].title),
                subtitle: Text(Get.find<HomeController>().notes[index].body, maxLines: 1,),
              ),
            );
          },
        ),
        ),
      ),
    );
  }

}
