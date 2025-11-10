import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BaseScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final int currentIndex;
  final Function(int) onTabChange;

  const BaseScaffold({
    super.key,
    required this.title,
    required this.body,
    required this.currentIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF15237E),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: body,
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
            currentIndex: currentIndex,
            onTap: onTabChange,
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text('Início'),
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
    );
  }
}
