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
  VoskFlutterPlugin? vosk;
  String? smallModel;
  Recognizer? recognizer;
  Model? model;
  TextEditingController textController = TextEditingController();
  SpeechService? speechService;

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

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: textController,
            ),
            ElevatedButton(
                onPressed: () async {
                  log("Start Listening");
                  speechService = await vosk!.initSpeechService(recognizer!);
                  setState(() {});
                  speechService!.onPartial().forEach((partial) {
                    textController.text += partial;
                    setState(() {});
                  });
                  speechService!
                      .onResult()
                      .forEach((result) => log("Result: $result"));
                  await speechService!.start();
                },
                child: Text('Transcribe Audio')),
            ElevatedButton(
                onPressed: () async {
                  log("Stop Listening");

                  await speechService!.stop();
                },
                child: Text('Stop Transcription')),
          ],
        ),
      ),
    );
  }
}
