// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_log__provider/views/screens/add_student_page.dart';
import 'package:student_log__provider/views/styles/theme_colours.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Log"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                // Use Expanded instead of Flexible
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 8,
                    bottom: 8,
                  ),
                  child: Container(
                    height: 60,
                    width: 60,
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: purpleTheme(),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(22),
                              bottomLeft: Radius.circular(22)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  right: 8,
                  bottom: 8,
                ),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(22),
                          bottomRight: Radius.circular(22)),
                      color: purpleTheme()),
                  child: IconButton(
                    onPressed: () {
                      //search function
                    },
                    icon: Icon(
                      Icons.search,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddStudentPage(),
              ));
        },
        backgroundColor: Colors.white,
        child: Icon(Icons.person_add_alt_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
