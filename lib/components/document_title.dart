import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/document.dart';
import '../notifiers/document_state.dart';

class DocumentTitle extends StatelessWidget {
  const DocumentTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final focus = FocusNode();
    final theme = Theme.of(context);
    final controller = TextEditingController(
      text: context.read<DocumentState>().document.title,
    );

    focus.addListener(() {
      if (!focus.hasPrimaryFocus) {
        controller.text = controller.text.trim();
        context.read<DocumentState>().document.title = controller.text;
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
              color: theme.colorScheme.onSurface.withOpacity(0.12),
              width: 0,
            ),
          ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
