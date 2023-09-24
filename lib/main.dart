// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app_with_hive_db/model/st_model.dart';
import 'package:student_app_with_hive_db/pages/home.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final applicatonDocumentDir =
      await path_provider.getApplicationCacheDirectory();
  await Hive.initFlutter();
  // Add any necessary Hive adapter registrations here

  Hive.registerAdapter(StudentModelAdapter());
  await Hive.openBox<StudentModel>('student');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const HomePage(),
    );
  }
}
