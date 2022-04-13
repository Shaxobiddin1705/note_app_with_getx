import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_app_with_getx/pages/add_note_page.dart';
import 'package:note_app_with_getx/pages/home_page.dart';
import 'package:note_app_with_getx/services/di_service.dart';
import 'package:note_app_with_getx/services/theme_mode.dart';
import 'package:note_app_with_getx/services/theme_service.dart';

void main() async{
  await DIService.init();
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Note app GetX',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: const HomePage(),
      getPages: [
        GetPage(name: "/home_page", page: () => const HomePage(),),
        GetPage(name: "/add_note_page", page: () => const AddNotePage(),),
      ],
    );
  }
}