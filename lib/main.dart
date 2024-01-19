import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/footer.dart';
import 'components/navbar.dart';
import 'doc_state.dart';
import 'models/document.dart';
import 'screens/calculator_screen.dart';
import 'screens/not_found_screen.dart';
import 'screens/saves_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  Widget _calculator([Document? doc]) => ChangeNotifierProvider(
        create: (context) => DocState(doc),
        child: const CalculatorScreen(),
      );

  Future<Widget> _identify(String? id) async {
    if (id == null) return const NotFoundScreen();

    final sp = await SharedPreferences.getInstance();
    final documents = sp.getStringList(documentsKey);

    if (documents == null) return const NotFoundScreen();

    if (documents.contains(id.substring(1))) {
      final document = sp.getString(id.substring(1));
      if (document != null) {
        return _calculator(Document.fromJson(jsonDecode(document)));
      }
    }

    return const NotFoundScreen();
  }

  Widget _body(String? r) => switch (r) {
        '/' => _calculator(),
        '/saves' => const SavesScreen(),
        _ => FutureBuilder(
            future: _identify(r),
            builder: (_, snapshot) => snapshot.data ?? const SizedBox(),
          ),
      };

  Route<dynamic>? _onGenerateRoute(RouteSettings s, _) => MaterialPageRoute(
        builder: (context) => SafeArea(
          child: Scaffold(
            backgroundColor: scaffoldBackgroundColor(context),
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Navbar(),
            ),
            body: _body(s.name),
            bottomNavigationBar: Footer(_),
          ),
        ),
        settings: s,
      );

  @override
  Widget build(BuildContext context) {
    final msg = getFooterMessage();
    return MaterialApp(
      title: 'TBS Grade Calculator',
      onGenerateRoute: (s) => _onGenerateRoute(s, msg),
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
    );
  }
}

Color scaffoldBackgroundColor(context) => Color.alphaBlend(
      Theme.of(context).colorScheme.onBackground.withOpacity(0.015),
      Theme.of(context).colorScheme.background,
    );
