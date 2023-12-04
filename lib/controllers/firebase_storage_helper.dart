import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageHelper {
  User? user = FirebaseAuth.instance.currentUser;
  static FirebaseStorageHelper instance = FirebaseStorageHelper();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadUserImage(String userId, File image) async {
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

  Future<String> uploadImage(XFile? file, String? reference) async {
    File _file = File(file!.path);
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref(reference);

    await ref.putFile(_file);

    String dounloadURL = await ref.getDownloadURL();
    return dounloadURL;
  }
}
