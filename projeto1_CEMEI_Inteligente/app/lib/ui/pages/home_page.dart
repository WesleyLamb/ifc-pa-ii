import 'package:flutter/material.dart';
import 'package:app/ui/components/base_pages/base_scaffold.dart';
import 'package:app/services/api_service.dart';
import 'package:app/ui/pages/classes_page.dart';
import 'package:app/ui/pages/kid_list_page.dart';
import 'package:app/ui/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  //  @override
  // void initState() {
  //   super.initState();
    
  //   // ⬇️ TEMPORÁRIO: Forçar token de teste ⬇️
  //   // REMOVA DEPOIS QUE O LOGIN ESTIVER FUNCIONANDO
  //   ApiService.setAccessToken('eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJhMDUxYWY3Yi04MzZiLTRlYjUtODUyZS1lZGExZTJkOWFiNTciLCJqdGkiOiI5M2M0MjY1YWFiNjVlNGY3ZTgwYzg5NjNkZTkyZTc5M2RiZDkyNDY2MWRhMmJlNDE3MjkwZTZhZjhkNmY0ZjgwNGQzZjQ5ZTczMjA4M2Y5ZCIsImlhdCI6MTc2Mjc3MzAxMS4wNTQwMjEsIm5iZiI6MTc2Mjc3MzAxMS4wNTQwMjMsImV4cCI6MTc5NDMwOTAxMS4wMzI2MzMsInN1YiI6IjEiLCJzY29wZXMiOlsiKiJdfQ.iVGL4l4d3L7tj7A4eYkzlrz2RINhVDYeKgt2D1sQ-Sb_a3aTeWeEA2QmJSYM9awUFIN9spnKohysHvnkOok_gRzdJh1A7ckmGArxlfrJWZ4F3qSeTFJnY-1Z5pqUyhYieNJ1N6glfvdgR0LVlI7clyYDNJIXs05Qo0GyZSLwl6eIODLXd2BLFoiNatbhP-k2GkhjMF6uDtfj9UhFjjk_t3cM-WUfmJ7edH9s3AtwhIQ-MrYscGRouwIkK41mqtaPsmLnd6-eLY2__BUat6m2frD97stCTvMpEkupmz6LpQTaPIjiWCGmx6E10lL36cZfIvjHRKrH-Cnaklu5JhSSaeXcosTotEBuA92zq6rq473dheKUBGAcyFfMw1R4FreCZfISOgb5woZ6keldzdWKJIlbLL8I55Whb1NNQB2MB48N706dPiY7s_U7z3lMof_oxmxothMfaRQ7QdJjnBnLCg-tnCmUpv55Z695sYCfxWD35Jvmr9Tmzj2j6ULudqG2rYeQGKWz-M3-u5m5kP_q7tP_-CLWIAVpB2YW4svXMU72ViVYu6z0mASXJzM1E08llnEhgGZAG3sY-CaGObF8XRbRp91RziGpz-DnnRpLNympr1z_NuvKtBesqQGRCfuKSnJWNXvmndDLwfA_YqB2RjWzkrJESCw5cgBn38QDdG0');
  // }

  final List<Widget> _pages = [
    const InicioTab(),
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

class InicioTab extends StatelessWidget {
  const InicioTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text('Tela de Início', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
        ],
      ),
    );
  }
}