import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/upload_video_controller.dart';
import 'package:video_player/video_player.dart';

class ConformScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConformScreen({super.key, required this.videoFile, required this.videoPath});

  @override
  State<ConformScreen> createState() => _ConformScreenState();
}

class _ConformScreenState extends State<ConformScreen> {

late VideoPlayerController controller;
TextEditingController _songController = TextEditingController();
TextEditingController _captionController = TextEditingController();

UploadVideoController uploadVideoController = Get.put(UploadVideoController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }


    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: SingleChildScrollView(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
   const   SizedBox(height: 30,),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/1.5,
        child: VideoPlayer(controller),
      ),
         const   SizedBox(height: 30,),
         SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
Container(
  margin: EdgeInsets.symmetric(horizontal: 10),
       width: MediaQuery.of(context).size.width -20,
       child: TextField(
        controller: _songController,
        decoration: InputDecoration(
          labelText: 'Song Name',
          icon: Icon(Icons.music_note),
        ),
       ),
),
        const   SizedBox(height: 20,),
        Container(
  margin: EdgeInsets.symmetric(horizontal: 10),
       width: MediaQuery.of(context).size.width -20,
       child: TextField(
        controller: _captionController,
        decoration: InputDecoration(
          labelText: 'Caption',
          icon: Icon(Icons.closed_caption),
        ),
       ),
        ),
                const   SizedBox(height: 20,),
                ElevatedButton(onPressed: ()=> uploadVideoController.uploadVideo(_songController.text.trim()
                , _captionController.text.trim(), widget.videoPath), child: Text('Share',style: TextStyle(fontSize: 20,color: Colors.white),))
            ],
          ),
         ),
    ],
  ),
),
    );
  }
}