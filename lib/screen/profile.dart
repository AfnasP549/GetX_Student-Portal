import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_student_register/getx_controller/getx_controller.dart';
import 'package:getx_student_register/model/student_model.dart';


class ProfileScreen extends StatelessWidget {
  final int studentId;

  const ProfileScreen({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    final StudentController controller = Get.find<StudentController>();

    // Load student data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getStudent1(studentId);
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.student1.value == null) {
          return const Center(
            child: Text('Student not found'),
          );
        }

        final student = controller.student1.value!;
        return _buildStudentDetails(student, context);
      }),
    );
  }

  Widget _buildStudentDetails(Student student, BuildContext context) {
    final StudentController controller = Get.find<StudentController>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (student.imagePath != null &&
                File(student.imagePath!).existsSync())
              Column(
                children: [
                 
                  Center(
                    child: Container(
                      height: 400,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: FileImage(File(student.imagePath!)),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Name', student.name),
                    const SizedBox(height: 12),
                    _buildInfoRow('Admission Number', student.admissionNumber),
                    const SizedBox(height: 12),
                    _buildInfoRow('Course', student.course),
                    const SizedBox(height: 12),
                    _buildInfoRow('Contact', student.contact),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}