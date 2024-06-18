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
        color: theme.colorScheme.surface,
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
          SizedBox(width: small(context) ? 4 : 8),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/saves'),
            icon: const Icon(Icons.save_alt),
            tooltip: 'Local Saves',
          ),
          if (!small(context)) const SizedBox(width: 8)
        ],
      ),
    );
  }
}

class AccountNavbarWidget extends StatelessWidget {
  const AccountNavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user == null) {
            if (snapshot.error == null) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return emptyWidget;
              }
              return IconButton(
                onPressed: () => signIn(ScaffoldMessenger.of(context)),
                icon: const Icon(Icons.account_circle),
                tooltip: 'Sign In',
              );
            } else {
              showSnackbar(
                ScaffoldMessenger.of(context),
                snapshot.error.toString(),
              );
              return emptyWidget;
            }
          } else {
            return IconButton(
              onPressed: () => Navigator.of(context).pushNamed('/account'),
              icon: const Icon(Icons.account_circle),
              tooltip: 'Account',
            );
          }
        });
  }
}
