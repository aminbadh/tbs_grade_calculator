import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'grade_calculator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final padding = 12.0 * 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - padding,
                    height: 80,
                  ),
                ),
                const Expanded(child: GradeCalculator()),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: padding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: 6,
                        children: [
                          const Text('Made with'),
                          Icon(
                            Icons.favorite,
                            color: Theme.of(context).colorScheme.primary,
                            size: 18,
                          ),
                          const Text('Flutter'),
                        ],
                      ),
                      const FooterVersion(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
          child: Text(
            "v${text.data ?? ''}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
