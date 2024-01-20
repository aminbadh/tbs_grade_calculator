import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../notifiers/document_state.dart';
import '../models/document.dart';

class DocumentActions extends StatelessWidget {
  const DocumentActions({
    super.key,
  });

  void _save(Document document) async {
    final key = "${document.title}.${DateTime.now().millisecondsSinceEpoch}";
    (await SharedPreferences.getInstance()).setString(key, document.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      overflowButtonSpacing: 18,
      children: [
        ElevatedButton(
          onPressed: () => _save(context.read<DocumentState>().document),
          child: const Text('Save'),
        ),
        if (kDebugMode)
          ElevatedButton(
            onPressed: () =>
                // ignore: avoid_print
                print(context.read<DocumentState>().document),
            child: const Text('Debug'),
          ),
        if (kDebugMode)
          ElevatedButton(
            onPressed: context.read<DocumentState>().refresh,
            child: const Text('Refresh'),
          ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Share'),
        ),
      ],
    );
  }
}
