import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfApi {
  static Future<File> generatePDF({
    ByteData imageSignature,
  }) async {
    final document = PdfDocument();
    final page = document.pages.add();
    drawSignature(page, imageSignature);
    return saveFile(document);
  }

  static void drawSignature(PdfPage page, ByteData imageSignature) {
    final pageSize = page.getClientSize();
    final PdfBitmap image = PdfBitmap(imageSignature.buffer.asUint8List());
    PdfBrush solidBrush = PdfSolidBrush(PdfColor(126, 151, 173));

    page.graphics.drawRectangle(
        brush: solidBrush, bounds: Rect.fromLTWH(0, 0, pageSize.width, 60));
    page.graphics.drawString(
        "Power Of Attorney", PdfStandardFont(PdfFontFamily.helvetica, 30),
        bounds: Rect.fromLTWH(10, 10, 0, 0));

    page.graphics.drawString(
        "Signature of User", PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(
            0, pageSize.height - 30 - (pageSize.height / 2), 0, 0));
    page.graphics.drawImage(
        image,
        Rect.fromLTWH(0, pageSize.height - (pageSize.height / 2),
            pageSize.width, pageSize.height / 2));
  }

  static Future<File> saveFile(PdfDocument document) async {
    final path = await getApplicationDocumentsDirectory();
    final fileName =
        path.path + '/PowerOfAttorney${DateTime.now().toIso8601String()}.pdf';
    final file = File(fileName);
    file.writeAsBytes(document.save());
    document.dispose();
    return file;
  }
}
