import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_student_register/getx_controller/getx_controller.dart';
import 'package:getx_student_register/screen/add_student.dart';
import 'package:getx_student_register/widget/widget.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    studentController.loadStudents();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
        backgroundColor: Colors.yellow[200],
       
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: studentController.setSearchQuery,
              decoration: const InputDecoration(
                labelText: 'Search Students',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (studentController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final students = studentController.filteredStudents;

              if (students.isEmpty) {
                return const Center(child: Text('No students found'));
              }

              return  ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return buildStudentListTile(
                            context, student, studentController);
                      },
                    );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          studentController.clearImage();
          studentController.clearControllers();
          Get.to(() => AddStudentScreen())?.then((_) {
            studentController.loadStudents();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}