import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../doc_state.dart';

class CourseNameInput extends StatelessWidget {
  const CourseNameInput(this.course, {super.key});

  final Course course;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: course.name);
    final focus = FocusNode();

    focus.addListener(() {
      if (!focus.hasPrimaryFocus) {
        controller.text = controller.text.trim();
        course.name = controller.text;
      }
    });

    return TextField(
      style: const TextStyle(fontSize: 20),
      controller: controller,
      focusNode: focus,
      decoration: const InputDecoration(
        isDense: true,
        hintText: CourseDefaults.name,
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class CreditInput extends StatelessWidget {
  const CreditInput(this.course, {super.key});

  final Course course;

  // Returns the string to display in the credit TextField
  String val(int? cr) => (cr == null) ? '' : cr.toString();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = TextEditingController(text: val(course.credit));
    final focus = FocusNode();

    focus.addListener(() {
      if (!focus.hasPrimaryFocus) {
        var value = controller.text;

        try {
          assert(value.length == 1);
          course.credit = int.parse(value);
        } catch (_) {
          course.credit = null;
          controller.text = '';
        }

        context.read<DocState>().refresh();
      }
    });

    return TextField(
      style: theme.textTheme.bodyLarge,
      controller: controller,
      focusNode: focus,
      maxLength: 1,
      decoration: InputDecoration(
        isDense: true,
        counterText: '',
        hintText: CourseDefaults.credit.toString(),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.colorScheme.onBackground.withOpacity(0.12),
            width: 0,
          ),
        ),
        suffixIcon: const Tooltip(
          message: 'Credit',
          child: Icon(
            size: 24,
            Icons.bolt,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
