import 'package:flutter/material.dart';

import 'course.dart';

class GradeCalculator extends StatelessWidget {
  const GradeCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = <Course>[
      Course(),
      Course(),
      Course(),
      Course(),
      Course(),
    ];

    final children = [
      const SizedBox(height: 48),
      const GradeTitle(),
      const SizedBox(height: 24),
    ];

    if (MediaQuery.of(context).size.width > CourseCard.width * 2 + 144) {
      children.add(const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CourseCard(),
          CourseCard(),
        ],
      ));
    } else {
      for (var course in courses) {
        children.add(CourseCard(course: course));
      }
    }

    return SizedBox(
      width: 1200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: children,
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
    return TextField(
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.displaySmall,
      decoration: const InputDecoration(
        hintText: 'Untitled',
        border: InputBorder.none,
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, this.course});

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
              color: Colors.white, //FIXME - hardcoded,
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
