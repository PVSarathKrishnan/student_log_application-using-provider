import 'dart:async';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'package:student_log__provider/model/database_functions.dart';
import 'package:student_log__provider/model/student_model.dart';
import 'package:student_log__provider/views/screens/add_student_page.dart';
import 'package:student_log__provider/views/screens/home_page.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  void initState() {
    super.initState();
    getStudents();
    studentCount();
  }

  final SearchController = TextEditingController();
  String searchText = '';
  Timer? debouncer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students list"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                  (route) => false);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
              child: TextFormField(
                controller: SearchController,
                onChanged: (value) {
                  onSearchChange(value);
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25))),
              ),
            ),
            SizedBox(
              height: 600,
              child: ValueListenableBuilder(
                  valueListenable: studentListNotifier,
                  builder: (BuildContext ctx, List<StudentModel> studentList,
                      Widget? child) {
                    return studentList.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  'https://assets-v2.lottiefiles.com/a/435a7e80-1153-11ee-a46f-7f1c0e4a511a/ePxvZATa5E.gif',
                                  height: 200,
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            itemBuilder: ((context, index) {
                              final data = studentList[index];
                              return Slidable(
                                endActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AddPage(
                                                  isEdit: true, stu: data),
                                            ));
                                      },
                                      icon: Icons.edit,
                                      backgroundColor: Colors.lightBlue,
                                    ),
                                  ],
                                ),
                                startActionPane: ActionPane(
                                    motion: const DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                          onPressed: (context) {
                                            deleteStudent(data.id!);
                                          },
                                          icon: Icons.delete,
                                          backgroundColor: Colors.red)
                                    ]),
                                child: ListTile(
                                  onTap: () {
                                    detailsSheet(
                                        context,
                                        data.id!,
                                        data.photo,
                                        data.name,
                                        data.gender,
                                        data.domain,
                                        data.dob,
                                        data.mobile,
                                        data.email);
                                  },
                                  leading: ClipRRect(
                                    child: Image.file(File(data.photo)),
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  title: Text(data.name),
                                  subtitle: Text(data.domain),
                                ),
                              );
                            }),
                            separatorBuilder: ((context, index) {
                              return const Padding(
                                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: Divider(),
                              );
                            }),
                            itemCount: studentList.length);
                  }),
            )
          ],
        ),
      ),
    );
  }

  void detailsSheet(BuildContext context, int id, String photo, String name,
      String gender, String domain, String dob, String mobile, String email) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              border:
                  Border.all(width: 20, color: Colors.white.withOpacity(0.8)),
            ),
            height: 600,
            width: double.infinity,
            child: Card(
              elevation: 5,
              shadowColor: Colors.blueAccent,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(File(photo)),
                  ),
                  Text(
                    "Name : $name",
                    style: textStyle(),
                  ),
                  Text(
                    "Gender : $gender",
                    style: textStyle(),
                  ),
                  Text(
                    "Domain : $domain",
                    style: textStyle(),
                  ),
                  Text(
                    "Date of birth : ${DateFormat('dd-MMM-yyyy').format(DateTime.parse(dob))}",
                    style: textStyle(),
                  ),
                  Text(
                    "Mobile : $mobile",
                    style: textStyle(),
                  ),
                  Text(
                    "Email : $email",
                    style: textStyle(),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        });
  }

  onSearchChange(String value) {
    final studendb = Hive.box<StudentModel>('student_db');
    final students = studendb.values.toList();
    value = SearchController.text;

    if (debouncer?.isActive ?? false) debouncer?.cancel();
    debouncer = Timer(Duration(milliseconds: 250), () {
      if (this.searchText != SearchController) {
        final filteredStudents = students
            .where((students) =>
                students.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
        studentListNotifier.value = filteredStudents;
      }
    });
  }

  TextStyle textStyle() => GoogleFonts.roboto(fontSize: 16);
}
