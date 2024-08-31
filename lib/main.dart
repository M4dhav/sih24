import 'package:flutter/material.dart';
import 'package:vosk_test/home.dart';
import 'package:vosk_test/synth.dart';
import 'package:vosk_test/transcribe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      routes: {
        '/transcribe': (context) => const ModelScreen(),
        '/synthesize': (context) => const SynthesizeScreen(),
      },
    );
  }
}
