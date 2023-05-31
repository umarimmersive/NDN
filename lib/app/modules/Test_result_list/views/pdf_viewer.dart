import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class TestingPDF2 extends StatefulWidget {
  String? pdf_url;
   TestingPDF2({Key? key, required this.pdf_url}) : super(key: key);

  @override
  State<TestingPDF2> createState() => _TestingPDFState();
}

class _TestingPDFState extends State<TestingPDF2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SfPdfViewer.network(widget.pdf_url.toString(),canShowHyperlinkDialog: true,canShowScrollStatus: true,canShowScrollHead: true,canShowPasswordDialog: true,canShowPaginationDialog: true,enableDocumentLinkAnnotation: true,enableDoubleTapZooming: true,enableHyperlinkNavigation: true,enableTextSelection: true),
      ),
    );
  }
}
