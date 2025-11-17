import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BaseScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  final int currentIndex;
  final Function(int) onTabChange;
  final bool showBackButton;

  const BaseScaffold({
    super.key,
    required this.title,
    required this.body,
    required this.currentIndex,
    required this.onTabChange,
    this.showBackButton = false,
  });

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  DateTime? _lastPressedTime;

  Future<bool> _onWillPop() async {
    final now = DateTime.now();

    if (_lastPressedTime == null ||
        now.difference(_lastPressedTime!) > const Duration(seconds: 2)) {
      // Primeiro pressionamento
      _lastPressedTime = now;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pressione novamente para sair'),
          duration: Duration(seconds: 2),
        ),
      );
      return false; // Não sai
    }
    // Segundo pressionamento dentro de 2 segundos
    return true; // Permite sair
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: const Color(0xFF15237E),
          foregroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: widget.showBackButton,
          leading: widget.showBackButton
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null,
        ),
        body: widget.body,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: SalomonBottomBar(
              currentIndex: widget.currentIndex,
              onTap: widget.onTabChange,
              items: [
                SalomonBottomBarItem(
                  icon: const Icon(Icons.search),
                  title: const Text('Buscar'),
                  selectedColor: const Color(0xFF0016A8),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.school),
                  title: const Text('Turmas'),
                  selectedColor: const Color(0xFF0016A8),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.child_care),
                  title: const Text('Alunos'),
                  selectedColor: const Color(0xFF0016A8),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.person),
                  title: const Text('Perfil'),
                  selectedColor: const Color(0xFF0016A8),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
