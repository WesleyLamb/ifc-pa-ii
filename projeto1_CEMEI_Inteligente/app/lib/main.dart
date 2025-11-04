// import 'package:app/login_page.dart';
// import 'package:app/repositories/authentication_repository.dart';
import 'package:app/pages/initial_page.dart';
import 'package:flutter/material.dart';

void main() async {
  // final authRepository = AuthenticationRepository();
  // final auth = await authRepository.auth(
  //   email: 'wesley.lamb@castorsoft.com.br',
  //   password: 'yametekudasai',
  // );

  runApp(const MainApp());
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
      home: const InitialPage(),
    );
  }
}
