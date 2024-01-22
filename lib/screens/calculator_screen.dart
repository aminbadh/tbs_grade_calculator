import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/document_actions.dart';
import '../components/document_results.dart';
import '../components/document_title.dart';
import '../components/course_card.dart';
import '../notifiers/document_state.dart';
import '../models/course.dart';
import '../utils.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  List<Widget> _children(List<Course> courses, double width) {
    if (width > CourseCard.width * 2 + 84) {
      final odd = courses.length % 2 == 1;
      final len = courses.length - (odd ? 1 : 0);
      return [
        if (len > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  for (int i = 0; i < len; i += 2) CourseCard(courses[i]),
                ],
              ),
              Column(
                children: [
                  for (int i = 1; i < len; i += 2) CourseCard(courses[i]),
                ],
              ),
            ],
          ),
        if (odd) CourseCard(courses[len]),
      ];
    } else {
      return [for (final course in courses) CourseCard(course)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor(context),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 1200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: LayoutBuilder(builder: (context, constraints) {
                return Column(
                  children: [
                    const SizedBox(height: 38),
                    const DocumentTitle(),
                    const SizedBox(height: 24),
                    ..._children(
                      context.watch<DocumentState>().courses,
                      constraints.maxWidth,
                    ),
                    const DocumentResults(),
                    const DocumentActions(),
                    const SizedBox(height: 84),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 8, bottom: 4),
        child: FloatingActionButton(
          onPressed: context.read<DocumentState>().add,
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}
