import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'course.dart';
import 'course_card.dart';
import 'document.dart';
import 'document_state.dart';

class GradeCalculator extends StatelessWidget {
  const GradeCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<DocState>().courses;

    if (kDebugMode) {
      print(context.watch<DocState>().document.toString());
    }

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: 1200,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 38 + 80),
                const GradeTitle(),
                const SizedBox(height: 24),
                ...children(courses, MediaQuery.of(context).size.width),
                const DocumentResults(),
                const SizedBox(height: 60 + 72),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> children(List<Course> courses, double width) {
    if (width > CourseCard.width * 2 + 144) {
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
      return [for (var course in courses) CourseCard(course)];
    }
  }
}

class GradeTitle extends StatelessWidget {
  const GradeTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final docState = context.watch<DocState>();
    final document = docState.document;
    final controller = TextEditingController(text: document.title);
    final theme = Theme.of(context);
    final focus = FocusNode();

    focus.addListener(() {
      if (!focus.hasPrimaryFocus) {
        controller.text = controller.text.trim();
        document.title = controller.text;
      }
    });

    return IntrinsicWidth(
      child: TextField(
        textAlign: TextAlign.center,
        style: theme.textTheme.displaySmall,
        controller: controller,
        focusNode: focus,
        decoration: InputDecoration(
          hintText: DocumentDefaults.title,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme.colorScheme.onBackground.withOpacity(0.12),
              width: 0,
            ),
          ),
          border: const OutlineInputBorder(),
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
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const Opacity(
              opacity: 0.7,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Registered Credit',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Earned Credit',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'GPA',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    docState.document.registeredCredit.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Expanded(
                  child: Text(
                    docState.document.earnedCredit.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Expanded(
                  child: Text(
                    docState.document.gpa.toStringAsFixed(2),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
