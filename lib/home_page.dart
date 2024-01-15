import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'document_state.dart';
import 'grade_calculator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final docState = context.watch<DocState>();
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: scheme.background,
        body: SizedBox.expand(
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: scheme.onBackground.withOpacity(0.02),
                ),
              ),
              const Positioned.fill(
                child: GradeCalculator(),
              ),
              Positioned(
                right: 24,
                bottom: 72,
                child: FloatingActionButton(
                  //tooltip: 'Add Course',
                  onPressed: docState.add,
                  child: const Icon(Icons.add_rounded),
                ),
              ),
              const Positioned(bottom: 0, left: 0, right: 0, child: Footer()),
              const Positioned(top: 0, left: 0, right: 0, child: Navbar()),
            ],
          ),
        ),
      ),
    );
  }
}

class Navbar extends StatelessWidget {
  const Navbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final docState = context.watch<DocState>();
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: docState.refresh,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calculate_outlined,
                    size: 36,
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
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final post = ['w/ Flutter', 'in 7ay 3icha'];
    final theme = Theme.of(context);

    return ClipRect(
      child: Container(
        color: theme.colorScheme.primary.withOpacity(0.05),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 48,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Made with '),
                    const Icon(
                      Icons.favorite,
                      color: Colors.amber,
                      size: 18,
                    ),
                    Text(' ${post[Random().nextInt(post.length)]}'),
                  ],
                ),
                const FooterVersion(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FooterVersion extends StatelessWidget {
  const FooterVersion({super.key});

  final _source = 'https://github.com/aminbadh/tbs_grade_calculator';

  Future<String> _version() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _version(),
      builder: (context, text) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => launchUrl(Uri.parse(_source)),
          child: Text("v${text.data ?? ''}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              )),
        ),
      ),
    );
  }
}
