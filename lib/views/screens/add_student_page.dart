// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:student_log__provider/views/styles/theme_colours.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final gender = ["male", "female", "Others"];
  String selGender = "";
  final domainList = [
    'MERN',
    'MEAN',
    'Django and React',
    'Flutter',
    'Data Science',
    'Cyber security',
    "GoLang",
    "Java",
    "Unity Game Development",
    "DevOps"
  ];
  String selDomain = "";
  File? _selectedImage;
  DateTime dob = DateTime.now();
  String? d;
  DateTime? db;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add student information"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            final picker = ImagePicker();
                            final pickedImage = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (pickedImage != null) {
                              _selectedImage = File(pickedImage.path);
                              //value.getImage
                            }
                          },
                          child: Container(
                              height: 120,
                              width: 120,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  color: purpleTheme(),
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(width: 1)),
                              child: _selectedImage != null
                                  ? Image.file(
                                      _selectedImage!,
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.fill,
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_a_photo_rounded,
                                        ),
                                        Text("Add a photo")
                                      ],
                                    )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autocorrect: true,
                          controller: _nameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              hintText: "Student Name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(22))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autocorrect: true,
                          controller: _emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              hintText: "Email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(22))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autocorrect: true,
                          controller: _mobileController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              hintText: "Mobile",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(22))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(22)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Gender : "),
                              ),
                              Row(
                                children: gender.map((String value1) {
                                  return Container(
                                    margin: EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Text(value1),
                                        Radio(
                                          value: value1,
                                          groupValue: selGender,
                                          onChanged: (Selectedvalue) {
                                            selGender =
                                                Selectedvalue.toString();
                                            //value.getGender(SelGender)
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(), // Convert the Iterable<Container> to List<Widget>
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                          validator: (value) {
                            if (value == null) {
                              return "Select a domain";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Domain',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(22)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(10.0))),
                          items: domainList.map((String domain) {
                            return DropdownMenuItem(
                              child: Text(domain),
                              value: domain,
                            );
                          }).toList(),
                          onChanged: (String? domain) {
                            //value.getDomain
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                           decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Choose Date of Birth : "),
                              ),
                              TextButton(
                                  onPressed: () async {
                                    final DateTime? pickedDate =
                                        await showDatePicker(
                                            context: context,
                                            initialDate: dob,
                                            firstDate: DateTime(1990),
                                            lastDate: DateTime(2025));
                                    if (pickedDate != null && pickedDate != dob) {
                                      dob = pickedDate;
                                      // value.getDOB(dob)
                                    }
                                  },
                                  child: Container(
                                   
                                    child: Text(DateFormat('dd-MM-yyyy',)
                                        .format(DateTime.parse("$dob")),textAlign: TextAlign.center,),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //save details function
        },
        label: Text("Save"),
        icon: Icon(
          Icons.save,
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
