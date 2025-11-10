import 'package:app/constants/strings.dart';
import 'package:app/exceptions/http_response_exception.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/components/buttons/primary_button.dart';
import 'package:app/ui/components/form_fields/password_input_form_field.dart';
import 'package:app/ui/components/form_fields/text_input_form_field.dart';
import 'package:app/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/utils/storage.dart' as Storage;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/login';

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  late final AuthProvider _auth;

  @override
  void initState() {
    super.initState();
    _auth = context.read();

    Storage.get(AppStrings.emailStorageKey).then(
      (value) => {
        setState(() {
          _email = value ?? '';
        }),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextInputFormField(
                label: "E-mail",
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              PasswordInputFormField(
                onChanged: (value) => {
                  setState(() {
                    _password = value;
                  }),
                },
              ),
              PrimaryButton(
                text: 'Entrar',
                onPressed: () {
                  _auth
                      .token(_email, _password)
                      .then(
                        (response) => {
                          Navigator.pushNamed(context, HomePage.routeName),
                        },
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
