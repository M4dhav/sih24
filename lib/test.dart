import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vosk_flutter_2/vosk_flutter_2.dart';

class ModelScreen extends StatefulWidget {
  const ModelScreen({super.key});

  @override
  State<ModelScreen> createState() => _ModelScreenState();
}

class _ModelScreenState extends State<ModelScreen> {
  FlutterTts flutterTts = FlutterTts();
  Future _speak() async {
    var result = await flutterTts.speak("Hello World      ");
  }

  VoskFlutterPlugin? vosk;
  String? smallModel;
  Recognizer? recognizer;
  Model? model;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      vosk = VoskFlutterPlugin.instance();
      smallModel = await ModelLoader()
          .loadFromAssets('assets/models/vosk-model-small-en-in-0.4.zip');
      model = await vosk!.createModel(smallModel!);
      recognizer = await vosk!.createRecognizer(
        model: model!,
        sampleRate: 10000,
      );
      List<dynamic> languages = await flutterTts.getLanguages;
      log(languages.toString());
      await flutterTts.setLanguage("en-US");

      await flutterTts.setSpeechRate(0.6);

      await flutterTts.setVolume(1.0);

      await flutterTts.setPitch(0.5);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // log("Start Listening");
          // final speechService = await vosk!.initSpeechService(recognizer!);
          // speechService.onPartial().forEach((partial) => print(partial));
          // speechService.onResult().forEach((result) => print(result));
          // await speechService.start();
          log('Start Speaking');
          await _speak();
        },
        child: Icon(Icons.mic),
      ),
    );
  }
}
