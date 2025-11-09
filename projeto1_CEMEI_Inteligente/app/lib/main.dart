import 'package:app/constants/strings.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/pages/initial_load_page.dart';
import 'package:app/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> _providers = [Provider(create: (_) => AuthProvider())];

void main() async {
  runApp(MultiProvider(providers: _providers, child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff0016A8),
          onPrimary: Colors.white,
          secondary: Color(0xff0016A8),
          onSecondary: Colors.white,
          error: Color(0xff1A1D33),
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Color(0xff1A1D33),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      initialRoute: InitialLoadPage.routeName,
      routes: AppRouter.routes,
    );
  }
}
