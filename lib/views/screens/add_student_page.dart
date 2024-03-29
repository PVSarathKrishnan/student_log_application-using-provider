import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:student_log__provider/model/database_functions.dart';
import 'package:student_log__provider/model/student_model.dart';
import 'package:student_log__provider/services/student_helper.dart';
import 'package:student_log__provider/services/validators.dart';
import 'package:student_log__provider/views/screens/home_page.dart';
import 'package:student_log__provider/views/screens/student_list.dart';

class AddPage extends StatefulWidget {
  AddPage({super.key, required this.isEdit, this.stu});

  bool isEdit = false;
  StudentModel? stu;

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _mobileController = TextEditingController();

  final _emailController = TextEditingController();

  final gender = ['male', 'female', 'others'];

  String selGender = '';

  final domainList = [
    'MERN - web development',
    'MEAN - web development',
    'Django and React',
    'Mobile development using Flutter',
    'Data Science',
    'Cyber security'
  ];

  String selDomain = '';

  File? _selectedImage;

  DateTime dob = DateTime.now();

  String? d;

  DateTime? db;

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      _selectedImage = File(widget.stu!.photo);
      _nameController.text = widget.stu!.name;
      selGender = widget.stu!.gender;
      selDomain = widget.stu!.domain;
      db = DateTime.parse(widget.stu!.dob);
      _mobileController.text = widget.stu!.mobile;
      _emailController.text = widget.stu!.email;
    }

    return Consumer<StudentProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
            title: widget.isEdit ? Text("Edit details") : Text("Add Details")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
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
                                  value.getImage(_selectedImage!);
                                }
                              },
                              child: Container(
                                height: 120,
                                width: 120,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(width: 2)),
                                child: _selectedImage != null
                                    ? Image.file(
                                        _selectedImage!,
                                        fit: BoxFit.fill,
                                      )
                                    : const Icon(Icons.photo),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _nameController,
                            validator: Validators.validateFullName,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(hintText: "Name"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Gender',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: gender.map((String value1) {
                                    return Container(
                                      margin: const EdgeInsets.only(right: 8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            value1,
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Radio(
                                            value: value1,
                                            groupValue: selGender,
                                            onChanged: (selectedValue) {
                                              selGender =
                                                  selectedValue.toString();
                                              value.getGender(selGender);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField(
                              // value: selDomain, - // exception happening
                              validator: (value) {
                                if (value == null) {
                                  return "select Domain";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Domain',
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color:
                                              Color.fromRGBO(117, 185, 237, 1)),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.black),
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              items: domainList.map((String domain) {
                                return DropdownMenuItem(
                                    value: domain, child: Text(domain));
                              }).toList(),
                              onChanged: (String? domain) {
                                value.getDomain(domain!);
                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              const Text("Date Of Birth"),
                              TextButton(
                                  onPressed: () async {
                                    final DateTime? pickedDate =
                                        await showDatePicker(
                                            context: context,
                                            initialDate: dob,
                                            firstDate: DateTime(1973),
                                            lastDate: DateTime(2025));
                                    if (pickedDate != null &&
                                        pickedDate != dob) {
                                      dob = pickedDate;
                                      value.getDOB(dob);
                                    }
                                  },
                                  child: Text(DateFormat('dd-MM-yyyy')
                                      .format(DateTime.parse("$dob")))),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: Validators.validateMobile,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: _mobileController,
                            decoration: const InputDecoration(
                              hintText: "Mobile ",
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: Validators.validateEmail,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: _emailController,
                            decoration:
                                const InputDecoration(hintText: "Email"),
                            keyboardType: TextInputType.emailAddress,
                          )
                        ],
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                widget.isEdit
                    ? ElevatedButton.icon(
                        onPressed: () {
                          edit(d = value.domain, db = value.dateOfBirth);
                        },
                        icon: const Icon(Icons.update),
                        label: const Text("Update"))
                    : ElevatedButton.icon(
                        onPressed: () {
                          submit(d = value.domain, db = value.dateOfBirth);
                        },
                        icon: const Icon(Icons.save),
                        label: const Text("Register"))
              ],
            ),
          ),
        ),
      ),
    );
  }

// ...
  Future<void> submit(String? d, DateTime? db) async {
    final imagePath = _selectedImage?.path;
    final name = _nameController.text.trim();
    final gender = selGender;
    final domain = d;
    final dob = db?.toString();
    final mobile = _mobileController.text.trim();
    final email = _emailController.text.trim();

    if (_formKey.currentState?.validate() ?? false) {
      if (imagePath != null && dob != null) {
        final student = StudentModel(
          photo: imagePath,
          name: name,
          gender: gender,
          domain: domain!,
          dob: dob,
          mobile: mobile,
          email: email,
        );
        addStudent(student);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enter all data'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter all data'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

//to update
  Future<void> edit(String? d, DateTime? db) async {
    int? id = widget.stu!.id;
    final imagePath = _selectedImage?.path;
    final name = _nameController.text.trim();
    final gender = selGender;
    final domain = d;
    final dob = db?.toString();
    final mobile = _mobileController.text.trim();
    final email = _emailController.text.trim();

    if (_formKey.currentState?.validate() ?? false) {
      if (imagePath != null && dob != null && gender != null) {
        editStudent(id!, imagePath, name, gender, domain!, dob, mobile, email);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => StudentList(),
            ),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enter all data'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter all data'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
