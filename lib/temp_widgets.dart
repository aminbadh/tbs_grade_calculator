import 'package:flutter/material.dart';

import 'course.dart';

class CourseCardTemp extends StatelessWidget {
  const CourseCardTemp({super.key, this.course});

  static const double width = 12 * 12 * 3;
  final Course? course;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: SizedBox(
          width: width,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            height: 200,
          ),
        ),
      ),
    );
  }
}

class DocumentResults extends StatelessWidget {
  const DocumentResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          height: 84,
        ),
      ),
    );
  }
}
