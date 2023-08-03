import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../utils/constants/api_service.dart';
import '../controllers/pdf_viewer_controller.dart';
import 'AudioBottomSheet.dart';
import 'ControlButtons.dart';
import 'common.dart';

class PdfViewerView extends GetView<PdfViewer1Controller> {
   PdfViewerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(controller.isLoading.isFalse){
        return Scaffold(
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display play/pause button and volume/speed sliders.
              ControlButtons(controller.player),
              // Display seek bar. Using StreamBuilder, this widget rebuilds
              // each time the position, buffered position or duration changes.
              /* StreamBuilder<PositionData>(

              //stream: audioController.positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return SeekBar(
                  duration: positionData?.duration ?? Duration.zero,
                  position: positionData?.position ?? Duration.zero,
                  bufferedPosition:
                  positionData?.bufferedPosition ?? Duration.zero,
                  onChangeEnd: controller.player.seek,
                );
              },
            ),*/
            ],
          ),
          appBar: AppBar(
            title:  Text(controller.title.value),
            centerTitle: false,
            actions: [

              InkWell(
                  onTap: (){
                    Get.bottomSheet<AudioBottomSheet>(
                      AudioBottomSheet(),
                    ).then((value){
                      print('back-------${value}');
                      controller.onInit();
                      /*  if (value[0]["backValue"] == "one") {
                        print("Result is coming");
                      }*/
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset('assets/volume.png',width: 30,height: 30,color: Colors.white,),
                  )),


            ],
          ),
          body: Obx(()=> SfPdfViewer.network('${ApiService.IMAGE_URL+controller.pdf_url.value}',canShowHyperlinkDialog: true,canShowScrollStatus: true,canShowScrollHead: true,canShowPasswordDialog: true,canShowPaginationDialog: true,enableDocumentLinkAnnotation: true,enableDoubleTapZooming: true,enableHyperlinkNavigation: true,enableTextSelection: true)),
        );
      }else{
        return Scaffold(
            appBar: AppBar(
              title:  Text(controller.title.value),
              centerTitle: false,
              actions: [
             /*   IconButton(
                    icon: Icon(
                        Icons.audiotrack,
                        color: Colors.white,
                        size: 34.0),
                    onPressed: (){
                      Get.bottomSheet<AudioBottomSheet>(
                        AudioBottomSheet(),
                      );

                    }
                ),*/
              ],
            ),
            body: Center(child: CupertinoActivityIndicator(),));
      }
    }
    );
  }
}
