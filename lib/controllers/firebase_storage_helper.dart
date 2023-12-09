import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper {
  static FirebaseStorageHelper instance = FirebaseStorageHelper();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Future<String> uploadSellerImage(File image, File image) async {
  //   String userId = FirebaseAuth.instance.currentUser!.uid;
  //   TaskSnapshot taskSnapshot =
  //       await _storage.ref('sellers/${userId}/profile').putFile(image);
  //   String imageUrl = await taskSnapshot.ref.getDownloadURL();
  //   return imageUrl.toString();
  // }

  Future<void> updateUserImageInFirestore(String imageUrl) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Update the 'image' field in the user's Firestore document
    await FirebaseFirestore.instance.collection('sellers').doc(userId).update({
      'image': imageUrl,
    });
  }

  Future<String> uploadSellerImage(String userId, File image) async {
    TaskSnapshot taskSnapshot = await _storage.ref(userId).putFile(image);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future<String> uploadCategoryImage(String categoryId, File image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    TaskSnapshot taskSnapshot =
        await _storage.ref('$categoryId/$fileName').putFile(image);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future<String> uploadProductImage(String categoryId, File image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    TaskSnapshot taskSnapshot =
        await _storage.ref('$categoryId/productId/$fileName').putFile(image);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }
}
