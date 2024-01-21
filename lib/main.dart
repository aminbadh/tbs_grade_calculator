import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tbs_grade_calculator/firebase_options.dart';

import 'components/footer.dart';
import 'components/navbar.dart';
import 'notifiers/document_state.dart';
import 'models/document.dart';
import 'screens/account_screen.dart';
import 'screens/calculator_screen.dart';
import 'screens/not_found_screen.dart';
import 'screens/saves_screen.dart';
import 'utils.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  Widget _calculator([Document? doc]) => ChangeNotifierProvider(
        create: (context) => DocumentState(doc),
        child: const CalculatorScreen(),
      );

  Future<Widget> _identify(String id) async {
    if (usedKeys.contains(id)) return const NotFoundScreen();
    final document = (await SharedPreferences.getInstance()).getString(id);

    if (document == null) {
      return const NotFoundScreen();
    } else {
      return _calculator(Document.fromJson(jsonDecode(document)));
    }
  }

  Widget _body(String r) => switch (r) {
        '/' => _calculator(),
        '/saves' => const SavesScreen(),
        '/account' => const AccountScreen(),
        _ => FutureBuilder(
            future: _identify(r.substring(1)),
            builder: (_, s) => s.data ?? emptyWidget),
      };

  Route<dynamic>? _onGenerateRoute(RouteSettings s, _) => MaterialPageRoute(
        builder: (context) => SafeArea(
          child: Scaffold(
            backgroundColor: scaffoldBackgroundColor(context),
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Navbar(),
            ),
            body: s.name == null ? const NotFoundScreen() : _body(s.name!),
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
