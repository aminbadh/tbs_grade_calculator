import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../doc_state.dart';

class DocumentResults extends StatelessWidget {
  const DocumentResults({super.key});

  @override
  Widget build(BuildContext context) {
    final doc = context.watch<DocState>().document;
    final theme = Theme.of(context);

    final titles = ['Registered Credit', 'Earned Credit', 'GPA'];
    final content = [
      doc.registeredCredit.toString(),
      doc.earnedCredit.toString(),
      doc.gpa.toStringAsFixed(2)
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.colorScheme.background.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.onBackground.withOpacity(0.26),
          ),
        ),
        child: Column(
          children: [
            Opacity(
              opacity: 0.7,
              child: Row(
                children: [
                  for (final title in titles)
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                for (final item in content)
                  Expanded(
                    child: Text(
                      item,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge,
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
