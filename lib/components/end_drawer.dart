import 'package:flutter/material.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            height: 64,
            child: Center(
                child: Text(
              'Menu',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            )),
          ),
          ListTile(
            title: const Text(
              'Saves',
              style: TextStyle(fontSize: 18),
            ),
            leading: const Icon(Icons.save_outlined, size: 20),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/saves');
            },
          ),
        ],
      ),
    );
  }
}
