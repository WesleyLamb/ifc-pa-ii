import 'package:app/ui/pages/login_page.dart';
import 'package:app/ui/pages/register_page.dart';
import 'package:app/ui/components/buttons/primary_button.dart';
import 'package:app/ui/components/buttons/secondary_button.dart';
import 'package:app/ui/components/texts/title_text.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});
  static const routeName = '/';

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  static const String _appVersion = '1.0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // Espaço superior
              const SizedBox(height: 40),

              // Logo e Título - Expandido com Spacer
              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('assets/img/logo-ifc-vertical.png'),
                        width: 150,
                        height: 150,
                      ),
                      // const SizedBox(height: 40),
                      const TitleText(text: 'CEMEI Inteligente'),
                    ],
                  ),
                ),
              ),

              // Botões de Ação - Largura controlada
              Column(
                children: [
                  // Botão de Login
                  SizedBox(
                    width: 280,
                    height: 50,
                    child: PrimaryButton(
                      text: 'Fazer Login',
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginPage.routeName);
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Botão de Cadastro
                  SizedBox(
                    width: 280,
                    height: 50,
                    child: SecondaryButton(
                      label: 'Criar Conta',
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RegisterPage.routeName);
                      },
                    ),
                  ),
                ],
              ),

              // Espaço antes da versão
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      // Versão do App - Rodapé
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'v$_appVersion',
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}