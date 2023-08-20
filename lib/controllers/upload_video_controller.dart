import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constant.dart';
import 'package:tiktok_clone/models/video_model.dart';

import 'package:video_compress_ds/video_compress_ds.dart';

class UploadVideoController extends GetxController {
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);

    return compressedVideo!.file;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnail').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      // get id
      var allDoc = await firestore.collection('videos').get();
      int len = allDoc.docs.length+1;
      String videoUrl = await _uploadVideoToStorage('Video $len', videoPath);

      String thumbnail = await _uploadImageToStorage('Video $len', videoPath);

      Video video = Video(
          userName: (userDoc.data()! as Map<String, dynamic>)['name'],
          uid: uid,
          id: 'Video $len',
          likes: [],
          commentCount: 0,
          shareCount: 0,
          songName: songName,
          caption: caption,
          videoUrl: videoUrl,
          thumbnail: thumbnail,
          profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto']);


          await firestore.collection('vidoes').doc('Video $len').set(
            video.toJson()
          );
          Get.back();
    } catch (e) {

      Get.snackbar('Error Upload in error', e.toString());
    }
  }
}
