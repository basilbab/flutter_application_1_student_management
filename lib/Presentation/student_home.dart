import 'package:flutter/material.dart';
import 'package:flutter_application_1_student_management/Model/student_model.dart';

class ScreenStudentHome extends StatefulWidget {
  const ScreenStudentHome({super.key});

  @override
  State<ScreenStudentHome> createState() => _ScreenStudentHomeState();
}

class _ScreenStudentHomeState extends State<ScreenStudentHome> {
  List<StudentModel> studentsList = [];
  final studentNameController = TextEditingController();
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: studentNameController,
                      decoration: InputDecoration(
                        hintText: 'Student Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      counter = counter + 1;
                      StudentModel s = StudentModel(
                        id: '$counter'.toString(),
                        studentName: studentNameController.text,
                        studentStatus: '1',
                      );
                      addStudent(s);
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      changeStatus(
                        studentsList[index].id,
                        studentsList[index].studentStatus,
                      );
                    },
                    leading: Text('${index + 1}'.toString()),
                    title: Text(studentsList[index].studentName),
                    subtitle: Text(
                      studentsList[index].studentStatus == '0'
                          ? 'Status:Inactive'
                          : 'Status:Active',
                      style: TextStyle(
                        color:
                            studentsList[index].studentStatus == '0'
                                ? Colors.red
                                : Colors.green,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        deleteStudent(studentsList[index].id);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: studentsList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addStudent(StudentModel s) {
    setState(() {
      studentsList.add(s);
    });
  }

  void deleteStudent(String id) {
    setState(() {
      studentsList.removeWhere((test) => test.id == id);
    });
  }

  void changeStatus(String id, String status) {
    for (var doc in studentsList) {
      if (doc.id == id) {
        String newStatus = status == '0' ? '1' : '0';
        doc.studentStatus = newStatus;
      }
    }
  }
}
