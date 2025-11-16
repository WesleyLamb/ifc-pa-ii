import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/models/kid.dart';
import 'package:app/services/api_service.dart';

class BarcodeScanPage extends StatefulWidget {
  const BarcodeScanPage({super.key});

  static const routeName = '/barcode-scan';

  @override
  State<BarcodeScanPage> createState() => _BarcodeScanPageState();
}

class _BarcodeScanPageState extends State<BarcodeScanPage> {
  final MobileScannerController cameraController = MobileScannerController(
    detectionTimeoutMs: 500,
    formats: [BarcodeFormat.code128, BarcodeFormat.ean13, BarcodeFormat.code39],
    returnImage: false,
  );

  final TextEditingController searchController = TextEditingController();
  final List<Map<String, dynamic>> scanHistory = [];

  List<Kid> searchResults = [];
  bool _isProcessing = false;
  bool _keyboardOpen = false;
  bool _isSearching = false;
  String? _lastScannedCode;

  late final AuthProvider _auth;

  @override
  void initState() {
    super.initState();
    _auth = context.read<AuthProvider>();
  }

  @override
  void dispose() {
    cameraController.dispose();
    searchController.dispose();
    super.dispose();
  }

  /// Busca crianças por query (nome, CPF, library_identifier)
  Future<void> _searchKids(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final results = await ApiService.searchKids(query.trim());
      setState(() {
        searchResults = results;
      });
      developer.log('Busca encontrou ${results.length} crianças: $query',
          name: 'BarcodeScan');
    } catch (e) {
      developer.log('Erro ao buscar crianças: $e', name: 'BarcodeScan', level: 1000);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao buscar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSearching = false;
        });
      }
    }
  }

  /// Processa a chegada/saída de uma criança
  Future<void> _processKidArrival(Kid kid) async {
    if (_isProcessing) return;

    developer.log(
      'Processando chegada: ${kid.name} (${kid.libraryIdentifier})',
      name: 'BarcodeScan',
      level: 800,
    );

    setState(() => _isProcessing = true);

    try {
      final timestamp = DateTime.now();
      final newScan = {
        'kidId': kid.id,
        'libraryId': kid.libraryIdentifier,
        'kidName': kid.name,
        'timestamp': timestamp,
        'className': kid.classes.isNotEmpty ? kid.classes[0] : 'Turma A',
        'status': 'Chegada',
      };

      setState(() {
        scanHistory.insert(0, newScan);
        searchController.clear();
        searchResults = [];
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${kid.name} - Chegada registrada!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }

      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() {
          _lastScannedCode = null;
          _isProcessing = false;
        });
      }
    } catch (e) {
      developer.log(
        'Erro ao processar chegada: $e',
        name: 'BarcodeScan',
        level: 1000,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro: $e'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  /// Processa o código de barras (library_identifier)
  Future<void> _processLibraryIdentifier(String libraryId) async {
    if (libraryId.trim().isEmpty || _isProcessing) return;

    if (_lastScannedCode == libraryId.trim()) return;
    _lastScannedCode = libraryId.trim();

    developer.log(
      'Library Identifier lido: $libraryId',
      name: 'BarcodeScan',
      level: 800,
    );

    // Busca a criança pelo library_identifier
    await _searchKids(libraryId.trim());
  }

  @override
  Widget build(BuildContext context) {
    _keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Registro de Chegada e Saída'),
        backgroundColor: const Color(0xFF15237E),
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          if (!_keyboardOpen)
            IconButton(
              icon: const Icon(Icons.flash_on),
              onPressed: () => cameraController.toggleTorch(),
              tooltip: 'Flash',
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(), 
              ),
              const SizedBox(height: 24),

              // Câmera
              if (!_keyboardOpen) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Leitor de Código de Barras',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF15237E),
                            ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 200,
                        child: _buildCameraView(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Busca por nome
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Buscar Criança',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF15237E),
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildSearchField(),
                    const SizedBox(height: 12),
                    _buildSearchResults(),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Histórico
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Histórico de Leituras',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF15237E),
                          ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 100,
                      child: _buildScanHistoryList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  /// Câmera com overlay
  Widget _buildCameraView() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF15237E), width: 2),
      ),
      child: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null && !_isProcessing) {
                  developer.log('Barcode detectado: ${barcode.rawValue}',
                      name: 'BarcodeScan');
                  _processLibraryIdentifier(barcode.rawValue!);
                }
              }
            },
            errorBuilder: (context, error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.camera_alt_outlined,
                        size: 48, color: Colors.grey),
                    const SizedBox(height: 12),
                    Text(
                      'Erro ao acessar câmera',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Verifique as permissões',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: BarcodeOverlayPainter(),
            ),
          ),
        ],
      ),
    );
  }

  /// Campo de busca
  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      keyboardType: TextInputType.text,
      enabled: !_isProcessing,
      decoration: InputDecoration(
        labelText: 'Pesquise por nome ou CPF',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _isSearching
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.grey[600]!),
                  ),
                ),
              )
            : searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      setState(() {
                        searchResults = [];
                      });
                    },
                  )
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onChanged: (value) {
        setState(() {});
        if (value.isNotEmpty) {
          _searchKids(value);
        } else {
          setState(() {
            searchResults = [];
          });
        }
      },
    );
  }

  /// Resultados da busca
  Widget _buildSearchResults() {
    if (searchResults.isEmpty && searchController.text.isEmpty) {
      return const SizedBox.shrink();
    }

    if (searchController.text.isNotEmpty && searchResults.isEmpty && !_isSearching) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          'Nenhuma criança encontrada',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 13,
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: searchResults.length,
        separatorBuilder: (context, index) =>
            Divider(height: 0, color: Colors.grey[300]),
        itemBuilder: (context, index) {
          final kid = searchResults[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF15237E).withOpacity(0.2),
              child: Icon(
                Icons.person,
                color: const Color(0xFF15237E),
              ),
            ),
            title: Text(
              kid.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'CPF: ${kid.cpf}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            onTap: () => _processKidArrival(kid),
          );
        },
      ),
    );
  }

  /// Lista do histórico
  Widget _buildScanHistoryList() {
    if (scanHistory.isEmpty) {
      return Center(
        child: Text(
          'Nenhuma leitura realizada',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 13,
          ),
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: scanHistory.length,
      itemBuilder: (context, index) {
        final scan = scanHistory[index];
        return _buildScanChip(scan, index + 1);
      },
    );
  }

  /// Chip do histórico
  Widget _buildScanChip(Map<String, dynamic> scan, int order) {
    final timestamp = scan['timestamp'] as DateTime;
    final formattedTime =
        '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';

    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green, width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '#$order',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.green,
            ),
          ),
          Text(
            formattedTime,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Overlay para código de barras
class BarcodeOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double lineWidth = 2.5;
    const double cornerLength = 40.0;
    const double verticalMargin = 30.0;
    const double horizontalMargin = 20.0;

    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;

    final scanLinePaint = Paint()
      ..color = Colors.green.withOpacity(0.6)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final left = horizontalMargin;
    final top = verticalMargin;
    final right = size.width - horizontalMargin;
    final bottom = size.height - verticalMargin;

    // Cantos
    canvas.drawLine(Offset(left, top + cornerLength), Offset(left, top), paint);
    canvas.drawLine(Offset(left, top), Offset(left + cornerLength, top), paint);

    canvas.drawLine(Offset(right - cornerLength, top), Offset(right, top), paint);
    canvas.drawLine(Offset(right, top), Offset(right, top + cornerLength), paint);

    canvas.drawLine(
        Offset(left, bottom - cornerLength), Offset(left, bottom), paint);
    canvas.drawLine(
        Offset(left, bottom), Offset(left + cornerLength, bottom), paint);

    canvas.drawLine(
        Offset(right - cornerLength, bottom), Offset(right, bottom), paint);
    canvas.drawLine(
        Offset(right, bottom - cornerLength), Offset(right, bottom), paint);

    final scanY = top + (bottom - top) / 2;
    canvas.drawLine(
      Offset(left + 15, scanY),
      Offset(right - 15, scanY),
      scanLinePaint,
    );
  }

  @override
  bool shouldRepaint(BarcodeOverlayPainter oldDelegate) => false;
}
