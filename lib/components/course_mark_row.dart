import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../doc_state.dart';

class MarkRow extends StatelessWidget {
  const MarkRow(this.mark, this.last, {super.key, required this.delete});

  final Mark mark;
  final bool last;
  final Function delete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          MarkTextField(
            mark.mark,
            MarkDefaults.mark,
            update: (val) => mark.mark = val,
          ),
          MarkTextField(
            mark.max,
            MarkDefaults.max,
            update: (val) => mark.max = val,
          ),
          MarkTextField(
            mark.weight,
            MarkDefaults.weight,
            update: (val) => mark.weight = val,
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
    this.value,
    this.hint, {
    super.key,
    required this.update,
  });

  final double? value;
  final double hint;
  final Function update;

  // Returns a non-nullable display value
  String val(double? x) => (x == null) ? '' : x.toString();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DocState>();
    final controller = TextEditingController(text: val(value));
    final focus = FocusNode();

    focus.addListener(() {
      if (!focus.hasPrimaryFocus) {
        final value = controller.text;

        try {
          final res = double.parse(value);
          assert(res >= 0);
          update(res);
          controller.text = res.toString();
        } catch (_) {
          update(null);
          controller.text = '';
        }

        state.refresh();
      }
    });

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: TextField(
          style: const TextStyle(fontSize: 14),
          controller: controller,
          focusNode: focus,
          maxLength: 6,
          decoration: InputDecoration(
            isCollapsed: true,
            counterText: '',
            hintText: hint.toString(),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
