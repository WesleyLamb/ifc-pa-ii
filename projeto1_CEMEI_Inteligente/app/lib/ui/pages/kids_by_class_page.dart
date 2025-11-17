import 'package:app/models/kid_summary.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/components/colors/app_colors.dart';
import 'package:app/models/class.dart';
import 'package:app/models/kid.dart';
import 'package:app/services/api_service.dart';
import 'package:app/ui/components/cards/kid_card.dart';

class KidsByClassPage extends StatefulWidget {
  final Class classData;

  const KidsByClassPage({super.key, required this.classData});

  @override
  State<KidsByClassPage> createState() => _KidsByClassPageState();
}

class _KidsByClassPageState extends State<KidsByClassPage> {
  List<KidSummary> _kids = [];
  List<KidSummary> _filteredKids = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadKids();
  }

  Future<void> _loadKids() async {
    setState(() => _isLoading = true);

    try {
      final kids = await ApiService.getKidsByClass(widget.classData.id);
      setState(() {
        _kids = kids;
        _filteredKids = kids;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar alunos: $e'),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Tentar novamente',
              textColor: Colors.white,
              onPressed: _loadKids,
            ),
          ),
        );
      }
    }
  }

  void _filterKids(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredKids = _kids;
      } else {
        _filteredKids = _kids
            .where(
              (kid) =>
                  kid.name.toLowerCase().contains(query.toLowerCase()) ||
                  kid.libraryIdentifier.contains(query),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(widget.classData.name),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Barra de pesquisa
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              onChanged: _filterKids,
              style: const TextStyle(color: AppColors.white),
              decoration: InputDecoration(
                hintText: 'Buscar aluno na turma...',
                hintStyle: TextStyle(color: AppColors.white.withOpacity(0.6)),
                prefixIcon: const Icon(Icons.search, color: AppColors.white),
                filled: true,
                fillColor: AppColors.secondary,
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
          if (!_isLoading && _filteredKids.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: AppColors.light.withOpacity(0.3),
              child: Text(
                '${_filteredKids.length} ${_filteredKids.length == 1 ? 'aluno encontrado' : 'alunos encontrados'}',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.dark.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

          // Lista de alunos
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : _filteredKids.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.child_care_outlined,
                          size: 64,
                          color: AppColors.light,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchQuery.isEmpty
                              ? 'Nenhum aluno nesta turma'
                              : 'Nenhum aluno encontrado',
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
                                _filteredKids = _kids;
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
                    onRefresh: _loadKids,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _filteredKids.length,
                      itemBuilder: (context, index) {
                        final kid = _filteredKids[index];
                        return KidCard(kid: kid);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
