import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF file',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: PdfPreviewScreen(),
    );
  }
}

class PdfPreviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview File', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.pinkAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: PdfPreview(
        build: (format) => generatePdf(format,"The Flutter PDF Viewer widget lets you view PDF documents seamlessly and efficiently on the Android, iOS, web, Windows, and macOS platforms. It has highly interactive and customizable features such as magnification, virtual bidirectional scrolling, page navigation, text selection, text search, page layout options, document link navigation, bookmark navigation, form filling, and reviewing with text markup annotations."),
        actionBarTheme: PdfActionBarTheme(backgroundColor: Colors.pinkAccent),
      ),
    );
  }

  Future<bool> requestPermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    } else {
      if (await Permission.storage.isPermanentlyDenied) {
        openAppSettings();
      }
      return false;
    }
  }
}

Future<Uint8List> generatePdf(PdfPageFormat format, String s) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: format,
      build: (context) {
        return pw.Center(
          child: pw.Text(
            s,
            style: pw.TextStyle(fontSize: 40),
          ),
        );
      },
    ),
  );

  return pdf.save();
}
