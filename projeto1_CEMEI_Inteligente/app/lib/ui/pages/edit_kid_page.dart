import 'package:app/models/class.dart';
import 'package:flutter/material.dart';
import 'package:app/models/kid.dart';
import 'package:app/services/api_service.dart';

class EditKidPage extends StatefulWidget {
  final String kidId;

  const EditKidPage({super.key, required this.kidId});

  static const routeName = '/edit-kid';

  @override
  State<EditKidPage> createState() => _EditKidPageState();
}

class _EditKidPageState extends State<EditKidPage> {
  late TextEditingController libraryIdentifierController;
  late TextEditingController nameController;
  late TextEditingController birthdayController;
  late TextEditingController fatherNameController;
  late TextEditingController motherNameController;
  late TextEditingController cpfController;

  bool _isLoading = false;
  String? _selectedTurn;
  String? _selectedClassId;
  List<Class> _classes = [];

  final List<String> _turns = ['Matutino', 'Vespertino', 'Integral'];

  @override
  void initState() {
    super.initState();
    // Inicializa todos os controllers vazios no início
    libraryIdentifierController = TextEditingController();
    nameController = TextEditingController();
    birthdayController = TextEditingController();
    fatherNameController = TextEditingController();
    motherNameController = TextEditingController();
    cpfController = TextEditingController();

    // Carrega dados e turmas
    _loadData();
  }

  /// Carrega criança e turmas em paralelo
  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      // Busca criança e turmas em paralelo
      final results = await Future.wait([
        ApiService.getKidById(widget.kidId),
        ApiService.getAllClasses(),
      ]);

      final kid = results[0] as Kid;
      final classes = results[1] as List<Class>;

      if (mounted) {
        // Preenche controllers com dados da criança
        libraryIdentifierController.text = kid.libraryIdentifier ?? '';
        nameController.text = kid.name ?? '';
        birthdayController.text = kid.birthday.toIso8601String().split('T')[0];
        fatherNameController.text = kid.fatherName ?? '';
        motherNameController.text = kid.motherName ?? '';
        cpfController.text = kid.cpf ?? '';
        _selectedTurn = kid.turn ?? 'Matutino';

        _selectedClassId = kid.cemeiClass?.id;

        // Preenche lista de turmas
        setState(() {
          _classes = classes;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('❌ Erro ao carregar dados: $e');
      if (mounted) {
        setState(() => _isLoading = false);
        _showError('Erro ao carregar dados: $e');
      }
    }
  }

  @override
  void dispose() {
    libraryIdentifierController.dispose();
    nameController.dispose();
    birthdayController.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();
    cpfController.dispose();
    super.dispose();
  }

  /// Valida o formulário
  bool _validateForm() {
    if (nameController.text.trim().isEmpty) {
      _showError('Nome é obrigatório');
      return false;
    }
    if (cpfController.text.trim().isEmpty) {
      _showError('CPF é obrigatório');
      return false;
    }
    if (birthdayController.text.trim().isEmpty) {
      _showError('Data de nascimento é obrigatória');
      return false;
    }
    return true;
  }

  /// Mostra erro em snackbar
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  /// Mostra sucesso em snackbar
  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  /// Salva as alterações
  Future<void> _saveChanges() async {
    if (!_validateForm()) return;

    setState(() => _isLoading = true);

    try {
      final updateData = {
        'library_identifier': libraryIdentifierController.text.trim(),
        'name': nameController.text.trim(),
        'birthday': birthdayController.text.trim(),
        'father_name': fatherNameController.text.trim(),
        'mother_name': motherNameController.text.trim(),
        'cpf': cpfController.text.trim(),
        'turn': _selectedTurn ?? 'Matutino',
        'class_id': _selectedClassId ?? '',
      };

      await ApiService.updateKid(widget.kidId, updateData);

      if (mounted) {
        _showSuccess('Criança atualizada com sucesso!');
        Navigator.pop(context, true);
      }
    } catch (e) {
      _showError('Erro ao salvar: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Abre seletor de data
  Future<void> _selectDate(TextEditingController controller) async {
    DateTime initialDate;
    try {
      initialDate = DateTime.parse(controller.text);
    } catch (_) {
      initialDate = DateTime.now();
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: const Locale('pt', 'BR'),
    );

    if (picked != null) {
      final String formattedDate =
          '${picked.year.toString().padLeft(4, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-'
          '${picked.day.toString().padLeft(2, '0')}';
      controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Editar Criança'),
        backgroundColor: const Color(0xFF15237E),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: _isLoading && _classes.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Seção: Informações Básicas
                    _buildSectionTitle('Informações Básicas'),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: libraryIdentifierController,
                      label: 'Matrícula',
                      icon: Icons.badge,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: nameController,
                      label: 'Nome',
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 12),
                    _buildDateField(
                      controller: birthdayController,
                      label: 'Data de Nascimento',
                      icon: Icons.cake,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: cpfController,
                      label: 'CPF',
                      icon: Icons.fingerprint,
                      maxLength: 11,
                    ),
                    const SizedBox(height: 24),

                    // Seção: Responsáveis
                    _buildSectionTitle('Responsáveis'),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: fatherNameController,
                      label: 'Nome do Pai',
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: motherNameController,
                      label: 'Nome da Mãe',
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 24),

                    // Seção: Informações Escolares
                    _buildSectionTitle('Informações Escolares'),
                    const SizedBox(height: 16),
                    _buildDropdownField(
                      label: 'Turno',
                      value: _selectedTurn,
                      items: _turns,
                      onChanged: (value) =>
                          setState(() => _selectedTurn = value),
                    ),
                    const SizedBox(height: 12),

                    // Dropdown de turmas
                    _buildClassDropdownField(
                      label: 'Turma',
                      value: _selectedClassId,
                      classes: _classes,
                      onChanged: (classId) =>
                          setState(() => _selectedClassId = classId),
                    ),

                    const SizedBox(height: 32),

                    // Botões de ação
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _isLoading
                                ? null
                                : () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(color: Color(0xFF15237E)),
                            ),
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(color: Color(0xFF15237E)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _saveChanges,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF15237E),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Salvar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
      ),
    );
  }

  /// Widget: Título de seção
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF15237E),
      ),
    );
  }

  /// Widget: Campo de texto
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int? maxLength,
  }) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF15237E), width: 2),
        ),
      ),
    );
  }

  /// Widget: Campo de data
  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDate(controller),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF15237E), width: 2),
        ),
      ),
      onTap: () => _selectDate(controller),
    );
  }

  /// Widget: Dropdown de turno
  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.wb_sunny_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF15237E), width: 2),
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }

  /// Widget: Dropdown de turmas
  Widget _buildClassDropdownField({
    required String label,
    required String? value,
    required List<Class> classes,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.school),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF15237E), width: 2),
        ),
      ),
      items: [
        const DropdownMenuItem(value: null, child: Text('Sem turma')),
        ...classes
            .map(
              (cls) => DropdownMenuItem(value: cls.id, child: Text(cls.name)),
            )
            .toList(),
      ],
      onChanged: onChanged,
    );
  }
}
