import 'package:flutter/material.dart';

import 'course.dart';
import 'course_card.dart';

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
      const SizedBox(height: 38 + 80),
      const GradeTitle(),
      const SizedBox(height: 24),
      const SizedBox(height: 60),
    ];

    if (MediaQuery.of(context).size.width > CourseCard.width * 2 + 144) {
      children.insert(
          3,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  for (int i = 0; i < courses.length; i += 2)
                    CourseCard(course: courses[i])
                ],
              ),
              Column(
                children: [
                  for (int i = 1; i < courses.length; i += 2)
                    CourseCard(course: courses[i]),
                  if (courses.length % 2 == 1) const AddCard(),
                ],
              ),
            ],
          ));
    } else {
      for (var course in courses) {
        children.insert(3, CourseCard(course: course));
      }
    }

    return Center(
      child: SizedBox(
        width: 1200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: children,
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
    // constraints: const BoxConstraints(minWidth: 200, maxWidth: 500),
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

class AddCard extends StatelessWidget {
  const AddCard({super.key});

  static const double width = 12 * 12 * 3;

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
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {},
              child: const Center(
                child: Icon(
                  Icons.add_rounded,
                  color: Colors.black38,
                  size: 64,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
