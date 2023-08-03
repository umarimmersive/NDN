import 'package:audio_session/audio_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:national_digital_notes_new/utils/constants/api_service.dart';
import '../controllers/pdf_viewer_controller.dart';



T? ambiguate<T>(T? value) => value;


class AudioBottomSheet extends StatelessWidget with WidgetsBindingObserver {

  final audioController = Get.find<PdfViewer1Controller>();

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
 /* Stream<PositionData> get positionDataStream =>
      Rx.combineLatest2<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));
*/
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            bottomRight: Radius.circular(00.0),
            topLeft: Radius.circular(40.0),
            bottomLeft: Radius.circular(00.0)),
      ),
      height: 300,
      child: Column(

        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ListView.builder(
                shrinkWrap: true,
                clipBehavior: Clip.hardEdge,
                physics: BouncingScrollPhysics(),
                itemCount: audioController.book_audio_list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 05.0,left: 10,right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      clipBehavior: Clip.hardEdge,
                      elevation: 10,
                      child: ListTile(
                        trailing: Icon(Icons.play_arrow),
                        title: Text(audioController.book_audio_list[index]['title']),
                        onTap: () async {
                          audioController.musictitle.value=audioController.book_audio_list[index]['title'].toString();
                          await audioController.player.setAudioSource(AudioSource.uri(Uri.parse(ApiService.IMAGE_URL+audioController.book_audio_list[index]['audio'])));
                          audioController.player.play();

                          Get.back();

                          // _player.nextIndex!(ApiService.IMAGE_URL+audioController.book_audio_list[index]['audio'])
                          //audioController.playAudio(audioController.audioList[index]);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
