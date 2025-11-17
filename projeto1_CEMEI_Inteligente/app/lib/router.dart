import 'package:app/ui/pages/initial_load_page.dart';
import 'package:app/ui/pages/login_page.dart';
import 'package:app/ui/pages/register_page.dart';
import 'package:app/ui/pages/home_page.dart';
import 'package:flutter/widgets.dart';

class AppRouter {
  const AppRouter();

  static Map<String, Widget Function(BuildContext)> routes = {
    InitialLoadPage.routeName: (_) => const InitialLoadPage(),
    LoginPage.routeName: (_) => const LoginPage(),
    RegisterPage.routeName: (_) => const RegisterPage(),
    HomePage.routeName: (_) => const HomePage(),
  };
}
