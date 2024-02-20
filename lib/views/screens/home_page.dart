// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_log__provider/model/database_functions.dart';
import 'package:student_log__provider/services/student_helper.dart';
import 'package:student_log__provider/views/screens/add_student_page.dart';
import 'package:student_log__provider/views/screens/student_list.dart';
import 'package:student_log__provider/views/styles/text_theme.dart';
import 'package:student_log__provider/views/styles/theme_colours.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Student Log - provider",
            style: text_bold(),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Provider",
                  style: text_bold(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                  child: Material(
                    elevation: 8, // Adjust the elevation value as needed
                    borderRadius: BorderRadius.circular(25),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddPage(
                            isEdit: false, 
                          ),
                        ));
                      },
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: purpleTheme(),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "lib/assets/newuser.png",
                              height: 80,
                              width: 80,
                            ),
                            Text(
                              "Register a new student",
                              style: text_bold(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 10),
                    child: Material(
                        elevation: 8, // Adjust the elevation value as needed
                        borderRadius: BorderRadius.circular(25),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => StudentList(),
                            ));
                          },
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: greenTheme(),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "lib/assets/db.png",
                                  height: 80,
                                  width: 80,
                                ),
                                Text(
                                  "Database of students",
                                  style: text_bold(),
                                )
                              ],
                            ),
                          ),
                        ))),
              ],
            ),
          ),
        ),
      );
    });
  }
}
