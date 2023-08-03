

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:national_digital_notes_new/utils/constants/ColorValues.dart';

import '../controllers/pdf_viewer_controller.dart';
import 'AudioBottomSheet.dart';
import 'common.dart';

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;
  ControlButtons(this.player, {Key? key}) : super(key: key);
  final audioController = Get.find<PdfViewer1Controller>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        
      },
      child:  Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.cyanAccent,
                          Colors.cyan,
                        ],
                      )
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Expanded(
                                flex: 1,
                                child: Container(

                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(audioController.musictitle.value,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold), maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                )),

                            // Opens volume slider dialog
                             IconButton(
                                icon: const Icon(Icons.volume_up,color: Colors.white),
                                onPressed: () {
                                  showSliderDialog(
                                    context: context,
                                    title: "Adjust volume",
                                    divisions: 10,
                                    min: 0.0,
                                    max: 1.0,
                                    value: player.volume,
                                    stream: player.volumeStream,
                                    onChanged: player.setVolume,
                                  );
                                },
                              ),

                            /// This StreamBuilder rebuilds whenever the player state changes, which
                            /// includes the playing/paused state and also the
                            /// loading/buffering/ready state. Depending on the state we show the
                            /// appropriate button or loading indicator.
                            StreamBuilder<PlayerState>(
                              stream: player.playerStateStream,
                              builder: (context, snapshot) {
                                final playerState = snapshot.data;
                                final processingState = playerState?.processingState;
                                final playing = playerState?.playing;
                                if (processingState == ProcessingState.loading ||
                                    processingState == ProcessingState.buffering) {
                                  return Container(
                                    margin: const EdgeInsets.all(8.0),
                                    width: 25.0,
                                    height: 25.0,
                                    child: const CupertinoActivityIndicator(),
                                  );
                                } else if (playing != true) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color:  Colors.black,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.play_arrow,color: Colors.white),
                                      iconSize: 25.0,
                                      onPressed: player.play,
                                    ),
                                  );
                                } else if (processingState != ProcessingState.completed) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color:  Colors.black,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.pause,color: Colors.white),
                                      iconSize: 25.0,
                                      onPressed: player.pause,
                                    ),
                                  );
                                } else {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color:  Colors.black,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.replay,color: Colors.white),
                                      iconSize: 20.0,
                                      onPressed: () => player.seek(Duration.zero),
                                    ),
                                  );
                                }
                              },
                            ),
                            // Opens speed slider dialog
                             StreamBuilder<double>(
                                stream: player.speedStream,
                                builder: (context, snapshot) => IconButton(
                                  icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                                      style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                                  onPressed: () {
                                    showSliderDialog(
                                      context: context,
                                      title: "Adjust speed",
                                      divisions: 10,
                                      min: 0.5,
                                      max: 1.5,
                                      value: player.speed,
                                      stream: player.speedStream,
                                      onChanged: player.setSpeed,
                                    );
                                  },
                                ),
                              ),


                          ],
                        ),
                      ),
                      StreamBuilder<PositionData>(
                        stream: audioController.positionDataStream,
                        builder: (context, snapshot) {
                          final positionData = snapshot.data;
                          return SeekBar(
                            duration: positionData?.duration ?? Duration.zero,
                            position: positionData?.position ?? Duration.zero,
                            bufferedPosition:
                            positionData?.bufferedPosition ?? Duration.zero,
                            onChangeEnd: audioController.player.seek,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          InkWell(
            onTap: (){
              Get.bottomSheet<AudioBottomSheet>(
                AudioBottomSheet(),
              ).then((value){
                print('back-------${value}');
                audioController.onInit();
                /*  if (value[0]["backValue"] == "one") {
                        print("Result is coming");
                      }*/
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 0,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              height: 20,
              width: 100,
              child: Icon(
                Icons.arrow_drop_up_outlined,
                color: Colors.black,
                size: 25.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}