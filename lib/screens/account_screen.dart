import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 144, vertical: 72),
      children: [
        Row(
          children: [
            Text(
              FirebaseAuth.instance.currentUser?.displayName ?? 'WTF!',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const Spacer(),
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
                FirebaseAuth.instance.currentUser?.delete();
                Navigator.of(context).pop();
              },
              child: const Text('Delete Account'),
            )
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
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(
                  height: 300,
                  child: Center(
                    child: Text('You have no saved documents.'),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
