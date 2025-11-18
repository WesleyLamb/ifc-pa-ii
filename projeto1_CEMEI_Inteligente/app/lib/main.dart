import 'package:app/constants/strings.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/pages/initial_load_page.dart';
import 'package:app/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

List<SingleChildWidget> _providers = [
  ChangeNotifierProvider(create: (_) => AuthProvider()..init()),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('pt_BR').then((value) {
    initializeDateFormatting('en_US').then((value) {
      Intl.defaultLocale = 'pt_BR';
      runApp(MultiProvider(providers: _providers, child: const MainApp()));
    });
  });
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
