import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constant.dart';
import 'package:tiktok_clone/views/screens/conform_screen.dart';

class AddVdieoScreen extends StatelessWidget {
  const AddVdieoScreen({super.key});


pickVideo(BuildContext context ,ImageSource src)async{
  final video = await ImagePicker().pickVideo(source: src);
  if(video != null){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ConformScreen(videoFile: File(video.path), videoPath: video.path)));
  }
}

showOptionsDialog(BuildContext context){
  return showDialog(context: context, builder: (context)=> SimpleDialog(
    children: [
      SimpleDialogOption(
        onPressed: ()=> pickVideo(context, ImageSource.gallery),
        child: Row(
          children: const[
            Icon(Icons.image),
            Padding(
              padding:  EdgeInsets.all(7.0),
              child: Text('Gallery',style: TextStyle(fontSize: 20),),
            )
          ],
        ),
      ),

         SimpleDialogOption(
             onPressed: ()=> pickVideo(context, ImageSource.camera),
        child: Row(
          children: [
            Icon(Icons.camera_alt),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text('Camera',style: TextStyle(fontSize: 20),),
            )
          ],
        ),
      ),

         SimpleDialogOption(
        onPressed: ()=> Navigator.of(context).pop(),
        child: Row(
          children: [
            Icon(Icons.cancel),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text('Cancel',style: TextStyle(fontSize: 20),),
            )
          ],
        ),
      ),
    ],
  ));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: ()=> showOptionsDialog(context),
child: Container(
  width: 190,
  height: 50,
  decoration:  BoxDecoration(
    color: buttonColor,
  ),
  child: const Center(
    child: Text('Add Video',
    style: TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    ),
  ),
),
        ),
      ),
    );
  }
}