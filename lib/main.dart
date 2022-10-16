import 'package:firebase_core/firebase_core.dart';
import 'package:firebasenote/Database/local_database.dart';
import 'package:firebasenote/modul/date.dart';
import 'package:firebasenote/screen/create_note_screen.dart';
import 'package:firebasenote/screen/home_screen.dart';
import 'package:firebasenote/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyDatabase.initDB();
  MyDate.initDate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        accentColor: Colors.deepOrangeAccent,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
          ),
        ),
      ),
      initialRoute: '/splash_screen',
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/splash_screen', page: () => SplashScreen()),
        GetPage(name: '/create_note_screen', page: () => CreateNoteScreen()),
      ],
    );
  }
}
