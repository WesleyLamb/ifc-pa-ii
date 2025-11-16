import 'package:app/constants/strings.dart';
import 'package:app/exceptions/http_response_exception.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/components/buttons/primary_button.dart';
import 'package:app/ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const routeName = '/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _password;
  late String _confirmPassword;
  late final AuthProvider _auth;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _auth = context.read<AuthProvider>();
  }

  Future<void> _handleRegister() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    formKey.currentState!.save();

    setState(() => _isLoading = true);

    try {
      await _auth.register(_name, _email, _passwordController.text, _confirmPasswordController.text);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cadastro realizado com sucesso! Faça login agora.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
      }
    } on HttpResponseException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Fechar',
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao registrar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    // Mínimo 8 caracteres
    return password.length >= 8;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Criar Conta',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF15237E),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                // Campo de Nome
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Nome completo'),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome é obrigatório';
                    }
                    if (value.length < 3) {
                      return 'Nome deve ter pelo menos 3 caracteres';
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value ?? '',
                ),

                const SizedBox(height: 20),

                // Campo de Email
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'E-mail é obrigatório';
                    }
                    if (!_isValidEmail(value)) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value ?? '',
                ),

                const SizedBox(height: 20),

                // Campo de Senha
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    label: const Text('Senha'),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    helperText:
                        'A senha deve ter no mínimo 8 caracteres.',
                    helperMaxLines: 2,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Senha é obrigatória';
                    }
                    if (!_isValidPassword(value)) {
                      return 'A senha deve ter no mínimo 8 caracteres';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value ?? '',
                ),

                const SizedBox(height: 20),

                // Campo de Confirmar Senha
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    label: const Text('Confirmar senha'),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirmação de senha é obrigatória';
                    }
                    if (value != _passwordController.text) {
                      return 'As senhas devem ser identicas';
                    }
                    return null;
                  },
                  onSaved: (value) => _confirmPassword = value ?? '',
                  // Validação adicional na submissão
                  onChanged: (value) {
                    // Força revalidação se o usuário mudar o campo
                    if (formKey.currentState != null) {
                      formKey.currentState!.validate();
                    }
                  },
                ),

                const SizedBox(height: 24),

                // Botão de Cadastro
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    text: _isLoading ? 'Cadastrando...' : 'Criar Conta',
                    onPressed: _isLoading ? null : _handleRegister,
                  ),
                ),

                const SizedBox(height: 16),

                // Link Voltar para Login
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Já tem conta? '),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed(LoginPage.routeName);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Fazer login',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
