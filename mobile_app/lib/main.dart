import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyGreenWorldApp());
}

class MyGreenWorldApp extends StatelessWidget {
  const MyGreenWorldApp({super.key});

  @override
  Widget build(BuildContext context) {
    const forest = Color(0xFF174B38);
    const leaf = Color(0xFF2F8B57);

    return MaterialApp(
      title: 'عالمي الأخضر',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: leaf,
          primary: forest,
          secondary: leaf,
          surface: const Color(0xFFF7FAF6),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7FAF6),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7FAF6),
          foregroundColor: forest,
          centerTitle: false,
          elevation: 0,
        ),
      ),
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: HomeScreen(),
      ),
    );
  }
}
