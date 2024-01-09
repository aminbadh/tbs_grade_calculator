import 'package:flutter/material.dart';

import 'course.dart';
import 'course_card.dart';

class GradeCalculator extends StatelessWidget {
  const GradeCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = [Course(), Course(), Course(), Course(), Course()];

    return Center(
      child: SizedBox(
        width: 1200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 38 + 80),
              const GradeTitle(),
              const SizedBox(height: 24),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 48,
                children: [
                  for (var course in courses) CourseCard(course: course)
                ],
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

class GradeTitle extends StatelessWidget {
  const GradeTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: TextField(
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displaySmall,
        decoration: const InputDecoration(
          hintText: 'Untitled',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12, width: 0),
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
