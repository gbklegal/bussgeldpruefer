import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfApi {
  static Future<File> generatePDF({
    String myName,
    String orderNumber,
    ByteData imageSignature,
  }) async {
    final document = PdfDocument();
    final page = document.pages.add();
    drawSignature(page, myName, orderNumber, imageSignature);
    return saveFile(document);
  }

  static void drawSignature(PdfPage page, String myName, String orderNumber,
      ByteData imageSignature) async {
    final pageSize = page.getClientSize();
    final PdfBitmap image = PdfBitmap(imageSignature.buffer.asUint8List());
    DateTime now = new DateTime.now();
    var formatter = new DateFormat('dd.MM.yyyy');
    String formattedDate = formatter.format(now);
    //DateTime date = new DateTime(now.year, now.month, now.day);

    // page.graphics.drawRectangle(
    //     brush: solidBrush, bounds: Rect.fromLTWH(0, 0, pageSize.width, 60));
    // page.graphics.drawString(
    //     "Power Of Attorney", PdfStandardFont(PdfFontFamily.helvetica, 30),
    //     bounds: Rect.fromLTWH(10, 10, 0, 0));
    print(myName);
    page.graphics.drawImage(PdfBitmap(await _readImageData('vollmacht.jpg')),
        Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));
    page.graphics.drawString(
        myName, PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: Rect.fromLTWH(60, (pageSize.height / 4) - 10, 0, 0));
    page.graphics.drawString(orderNumber == null ? '' : orderNumber,
        PdfStandardFont(PdfFontFamily.helvetica, 10),
        bounds: Rect.fromLTWH(187, (pageSize.height / 3) - 32, 0, 0));
    page.graphics.drawString(
        formattedDate, PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: Rect.fromLTWH(60, pageSize.height - 230, 0, 0));

    page.graphics.drawString(
        formattedDate, PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: Rect.fromLTWH(60, pageSize.height - 98, 0, 0));
    page.graphics.drawImage(image,
        Rect.fromLTWH(pageSize.width - 140, pageSize.height - 251, 70, 25));
    page.graphics.drawImage(image,
        Rect.fromLTWH(pageSize.width - 140, pageSize.height - 118, 70, 25));
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

Future<Uint8List> _readImageData(String name) async {
  print("object");
  final data = await rootBundle.load('assets/documents/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
