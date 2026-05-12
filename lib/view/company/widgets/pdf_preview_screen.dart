import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class PdfPreviewScreen extends StatelessWidget {
  final Uint8List pdfBytes;
  final String fileName;

  const PdfPreviewScreen({
    super.key,
    required this.pdfBytes,
    required this.fileName,
  });

  Future<void> _sharePdf() async {
    final dir = await getTemporaryDirectory();

    final file = File("${dir.path}/$fileName");

    await file.writeAsBytes(pdfBytes);

    await Share.shareXFiles(
      [XFile(file.path)],
      text: "Site Financial Report",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Preview"),
        actions: [
          IconButton(
            onPressed: _sharePdf,
            icon: const Icon(Icons.share),
          ),
        ],
      ),

      body: PdfPreview(
        build: (format) async => pdfBytes,
        allowPrinting: true,
        allowSharing: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
      ),
    );
  }
}