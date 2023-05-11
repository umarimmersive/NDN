import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../utils/constants/api_service.dart';

class TestingPDF extends StatefulWidget {

  String? pdf_url;
   TestingPDF({Key? key, required this.pdf_url}) : super(key: key);

  @override
  State<TestingPDF> createState() => _TestingPDFState();
}

class _TestingPDFState extends State<TestingPDF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfPdfViewer.network('${ApiService.IMAGE_URL+widget.pdf_url!}',canShowHyperlinkDialog: true,canShowScrollStatus: true,canShowScrollHead: true,canShowPasswordDialog: true,canShowPaginationDialog: true,enableDocumentLinkAnnotation: true,enableDoubleTapZooming: true,enableHyperlinkNavigation: true,enableTextSelection: true),
    );
  }
}
