import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:student_log__provider/model/student_model.dart';
import 'package:student_log__provider/services/student_helper.dart';
import 'package:student_log__provider/views/screens/home_page.dart';
import 'package:student_log__provider/views/styles/theme_colours.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.openBox<StudentModel>("student_db");

  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student log - provider',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: purpleTheme()),
          useMaterial3: true,
        ),
        home: HomePage(),
      ),
    );
  }
}

