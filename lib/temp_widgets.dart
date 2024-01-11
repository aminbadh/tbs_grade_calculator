import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'course.dart';
import 'document_state.dart';

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
    final docState = context.watch<DocState>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: SizedBox(
              width: 400,
              child: Text(
                docState.courses.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      letterSpacing: 1,
                    ),
              ),
            ),
          )),
    );
  }
}
