import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/document.dart';
import '../utils.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'br rwa7',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const Text('a3mel login'),
          ],
        ),
      );
    }

    final query = FirebaseFirestore.instance
        .collection('documents')
        .where('owner', isEqualTo: user.uid)
        .orderBy('timestamp', descending: true);

    ButtonBar buttons([MainAxisAlignment? alignment]) => ButtonBar(
          alignment: alignment,
          overflowButtonSpacing: 12,
          children: [
            OutlinedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
              },
              child: const Text('Sign Out'),
            ),
            const SizedBox(width: 24),
            OutlinedButton(
              onPressed: () {
                user.delete();
                Navigator.of(context).pop();
              },
              child: const Text('Delete Account'),
            ),
          ],
        );

    final nameDisplay = Text(
      user.displayName ?? 'Ya Chsmk',
      style: Theme.of(context).textTheme.displayMedium,
      overflow: TextOverflow.ellipsis,
    );

    return LayoutBuilder(builder: (context, constraints) {
      final small = constraints.maxWidth < 900;
      return SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: small ? 24 : 72, vertical: 72),
        child: Center(
          child: SizedBox(
            width: 1200,
            child: Column(
              children: [
                if (small)
                  nameDisplay
                else
                  Row(
                    children: [
                      nameDisplay,
                      const Spacer(),
                      buttons(),
                    ],
                  ),
                const SizedBox(height: 48),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 4),
                          child: Text(
                            'Saved Documents',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 12),
                        FutureBuilder(
                          future: query.get(),
                          builder: (context, snapshot) {
                            final data = snapshot.data;
                            if (data == null) {
                              final error = snapshot.error;
                              if (error == null) {
                                return const Center(child: emptyWidget);
                              } else {
                                return Text(error.toString());
                              }
                            } else {
                              return CloudSavedDocuments(data.docs);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                if (small)
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: buttons(MainAxisAlignment.center),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class CloudSavedDocuments extends StatefulWidget {
  const CloudSavedDocuments(this.documents, {super.key});

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;

  @override
  State<CloudSavedDocuments> createState() => _CloudSavedDocumentsState();
}

class _CloudSavedDocumentsState extends State<CloudSavedDocuments> {
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  late List<bool> publics;

  String _title(String string) =>
      string.isEmpty ? DocumentDefaults.title : string;

  @override
  void initState() {
    documents = widget.documents;
    publics = documents.map((e) => e.get('public') == true).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (documents.isEmpty) {
      return const Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 36),
        child: Text('No saves found'),
      ));
    } else {
      return Column(
          children: documents.map(
        (doc) {
          final title = _title(doc.data()['document']['title'].toString());
          final date =
              DateTime.fromMillisecondsSinceEpoch(doc.get('timestamp'));

          toggleVisibility() async {
            await FirebaseFirestore.instance
                .doc(doc.reference.path)
                .update({'public': !doc.get('public')});
            setState(() {
              publics[documents.indexOf(doc)] =
                  !publics[documents.indexOf(doc)];
            });
          }

          final public = publics[documents.indexOf(doc)];

          return ListTile(
            title: Text(title),
            subtitle: Text(formatDate(date)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    FirebaseFirestore.instance.doc(doc.reference.path).delete();
                    setState(() {
                      publics.removeAt(documents.indexOf(doc));
                      documents.remove(doc);
                    });
                  },
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete',
                ),
                const SizedBox(width: 24),
                IconButton(
                  onPressed: toggleVisibility,
                  icon: Icon(
                    public ? Icons.groups : Icons.person,
                  ),
                  tooltip: 'Make ${public ? 'Private' : 'Public'}',
                )
              ],
            ),
            onTap: () => Navigator.of(context).pushNamed('/${doc.id}'),
          );
        },
      ).toList());
    }
  }
}
