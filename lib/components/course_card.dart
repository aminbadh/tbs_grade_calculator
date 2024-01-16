import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import 'course_card_inputs.dart';
import '../doc_state.dart';
import 'course_mark_row.dart';

class CourseCard extends StatelessWidget {
  const CourseCard(this.course, {super.key});

  static const double width = 12 * 12 * 3.5;

  final Course course;

  String gradeMessage(double grade) =>
      'Grade: ${letter(grade)} (${grade.toStringAsFixed(2)})';

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DocState>();
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        constraints: const BoxConstraints(maxWidth: CourseCard.width),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.onBackground.withOpacity(0.26),
            width: 0,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(child: CourseNameInput(course)),
                  const SizedBox(width: 24),
                  SizedBox(
                    width: 72,
                    child: CreditInput(course),
                  ),
                ],
              ),
            ),
            Divider(
              color: theme.colorScheme.onBackground.withOpacity(0.12),
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                children: [
                  Opacity(
                    opacity: 0.7,
                    child: Row(
                      children: [
                        for (final txt in ['Mark', 'Max', 'Weight'])
                          Expanded(
                            child: Text(
                              style: const TextStyle(fontSize: 16),
                              txt,
                            ),
                          ),
                        InkWell(
                          onTap: () {
                            course.marks.add(Mark());
                            state.refresh();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Icon(Icons.add_rounded, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  for (var mark in course.marks)
                    MarkRow(mark, course.marks.length == 1, delete: () {
                      course.marks.remove(mark);
                      state.refresh();
                    }),
                ],
              ),
            ),
            Divider(
              color: theme.colorScheme.onBackground.withOpacity(0.12),
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        gradeMessage(course.grade), //TODO - display errors
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => state.remove(course),
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Remove',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
