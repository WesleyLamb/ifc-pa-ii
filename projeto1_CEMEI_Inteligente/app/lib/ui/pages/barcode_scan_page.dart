import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/auth_provider.dart';

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

  final TextEditingController manualInputController = TextEditingController();
  final List<Map<String, dynamic>> scanHistory = [];
  bool _isProcessing = false;
  bool _keyboardOpen = false;
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
    manualInputController.dispose();
    super.dispose();
  }

  /// Processa o library_identifier lido
  Future<void> _processLibraryIdentifier(String libraryId) async {
    if (libraryId.trim().isEmpty || _isProcessing) return;

    if (_lastScannedCode == libraryId.trim()) return;
    _lastScannedCode = libraryId.trim();

    developer.log(
      'Library Identifier lido: $libraryId',
      name: 'BarcodeScan',
      level: 800,
    );

    setState(() => _isProcessing = true);

    try {
      final timestamp = DateTime.now();
      final newScan = {
        'libraryId': libraryId.trim(),
        'timestamp': timestamp,
        'kidName': 'Criança #${libraryId.trim()}',
        'className': 'Turma A',
        'status': 'Chegada',
      };

      setState(() {
        scanHistory.insert(0, newScan);
        manualInputController.clear();
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Criança #$libraryId - Chegada registrada!'),
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
        'Erro ao processar library_identifier: $e',
        name: 'BarcodeScan',
        level: 1000,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
        setState(() {
          _lastScannedCode = null;
          _isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Detecta se teclado está aberto
    _keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Chegada e Saída',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF15237E),
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
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

              const SizedBox(height: 40),

              // Câmera - só mostra se teclado não está aberto
              if (!_keyboardOpen)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    height: 300,
                    child: _buildCameraView(),
                  ),
                ),

              if (!_keyboardOpen) const SizedBox(height: 16),

              // Campo de entrada manual
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildManualInputField(),
              ),

              const SizedBox(height: 16),

              // Histórico de leituras
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildScanHistoryHeader(),
                      const SizedBox(height: 8),
                      Expanded(child: _buildScanHistoryList()),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget da câmera
  Widget _buildCameraView() {
    return Container(
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
                    const SizedBox(height: 16),
                    Text(
                      'Erro ao acessar câmera',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
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
          // Overlay com linha de scan
          Positioned.fill(
            child: CustomPaint(
              painter: ScannerOverlayPainter(),
            ),
          ),
        ],
      ),
    );
  }

  /// Campo de entrada manual
  Widget _buildManualInputField() {
    return TextField(
      controller: manualInputController,
      keyboardType: TextInputType.number,
      enabled: !_isProcessing,
      decoration: InputDecoration(
        labelText: 'Ou digite o código',
        prefixIcon: const Icon(Icons.keyboard),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: 'Código da biblioteca',
      ),
      onSubmitted: (value) {
        if (value.isNotEmpty && !_isProcessing) {
          _processLibraryIdentifier(value);
        }
      },
    );
  }

  /// Header do histórico
  Widget _buildScanHistoryHeader() {
    return Text(
      'Histórico de Leituras',
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
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
            fontSize: 12,
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

  Widget _buildScanChip(Map<String, dynamic> scan, int order) {
    final timestamp = scan['timestamp'] as DateTime;
    final formattedTime =
        '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';

    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '#$order - ${scan['kidName']}',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.green,
            ),
          ),
          Text(
            formattedTime,
            style: TextStyle(
              fontSize: 9,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

/// Painter customizado para overlay de scanner
class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double scanLineWidth = 2.0;
    const double cornerSize = 50.0;
    const double margin = 40.0;

    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = scanLineWidth
      ..style = PaintingStyle.stroke;

    final cornerPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Posição do quadrado de scan
    final left = margin;
    final top = (size.height - (size.width - 2 * margin)) / 2;
    final right = size.width - margin;
    final bottom = top + (size.width - 2 * margin);

    // Desenha cantos
    canvas.drawLine(Offset(left, top + cornerSize), Offset(left, top),
        cornerPaint);
    canvas.drawLine(Offset(left, top), Offset(left + cornerSize, top),
        cornerPaint);

    canvas.drawLine(Offset(right - cornerSize, top), Offset(right, top),
        cornerPaint);
    canvas.drawLine(Offset(right, top), Offset(right, top + cornerSize),
        cornerPaint);

    canvas.drawLine(
        Offset(left, bottom - cornerSize), Offset(left, bottom), cornerPaint);
    canvas.drawLine(Offset(left, bottom), Offset(left + cornerSize, bottom),
        cornerPaint);

    canvas.drawLine(
        Offset(right - cornerSize, bottom), Offset(right, bottom), cornerPaint);
    canvas.drawLine(Offset(right, bottom - cornerSize), Offset(right, bottom),
        cornerPaint);

    final scanLineY = top + (bottom - top) / 2;
    canvas.drawLine(Offset(left + 20, scanLineY), Offset(right - 20, scanLineY),
        paint);
  }

  @override
  bool shouldRepaint(ScannerOverlayPainter oldDelegate) => false;
}
