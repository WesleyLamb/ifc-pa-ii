import 'package:app/ui/components/buttons/primary_button.dart';
import 'package:app/ui/components/buttons/secondary_button.dart';
import 'package:app/ui/components/texts/subtitle_text.dart';
import 'package:app/ui/components/texts/title_text.dart';
import 'package:app/ui/pages/login_page.dart';
import 'package:app/ui/pages/register_page.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  static const routeName = '/';

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    super.initState();
  }

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
              // SubtitleText(text: 'Entre ou cadastre-se para continuar'),
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
                      label: 'Cadastrar',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
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
