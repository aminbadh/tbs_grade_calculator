import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'components/footer.dart';
import 'components/navbar.dart';
import 'doc_state.dart';
import 'screens/calculator_screen.dart';
import 'screens/not_found_screen.dart';
import 'screens/saves_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  Widget _body(String? r) => switch (r) {
        '/' => ChangeNotifierProvider(
            create: (context) => DocState(),
            child: const CalculatorScreen(),
          ),
        '/saves' => const SavesScreen(),
        _ => const NotFoundScreen(),
      };

  Route<dynamic>? _onGenerateRoute(RouteSettings s) => MaterialPageRoute(
        builder: (context) => SafeArea(
          child: Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Navbar(),
            ),
            body: _body(s.name),
            bottomNavigationBar: const Footer(),
          ),
        ),
        settings: s,
        maintainState: true,
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TBS Grade Calculator',
      onGenerateRoute: _onGenerateRoute,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
    );
  }
}
