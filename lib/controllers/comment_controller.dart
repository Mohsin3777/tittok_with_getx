import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constant.dart';
import 'package:tiktok_clone/models/comment_model.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;

  String _postId = "";

   updatePostId(String id) {
    _postId = id;
    postComment(_postId);
  }

  postComment(String commentText) async {
try {
      if (commentText.isNotEmpty) {
      DocumentSnapshot userDoc = await firestore
          .collection('users')
          .doc(authController.user.uid)
          .get();
      var allDocs = await firestore
          .collection('vidoes')
          .doc(_postId)
          .collection('comments')
          .get();

      int len = allDocs.docs.length;
      Comment comment = Comment(
          username: (userDoc.data()! as dynamic)['name'],
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          profilePhoto: (userDoc.data()! as dynamic)['profilePhoto'],
          uid: authController.user.uid,
          id: 'comment $len');
          await firestore.collection('vidoes').doc(_postId).collection('comments').doc('comment $len')
          .set(comment.toJson());


          DocumentSnapshot doc = await firestore.collection('comments').doc(_postId).get();
      await    firestore.collection('vidoes').doc(_postId).update({
            'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
          });
    }
} catch (e) {
  Get.snackbar('Error while commenting', e.toString());
}
  }
}
