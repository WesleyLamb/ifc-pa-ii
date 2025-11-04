import 'package:app/components/buttons/primary_button.dart';
import 'package:app/components/buttons/secondary_button.dart';
import 'package:app/components/subtitle_text.dart';
import 'package:app/components/title_text.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/signin_page.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              const Image(
                image: AssetImage('assets/img/logo-ifc-vertical.png'),
                width: 150,
                height: 150,
              ),
              SizedBox(height: 50),
              TitleText(text: 'CEMEI Inteligente'),
              SizedBox(height: 25),
              SubtitleText(text: 'Entre ou cadastre-se para continuar'),
              SizedBox(height: 50),
              SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PrimaryButton(
                      text: 'Entrar',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                    ),
                    SecondaryButton(
                      text: 'Cadastrar',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SigninPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
