import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Image-Video Picker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File pickedImage;
  File pickedVideo;

  void _pickImageFromCamera() async {
    final imageFromCamera = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (imageFromCamera != null) {
      setState(() {
        pickedImage = imageFromCamera;
      });
    }
  }

  void _pickImageFromGallery() async {
    final imageFromGallery = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (imageFromGallery != null) {
      setState(() {
        pickedImage = imageFromGallery;
      });
    }
  }

  void _pickVideoFromCamera() async {
    final videoFromCamera = await ImagePicker.pickVideo(
      source: ImageSource.camera,
    );

    if (videoFromCamera != null) {
      setState(() {
        pickedVideo = videoFromCamera;
      });
    }
  }

  void _pickVideoFromGallery() async {
    final videoFromGallery = await ImagePicker.pickVideo(
      source: ImageSource.gallery,
    );

    if (videoFromGallery != null) {
      setState(() {
        pickedVideo = videoFromGallery;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: screenSize.width,
              height: 200,
              color: Colors.green,
              child: pickedImage == null
                  ? Center(
                      child: Icon(Icons.camera),
                    )
                  : Image.file(pickedImage),
            ),
            Container(
              width: screenSize.width,
              height: 200,
              color: Colors.blue,
              child: pickedVideo == null
                  ? Center(
                      child: Icon(Icons.video_library),
                    )
                  : mounted
                      ? Chewie(
                          controller: ChewieController(
                            videoPlayerController: VideoPlayerController.file(
                              pickedVideo,
                            ),
                            autoPlay: true,
                            aspectRatio: 3 / 2,
                          ),
                        )
                      : Container(),
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              onPressed: _pickImageFromCamera,
              child: Container(
                width: screenSize.width * 0.5,
                child: Row(
                  children: <Widget>[
                    Text('Pick Image from Camera'),
                    SizedBox(width: 5.0),
                    Icon(Icons.camera_alt),
                  ],
                ),
              ),
            ),
            RaisedButton(
              onPressed: _pickImageFromGallery,
              child: Container(
                width: screenSize.width * 0.5,
                child: Row(
                  children: <Widget>[
                    Text('Pick Image from Gallery'),
                    SizedBox(width: 5.0),
                    Icon(Icons.image),
                  ],
                ),
              ),
            ),
            RaisedButton(
              onPressed: _pickVideoFromCamera,
              child: Container(
                width: screenSize.width * 0.5,
                child: Row(
                  children: <Widget>[
                    Text('Pick Video from Camera'),
                    SizedBox(width: 5.0),
                    Icon(Icons.video_call),
                  ],
                ),
              ),
            ),
            RaisedButton(
              onPressed: _pickVideoFromGallery,
              child: Container(
                width: screenSize.width * 0.5,
                child: Row(
                  children: <Widget>[
                    Text('Pick Viedo from Gallery'),
                    SizedBox(width: 5.0),
                    Icon(Icons.video_library)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
