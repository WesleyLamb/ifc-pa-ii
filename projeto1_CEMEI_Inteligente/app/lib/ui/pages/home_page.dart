import 'package:flutter/material.dart';
import 'package:app/ui/components/base_pages/base_scaffold.dart';
import 'package:app/services/api_service.dart';
import 'package:app/ui/pages/classes_page.dart';
import 'package:app/ui/pages/kid_list_page.dart';
import 'package:app/ui/pages/profile_page.dart';
import 'package:app/ui/pages/barcode_scan_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const BarcodeScanPage(),
    const ClassesPage(),
    const KidsListPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'CEMEI Inteligente',
      currentIndex: _selectedIndex,
      onTabChange: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      body: _pages[_selectedIndex],
    );
  }
}