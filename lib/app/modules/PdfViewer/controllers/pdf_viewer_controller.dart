import 'dart:convert';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart'as Get;
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'package:national_digital_notes_new/app/modules/PdfViewer/views/common.dart';

import '../../../../utils/constants/api_service.dart';
import '../../../../utils/global_widgets/globle_var.dart';
import 'package:rxdart/rxdart.dart';
class PdfViewer1Controller extends Get.GetxController with WidgetsBindingObserver {
  //TODO: Implement PdfViewerController

  final count = 0.obs;
  final pdf_url = ''.obs;
  final bookid = ''.obs;
  final title = ''.obs;
  final musictitle = 'Select Music'.obs;
  final notedetails = ''.obs;
  final player = AudioPlayer();

  @override
  void onInit() async{
    isLoading.value=true;
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    pdf_url.value=Get.Get.parameters['pdf_url'].toString();
    bookid.value=Get.Get.parameters['bookId'].toString();
    title.value=Get.Get.parameters['title'].toString();

    print('pdf_url-----------$pdf_url');



    notedetails.value=Get.Get.parameters['notedetails'].toString();

    print('----------------------------------$notedetails');


    if(count.value==0){
      if(notedetails.value=='true'){
        print("notedetails========+============");
        await noteDetails();
        init();
      }else{
        await callApi();
        init();
      }
    }
    isLoading.value=false;
    super.onInit();
  }
  var book_detils=[].obs;
  var book_audio_list=[].obs;

  final isLoading=false.obs;
  final wishlist_isLoading=false.obs;
  final Add_to_cart_isLoading=false.obs;
  final status=false.obs;
  var data;

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));



  callApi() async{

    book_detils.clear();
    book_audio_list.clear();
    isLoading(true);



    http.Response response = await http.post(Uri.parse(ApiService.BASE_URL+'bookDetails'),body: {
      "book_id": bookid.value.toString(),
      "user_id": userData!.userId,
    });



    data=jsonDecode(response.body);
    // print("favv==================${data['data'][0]['is_fav']}");

    status.value=data['success'];

    print("dataaaa=======================$data");

    if (data['success'] == true) {
      count.value=1;
      print(response);
      print(response.body);
      book_detils.addAll(data['data']);
      book_audio_list.addAll(data['data'][0]['sample_audio']);
      //book_detils.value = data['data'];
      print("book_audio_list---------------------------------$book_audio_list");

      isLoading(false);
      //update();
    } else if (data['success'] == false) {
      //book_detils.value = data;
      isLoading(false);


    }

  }

  noteDetails() async{
    book_detils.clear();
    book_audio_list.clear();
    print('bookid====================${bookid.value.toString()}');
    // bookList.clear();
    isLoading(true);



    print('user---------${userData!.userId}');
    print('bbok id---------${bookid.value.toString()}');


    http.Response response = await http.post(Uri.parse(ApiService.BASE_URL+'noteDetails'),body: {
      "note_id": bookid.value.toString(),
      "user_id": userData!.userId,
    });

    data=jsonDecode(response.body);
    status.value=data['success'];
  count.value=1;

    if (data['success'] == true) {

      print(response);
      print(response.body);
      book_detils.addAll(data['data']);

      book_audio_list.addAll(data['data'][0]['sample_audio']);
      //book_detils.value = data['data'];

      print("book_audio_list---------------------------------$book_audio_list");
      print("book_audio_list---------------------------------${data['data'][0]['sample_audio']}");
      isLoading(false);

      //update();
    } else if (data['success'] == false) {
      //book_detils.value = data;
      isLoading(false);

    }

  }









  Future<void> init() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    player.playbackEventStream.listen((event) {
    },
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    // Try to load audio from a source and catch any errors.
    try {
      print('set diffult aaaaudio----------------------------');
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await player.setAudioSource(AudioSource.uri(Uri.parse(ApiService.IMAGE_URL+book_audio_list[0]['audio'])));
      //await _player.play();
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      player.stop();
    }
  }

  final audioList = [
    'Audio 1',
    'Audio 2',
    'Audio 3',
    'Audio 4','Audio 1',
    'Audio 4','Audio 1',
    'Audio 2',
    'Audio 3',
    'Audio 4',
  ];

  var currentTrack = ''.obs;

  AudioPlayer audioPlayer = AudioPlayer();
  final isPlaying = false.obs;




  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    player.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
