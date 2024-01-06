import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'grade_calculator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const Column(
        children: [
          Navbar(),
          Expanded(
            child: SingleChildScrollView(
              child: GradeCalculator(),
            ),
          ),
          Footer(),
        ],
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
    return Container(
      height: 80, //FIXME - Padding
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0),
            blurRadius: 6.0,
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
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 48,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('Made with '),
              Icon(
                Icons.favorite,
                color: Colors.amber,
                size: 18,
              ),
              Text(' Flutter'),
            ],
          ),
          FooterVersion(),
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
