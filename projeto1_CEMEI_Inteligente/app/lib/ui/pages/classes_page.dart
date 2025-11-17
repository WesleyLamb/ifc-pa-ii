import 'package:flutter/material.dart';
import 'package:app/models/class.dart';
import 'package:app/services/api_service.dart';
import 'kids_by_class_page.dart';
import 'package:app/ui/components/colors/app_colors.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  List<Class> _classes = [];
  List<Class> _filteredClasses = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadClasses();
  }

  Future<void> _loadClasses() async {
    setState(() => _isLoading = true);
    
    try {
      final classes = await ApiService.getAllClasses();
      setState(() {
        _classes = classes;
        _filteredClasses = classes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar turmas: $e'),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Tentar novamente',
              textColor: Colors.white,
              onPressed: _loadClasses,
            ),
          ),
        );
      }
    }
  }

  void _filterClasses(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredClasses = _classes;
      } else {
        _filteredClasses = _classes
            .where((cls) =>
                cls.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   title: const Text('Turmas'),
      //   backgroundColor: AppColors.primary,
      //   foregroundColor: AppColors.white,
      //   elevation: 0,
      // ),
      body: Column(
        children: [
          // Barra de pesquisa
          Container(
            color: AppColors.secondary,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              onChanged: _filterClasses,
              style: const TextStyle(color: AppColors.white),
              decoration: InputDecoration(
                hintText: 'Buscar turma...',
                hintStyle: TextStyle(color: AppColors.white.withOpacity(0.6)),
                prefixIcon: const Icon(Icons.search, color: AppColors.white),
                filled: true,
                fillColor: AppColors.searchBar,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),

          // Contador de resultados
          if (!_isLoading && _filteredClasses.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: AppColors.light.withOpacity(0.3),
              child: Text(
                '${_filteredClasses.length} ${_filteredClasses.length == 1 ? 'turma encontrada' : 'turmas encontradas'}',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.dark.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

          // Lista de turmas
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  )
                : _filteredClasses.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.class_outlined,
                              size: 64,
                              color: AppColors.light,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _searchQuery.isEmpty
                                  ? 'Nenhuma turma cadastrada'
                                  : 'Nenhuma turma encontrada',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.dark.withOpacity(0.6),
                              ),
                            ),
                            if (_searchQuery.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _searchQuery = '';
                                    _filteredClasses = _classes;
                                  });
                                },
                                icon: const Icon(Icons.clear),
                                label: const Text('Limpar busca'),
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        color: AppColors.primary,
                        onRefresh: _loadClasses,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _filteredClasses.length,
                          itemBuilder: (context, index) {
                            final turma = _filteredClasses[index];
                            return ClassCard(
                              classData: turma,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        KidsByClassPage(classData: turma),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navegar para tela de adicionar turma
        },
        backgroundColor: AppColors.accent,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}

class ClassCard extends StatelessWidget {
  final Class classData;
  final VoidCallback onTap;

  const ClassCard({
    Key? key,
    required this.classData,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.light.withOpacity(0.5)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Ícone da turma
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.accent.withOpacity(0.2),
                child: const Icon(
                  Icons.class_outlined,
                  color: AppColors.accent,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),

              // Informações da turma
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nome da turma
                    Text(
                      classData.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.dark,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Subtítulo
                    Row(
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 16,
                          color: AppColors.dark.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Ver alunos da turma',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.dark.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Ícone de seta
              const Icon(
                Icons.chevron_right,
                color: AppColors.light,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
