import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

import '../model/st_model.dart';
import 'detailspage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Box box = Hive.box("student");
  late Box<StudentModel> students;
  TextEditingController nameclt = TextEditingController();
  TextEditingController rollclt = TextEditingController();
  TextEditingController ageclt = TextEditingController();
  TextEditingController classesclt = TextEditingController();
  TextEditingController detailsclt = TextEditingController();
  File? finalImage;
  String imageHint = 'Select Image';

  late StudentModel _studentModel;
  late Box<StudentModel> stdbox;

  void _addStudent(StudentModel addStudent) {
    stdbox.add(StudentModel(
      name: addStudent.name,
      roll: addStudent.roll,
      classes: addStudent.classes,
      age: addStudent.age,
      details: addStudent.details,
      //image: addStudent.image
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Students"),
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<StudentModel>('student').listenable(),
          builder: (context, Box<StudentModel> _studentModel, _) {
            stdbox = _studentModel;
            return Padding(
              padding: const EdgeInsets.only(top: 5),
              child: ListView.builder(
                  itemCount: _studentModel.length,
                  itemBuilder: (context, index) {
                    final std = stdbox.getAt(index);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => DetailsPage(),
                          //   ),
                          // );

                          Get.to(DetailsPage(
                            name: std.name,
                            roll: std.roll,
                            age: std.age,
                            classes: std.classes,
                            details: std.details,
                            index: index,
                          ));
                        },
                        child: Card(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    const Color.fromARGB(255, 203, 227, 246)),
                            child: ListTile(
                              title: Text(
                                std!.name,
                                style: const TextStyle(fontSize: 24),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    stdbox.deleteAt(index);
                                  },
                                  icon: Icon(Icons.delete)),
                              leading: Card(
                                  child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${index + 1}",
                                  style:
                                      const TextStyle(color: Colors.blueAccent),
                                ),
                              )),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => inputPage(),
        child: Icon(Icons.add),
        tooltip: "Add New Student",
      ),
    );
  }

  inputPage() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Input Student Details"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.name,
                  controller: nameclt,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Name...",
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: rollclt,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Roll...",
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: ageclt,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Age...",
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: classesclt,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Class...",
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  controller: detailsclt,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Student Details...",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Row(
                //   children: [
                //     Expanded(
                //         child: Text(
                //       imageHint,
                //      // overflow: TextOverflow.ellipsis,
                //     )),
                //     Expanded(
                //         child: IconButton(
                //       icon: Icon(Icons.image),
                //       onPressed: () {
                //         _getFormGallary();
                //       },
                //     ))
                //   ],
                // ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                print("djsh");
                _studentModel = StudentModel(
                  name: nameclt.text,
                  roll: rollclt.text,
                  classes: classesclt.text,
                  age: ageclt.text,
                  details: detailsclt.text,
                  // image: finalImage!,
                );

                _addStudent(_studentModel);

                nameclt.text = '';
                rollclt.text = '';
                ageclt.text = '';
                detailsclt.text = '';
                classesclt.text = '';
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  _getFormGallary() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxHeight: 1800, maxWidth: 1800);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      setState(() {
        finalImage = imageFile;
        imageHint = pickedFile.path;
      });
    }
  }

  @override
  void dispose() {
    stdbox.compact();
    stdbox.close();
    super.dispose();
  }
}
