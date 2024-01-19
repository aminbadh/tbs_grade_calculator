import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer(
    this.msg, {
    super.key,
  });

  final String msg;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.primary.withOpacity(0.05),
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
                Text(' $msg'),
              ],
            ),
            const FooterVersion(),
          ],
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
