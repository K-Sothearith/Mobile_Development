import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(
    debugShowCheckedModeBanner: false, // Why this line ? Can you explain it ?
    home: ImageGallery()
  ),
);

class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key});

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  List<String> images = [
    'assets/w4-s2/bird.jpg',
    'assets/w4-s2/bird2.jpg',
    'assets/w4-s2/insect.jpg',
    'assets/w4-s2/girl.jpg',
    'assets/w4-s2/man.jpg',
  ];

  int currentImageIndex = 0;

  void showPreviousImage() {
    setState(() {
      int index = currentImageIndex - 1;
      if (index == -1) index = images.length - 1;
      currentImageIndex = index;
    });
  }

  void showNextImage() {
    setState(() {
      int index = currentImageIndex + 1;
      if (index == images.length) index = 0;
      currentImageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: const Text('Image viewer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.navigate_before),
            tooltip: 'Go to the previous image',
            onPressed: showPreviousImage,
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Go to the next image',
            onPressed: showNextImage,
          ),
        ],
      ),
      body: Image.asset(
        images[currentImageIndex],
        width: double.infinity,
        fit: BoxFit.contain,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
