import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'presentation/pages/login_page.dart';
import 'presentation/blocs/provider.dart';

void main() {
  /// ensured Flutter initialized everything before start
  WidgetsFlutterBinding.ensureInitialized();

  /// set device mode to portrait only (not support landscape)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Form Validation App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: TextTheme(
            displayMedium: GoogleFonts.notoSans(),
            bodyMedium: GoogleFonts.notoSans(
              fontSize: 18.0,
            ),
          ),
        ),
        home: const LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
