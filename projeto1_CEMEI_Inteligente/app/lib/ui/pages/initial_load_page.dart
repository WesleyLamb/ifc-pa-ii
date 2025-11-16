import 'package:app/ui/pages/dashboard_page.dart';
import 'package:app/ui/pages/home_page.dart';
import 'package:app/ui/pages/initial_page.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/ui/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitialLoadPage extends StatefulWidget {
  const InitialLoadPage({super.key});

  @override
  State<StatefulWidget> createState() => _InitialLoadPageState();

  static const routeName = '/loading';
}

class _InitialLoadPageState extends State<InitialLoadPage> {
  @override
  void initState() {
    super.initState();

    _resolveAuthenticatedUser();
  }

  Future<void> _resolveAuthenticatedUser() async {
    try {
      final user = await context.read<AuthProvider>().tryGetAuthUser();
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) =>
              user == null ? const InitialPage() : const HomePage(),
          transitionDuration: Duration.zero,
        ),
      );
    } catch (e) {
      await Navigator.of(
        context,
        rootNavigator: true,
      ).pushReplacementNamed(InitialPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContainerWithSpinner();
  }
}
