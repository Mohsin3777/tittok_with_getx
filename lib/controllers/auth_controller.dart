import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constant.dart';
import 'package:tiktok_clone/models/user_model.dart' as model;
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';

class AuthController extends GetxController{

static AuthController  instance = Get.find();

late Rx<User?> _user;
late Rx<File?> _pickedImage;

User get user => _user.value!;

@override
void onReady(){
  super.onReady();
 _user = Rx<User?>(firebaseAuth.currentUser);
 _user.bindStream(firebaseAuth.authStateChanges()); 
 ever(_user, _setInitialScreen);
}

_setInitialScreen(User? user){
  if(user == null){
    Get.offAll(()=> LoginScreen());
  }else{
    Get.offAll(()=> HomeScreen());
  }
}

File? get profilePhoto  => _pickedImage.value;
// image piker
void pickImage()async{
  final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  if(pickedImage != null){
    Get.snackbar('Profile Picture', 'You have successfully selected your profile picture');
  }
  _pickedImage = Rx<File?>(File(pickedImage!.path));
}

// upload to storage
Future<String> _uploadToStorage(File image)async{
 Reference ref=  firebaseStorage.ref().child('profilepic').child(firebaseAuth.currentUser!.uid);

UploadTask uploadTask =  ref.putFile(image);
TaskSnapshot snap = await uploadTask;
String downloadUrl = await snap.ref.getDownloadURL();

return downloadUrl;

}

  // register user
  void registerUser(String username, String email , String password , File? image)async{
try {
  if(username.isNotEmpty && email.isNotEmpty && password.isNotEmpty && image != null){
    // save out user to auth and firebase firestore
  UserCredential cred = await  firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

 String downloadUrl = await _uploadToStorage(image);
 model.User user = model.User(name: username, profilePhoto: downloadUrl, email: email, uid: cred.user!.uid);

 await firestore.collection('users').doc(cred.user!.uid).set(user.tojson());
  }else{
      Get.snackbar('Error creating an account', 'Please enter all the fields');
  }
} catch (e) {
  Get.snackbar('Error creating an account', e.toString());
}
  }

  // login user
  void loginUser(String email, String password)async{
  try {
      if(email.isNotEmpty && password.isNotEmpty){
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      print('log success');
    }else{
         Get.snackbar('Error login an account', 'Please enter all the fields');
    }
  } catch (e) {
       Get.snackbar('Error in login an account', e.toString());
  }
  }
}