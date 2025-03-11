import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DigitalPictureFrame(),
    );
  }
}

class DigitalPictureFrame extends StatefulWidget {
  @override
  _DigitalPictureFrameState createState() => _DigitalPictureFrameState();
}

class _DigitalPictureFrameState extends State<DigitalPictureFrame> {
  final List<String> imagePaths = [
    "assets/pic1.jpg",
    "assets/pic2.jpg",
    "assets/pic3.jpg",
  ];
  int currentIndex = 0;
  Timer? _timer;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    startSlideshow();
  }

  void startSlideshow() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (!isPaused) {
        setState(() {
          currentIndex = (currentIndex + 1) % imagePaths.length;
        });
      }
    });
  }

  void toggleSlideshow() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text('Digital Picture Frame'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imagePaths[currentIndex],
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.6,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleSlideshow,
        child: Icon(isPaused ? Icons.play_arrow : Icons.pause),
      ),
    );
  }
}