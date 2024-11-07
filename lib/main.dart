// main.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/core/services/app_local_storage.dart';
import 'feature/intro/splash_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize hive db
  await Hive.initFlutter();
  //create or open a box(table name)...
  await Hive.openBox('user');
  //initialize app
  await AppLocalStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App Demo',
        //themeMode: ThemeMode.dark ,
      themeMode: ThemeMode.light,
      home: SplashScreen(),
    );
  }
}
