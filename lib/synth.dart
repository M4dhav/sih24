import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SynthesizeScreen extends StatefulWidget {
  const SynthesizeScreen({super.key});

  @override
  State<SynthesizeScreen> createState() => _SynthesizeScreenState();
}

class _SynthesizeScreenState extends State<SynthesizeScreen> {
  FlutterTts flutterTts = FlutterTts();
  Future _speak(String text) async {
    var result = await flutterTts.speak(text);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      List<dynamic> languages = await flutterTts.getLanguages;
      log(languages.toString());
      await flutterTts.setLanguage("en-US");

      await flutterTts.setSpeechRate(0.6);

      await flutterTts.setVolume(1.0);

      await flutterTts.setPitch(0.5);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
                onPressed: () async {
                  log('Start Speaking');
                  await _speak("Hello, I am speaking");
                },
                child: Text('Synthesize Audio'))));
  }
}
