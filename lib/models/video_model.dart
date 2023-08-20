import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Video {
  String userName;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilePhoto;
  Video( {
    required this.userName,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.videoUrl,
    required this.thumbnail,
    required this.profilePhoto,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userName': userName,
      'uid': uid,
      'id': id,
      'likes': likes,
      'commentCount': commentCount,
      'shareCount': shareCount,
      'songName': songName,
      'caption': caption,
      'videoUrl': videoUrl,
      'thumbnail': thumbnail,
      'profilePhoto': profilePhoto,
    };
  }

  static Video fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return Video(
        userName: snapShot['userName'],
        uid: snapShot['uid'],
        id: snapShot['id'],
        likes: snapShot['likes'],
        commentCount: snapShot['commentCount'],
        shareCount: snapShot['shareCount'],
        songName: snapShot['songName'],
        caption: snapShot['caption'],
        videoUrl: snapShot['videoUrl'],
        thumbnail: snapShot['thumbnail'],
        profilePhoto: snapShot['profilePhoto']);
  }
}
