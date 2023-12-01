import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirebaseStorageService extends GetxService{

  Reference get firebaseStorage=> FirebaseStorage.instance.ref();
  
  Future<String?> getImage(String? imgName) async {
    if(imgName == null){
      return null;
    }
    try{
      var urlRef=firebaseStorage.child("/images_profile/Female")
          .child('${imgName.toLowerCase()}.jpg');
      var imgUrl = await urlRef.getDownloadURL();
      return imgUrl;
    } catch (e){
      return null;
    }
  }

  Future<String?> uploadImage(File imageFile, String path, String num) async {
    try {
      var uploadTask = firebaseStorage.child(path)
          .child('${num}.jpg')
          .putFile(imageFile);

      var snapshot = await uploadTask;
      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}