import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.25),
            offset: const Offset(0.0, 1.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pushNamed('/'),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Opacity(
                    opacity: 0.9,
                    child: Icon(
                      Icons.calculate_outlined,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Grade Calculator',
                    style: theme.textTheme.titleLarge,
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          const AccountNavbarWidget(),
          const SizedBox(width: 4),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/saves'),
            icon: const Icon(Icons.settings_rounded),
            tooltip: 'Settings',
          ),
          if (!small(context)) const SizedBox(width: 8)
        ],
      ),
    );
  }
}

class AccountNavbarWidget extends StatelessWidget {
  const AccountNavbarWidget({super.key});

  void _signIn(ScaffoldMessengerState scaffoldMessenger) async {
    try {
      await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
    } catch (e) {
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    onPressed() => _signIn(ScaffoldMessenger.of(context));

    return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user == null) {
            if (snapshot.error == null) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return emptyWidget;
              }
              return small(context)
                  ? IconButton(
                      onPressed: onPressed,
                      icon: const Icon(Icons.account_circle),
                      tooltip: 'Sign In',
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: OutlinedButton(
                        onPressed: onPressed,
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text('Sign In'),
                      ),
                    );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(snapshot.error.toString())));
              return emptyWidget;
            }
          } else {
            return IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.account_circle),
              tooltip: 'Sign Out',
            );
          }
        });
  }
}
