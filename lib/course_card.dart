import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'course.dart';
import 'course_card_components.dart';
import 'document_state.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({
    super.key,
    required this.index,
  });

  static const double width = 12 * 12 * 3.5;

  final int index;

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    final docState = context.watch<DocState>();
    final course = docState.courses[widget.index];
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
            const Divider(
              color: Colors.black12,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              child: Column(
                children: [
                  Opacity(
                    opacity: 0.7,
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Mark',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Max',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Weight',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              course.marks.add(Mark());
                            });
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
                    MarkRow(
                      mark: mark,
                      length: course.marks.length,
                      delete: () {
                        setState(() {
                          course.marks.remove(mark);
                        });
                      },
                      updateParent: () => setState(() {}),
                    ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black12,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    // This is also used as the place to display errors.
                    child: Text(
                      gradeMessage(course),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => docState.remove(widget.index),
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

  String gradeMessage(Course course) {
    final grade = course.grade;
    return 'Grade: ${letter(grade)} (${grade.toStringAsFixed(2)})';
  }
}

class MarkRow extends StatelessWidget {
  const MarkRow({
    super.key,
    required this.mark,
    required this.delete,
    required this.updateParent,
    required this.length,
  });

  final Mark mark;
  final Function delete;
  final Function updateParent;
  final int length;

  @override
  Widget build(BuildContext context) {
    final markController = TextEditingController(text: mark.mark.toString());
    final maxController = TextEditingController(text: mark.max.toString());
    final weightController =
        TextEditingController(text: mark.weight.toString());

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          MarkTextField(
            controller: markController,
            update: (val) => mark.mark = val,
            updateParent: updateParent,
            empty: 0,
          ),
          MarkTextField(
            controller: maxController,
            update: (val) => mark.max = val,
            updateParent: updateParent,
            empty: 10,
          ),
          MarkTextField(
            controller: weightController,
            update: (val) => mark.weight = val,
            updateParent: updateParent,
            empty: double.parse((100 / length).toStringAsFixed(2)),
          ),
          Opacity(
            opacity: 0.7,
            child: InkWell(
              onTap: length == 1 ? null : () => delete(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child:
                    Icon(length == 1 ? null : Icons.remove_rounded, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MarkTextField extends StatelessWidget {
  const MarkTextField({
    super.key,
    required this.controller,
    required this.update,
    required this.updateParent,
    required this.empty,
  });

  final TextEditingController controller;
  final Function update;
  final Function updateParent;
  final double empty; // default value

  @override
  Widget build(BuildContext context) {
    final focus = FocusNode();
    focus.addListener(() {
      if (!focus.hasPrimaryFocus) verify();
    });

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: TextField(
          style: const TextStyle(fontSize: 14),
          focusNode: focus,
          maxLength: 6,
          controller: controller,
          decoration: InputDecoration(
            isCollapsed: true,
            counterText: '',
            hintText: empty.toStringAsFixed(2),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  void verify() {
    final value = controller.text;
    if (value.isEmpty) {
      update(empty);
      controller.text = '';
    } else {
      final res = convert(value);
      update(res == -1 ? empty : res);
      controller.text = res == -1 ? '' : res.toString();
    }
    updateParent();
  }

  double convert(String value) {
    try {
      return double.parse(value);
    } catch (e) {
      return -1;
    }
  }
}
