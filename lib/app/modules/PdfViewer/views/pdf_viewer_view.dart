import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';




import '../../../../utils/constants/api_service.dart';
import '../controllers/pdf_viewer_controller.dart';

class PdfViewerView extends GetView<PdfViewer1Controller> {
   PdfViewerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=> SfPdfViewer.network('${ApiService.IMAGE_URL+controller.pdf_url.value}',canShowHyperlinkDialog: true,canShowScrollStatus: true,canShowScrollHead: true,canShowPasswordDialog: true,canShowPaginationDialog: true,enableDocumentLinkAnnotation: true,enableDoubleTapZooming: true,enableHyperlinkNavigation: true,enableTextSelection: true)),
    );
  }
}
