import 'package:flutter/material.dart';
import 'package:vosk_test/transcribe.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/transcribe');
                },
                child: Text('Go to Transcribe Screen')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/synthesize');
                },
                child: Text('Go to Synthesize Screen'))
          ],
        ),
      ),
    );
  }
}
