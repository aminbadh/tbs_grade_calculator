import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'course.dart';
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

    final nameController = TextEditingController(text: course.title);
    final creditController =
        TextEditingController(text: course.credit.toString());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        constraints: const BoxConstraints(maxWidth: CourseCard.width),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 20),
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Course Name',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          ),
                        ),
                      ),
                      controller: nameController,
                      onChanged: (value) {
                        course.title = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 24),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 72,
                        child: TextField(
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            isDense: true,
                            counterText: '',
                            hintText: '1',
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12,
                                width: 0,
                              ),
                            ),
                            suffixIcon: Icon(
                              size: 24,
                              Icons.bolt,
                              color: Colors.amber,
                            ),
                          ),
                          controller: creditController,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              course.credit = 0;
                              return;
                            }
                            try {
                              course.credit = int.parse(value);
                            } catch (e) {
                              course.credit = 1;
                              creditController.text = '';
                            }
                          },
                        ),
                      ),
                    ],
                  )
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
                      last: course.marks.length == 1,
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
    required this.last,
  });

  final Mark mark;
  final Function delete;
  final Function updateParent;
  final bool last;

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
          ),
          MarkTextField(
            controller: maxController,
            update: (val) => mark.max = val,
            updateParent: updateParent,
          ),
          MarkTextField(
            controller: weightController,
            update: (val) => mark.weight = val,
            updateParent: updateParent,
          ),
          Opacity(
            opacity: 0.7,
            child: InkWell(
              onTap: last ? null : () => delete(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(last ? null : Icons.remove_rounded, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MarkTextField extends StatelessWidget {
  const MarkTextField(
      {super.key,
      required this.controller,
      required this.update,
      required this.updateParent});

  final TextEditingController controller;
  final Function update;
  final Function updateParent;

  @override
  Widget build(BuildContext context) {
    final focus = FocusNode();
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: TextField(
          style: const TextStyle(fontSize: 14),
          focusNode: focus,
          maxLength: 3,
          controller: controller,
          decoration: const InputDecoration(
            isCollapsed: true,
            counterText: '',
            hintText: '0',
            border: InputBorder.none,
          ),
          //FIXME - doesn't work when switch focus to other text field
          onSubmitted: (val) {
            verify();
          },
          onTapOutside: (event) {
            if (focus.hasFocus) {
              verify();
              focus.unfocus();
            }
          },
        ),
      ),
    );
  }

  //FIXME - accept float values (mark can be float)
  void verify() {
    final value = controller.text;
    if (value.isEmpty) {
      update(0);
      controller.text = '';
    } else {
      final res = intify(value);
      update(res == -1 ? 0 : res);
      controller.text = res == -1 ? '' : res.toString();
    }
    updateParent();
  }

  int intify(String value) {
    try {
      return int.parse(value);
    } catch (e) {
      return -1;
    }
  }
}
