// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/model/select_status_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellers/constants/constants.dart';
import 'package:sellers/constants/routes.dart';
import 'package:sellers/controllers/firebase_storage_helper.dart';
import 'package:sellers/models/seller_model.dart';
import 'package:sellers/screens/home_page.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      ShowLoderDialog(context);

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Routes.instance
          .pushAndRemoveUntil(widget: const HomePage(), context: context);
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      showMessage(error.code.toString());
      return false;
    }
  }

  Future<bool> signUp(
    String firstName,
    String middleName,
    String lastName,
    String email,
    String password,
    String phoneNumber,
    String country,
    String region,
    String city,
    String zone,
    String woreda,
    String kebele,
    XFile? idCard,
    XFile? profilePhoto,
    BuildContext context,
  ) async {
    try {
      ShowLoderDialog(context);

      UserCredential? userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String profilUri = await FirebaseStorageHelper.instance.uploadImage(
          profilePhoto, 'sellers/${userCredential.user!.uid}/profile.jpg');
      String idCardUri = await FirebaseStorageHelper.instance.uploadImage(
          idCard, 'sellers/${userCredential.user!.uid}/profile.jpg');

      SellerModel sellerModel = SellerModel(
        id: userCredential.user!.uid,
        approved: false,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        country: country,
        region: region,
        city: city,
        zone: zone,
        woreda: woreda,
        kebele: kebele,
        idCard: idCardUri,
        profilePhoto: profilUri,
      );
      Routes.instance
          .pushAndRemoveUntil(widget: const HomePage(), context: context);

      _firestore
          .collection('sellers')
          .doc(sellerModel.id)
          .set(sellerModel.toJson());
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      showMessage(error.code.toString());
      return false;
    }
  }

  void signOut() async {
    await _auth.signOut();
  }

  Future<bool> changePassword(String password, BuildContext context) async {
    try {
      ShowLoderDialog(context);

      _auth.currentUser!.updatePassword(password);

      Navigator.of(context, rootNavigator: true).pop();
      showMessage('Password changed');
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      showMessage(error.code.toString());
      return false;
    }
  }
}





// ////////////////////////////////////////////////////////////////
// class FirebaseAuthHelper {
//   static FirebaseAuthHelper instance = FirebaseAuthHelper();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   Stream<User?> get getAuthChange => _auth.authStateChanges();

//   Future<bool> login(
//       String email, String password, BuildContext context) async {
//     try {
//       ShowLoderDialog(context);

//       await _auth.signInWithEmailAndPassword(email: email, password: password);

//       Routes.instance
//           .pushAndRemoveUntil(widget: const HomePage(), context: context);
//       Navigator.of(context).pop();
//       return true;
//     } on FirebaseAuthException catch (error) {
//       showMessage(error.code.toString());
//       return false;
//     }
//   }

//   Future<bool> signUp(
//     String firstName,
//     String middleName,
//     String lastName,
//     String email,
//     String password,
//     String phoneNumber,
//     String country,
//     String region,
//     String city,
//     String zone,
//     String woreda,
//     String kebele,
//     // XFile? idCard,
//     // XFile? profilePhoto,
//     BuildContext context,
//   ) async {
//     // String imageUrl = await FirebaseStorageHelper.instance
//     //     .uploadUserImage(reference.id, image);
//     try {
//       ShowLoderDialog(context);

//       UserCredential? userCredential = await _auth
//           .createUserWithEmailAndPassword(email: email, password: password);
//       // String profilUri = await FirebaseStorageHelper.instance.uploadImage(
//       //     profilePhoto, 'sellers/${userCredential.user!.uid}/profile.jpg');
//       // String idCardUri = await FirebaseStorageHelper.instance.uploadImage(
//       //     idCard, 'sellers/${userCredential.user!.uid}/profile.jpg');

//       SellerModel sellerModel = SellerModel(
//           approved: false,
//           id: userCredential.user!.uid,
//           firstName: firstName,
//           middleName: middleName,
//           lastName: lastName,
//           email: email,
//           phoneNumber: phoneNumber,
//           password: password,
//           country: country,
//           region: region,
//           city: city,
//           zone: zone,
//           woreda: woreda,
//           kebele: kebele,
//           idCard: null,
//           profilePhoto: null);

//       // Create the user in Firestore
//       _firestore
//           .collection('sellers')
//           .doc(sellerModel.id)
//           .set(sellerModel.toJson());
//       Navigator.of(context).pop();

//       // Routes.instance
//       //     .pushAndRemoveUntil(widget: const HomePage(), context: context);

//       return true;
//     } on FirebaseAuthException catch (error) {
//       showMessage(error.code.toString());
//       return false;
//     }
//   }

//   void signOut() async {
//     await _auth.signOut();
//   }

//   Future<bool> changePassword(String password, BuildContext context) async {
//     try {
//       ShowLoderDialog(context);

//       await _auth.currentUser!.updatePassword(password);

//       Navigator.of(context, rootNavigator: true).pop();
//       showMessage('Password changed');
//       Navigator.of(context).pop();
//       return true;
//     } on FirebaseAuthException catch (error) {
//       showMessage(error.code.toString());
//       return false;
//     }
//   }

//   // Added method to get the current user's data
//   Future<SellerModel?> getUser(String id) async {
//     try {
//       DocumentSnapshot<Map<String, dynamic>> userDoc =
//           await _firestore.collection('sellers').doc(id).get();

//       if (userDoc.exists) {
//         return SellerModel.fromJson(userDoc.data()!);
//       } else {
//         return null;
//       }
//     } catch (error) {
//       print('Error fetching user data: $error');
//       return null;
//     }
//   }
// }



















// // ignore_for_file: use_build_context_synchronously

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:csc_picker/model/select_status_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sellers/constants/constants.dart';
// import 'package:sellers/constants/routes.dart';
// import 'package:sellers/models/seller_model.dart';
// import 'package:sellers/screens/home_page.dart';

// class FirebaseAuthHelper {
//   static FirebaseAuthHelper instance = FirebaseAuthHelper();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   Stream<User?> get getAuthChange => _auth.authStateChanges();

//   Future<bool> login(
//       String email, String password, BuildContext context) async {
//     try {
//       ShowLoderDialog(context);

//       await _auth.signInWithEmailAndPassword(email: email, password: password);

//       Routes.instance
//           .pushAndRemoveUntil(widget: const HomePage(), context: context);
//       Navigator.of(context).pop();
//       return true;
//     } on FirebaseAuthException catch (error) {
//       showMessage(error.code.toString());
//       return false;
//     }
//   }

//   Future<bool> signUp(
//     String firstName,
//     String middleName,
//     String lastName,
//     String email,
//     String password,
//     String phoneNumber,
//     String country,
//     String region,
//     String city,
//     String zone,
//     String woreda,
//     String kebele,
//     BuildContext context,
//   ) async {
//     try {
//       ShowLoderDialog(context);

//       UserCredential? userCredential = await _auth
//           .createUserWithEmailAndPassword(email: email, password: password);

//       SellerModel sellerModel = SellerModel(
//         id: userCredential.user!.uid,
//         firstName: firstName,
//         middleName: middleName,
//         lastName: lastName,
//         email: email,
//         phoneNumber: phoneNumber,
//         password: password,
//         country: country,
//         region: region,
//         city: city,
//         zone: zone,
//         woreda: woreda,
//         kebele: kebele,
//       );
//       Routes.instance
//           .pushAndRemoveUntil(widget: const HomePage(), context: context);

//       _firestore
//           .collection('sellers')
//           .doc(sellerModel.id)
//           .set(sellerModel.toJson());
//       Navigator.of(context).pop();
//       return true;
//     } on FirebaseAuthException catch (error) {
//       showMessage(error.code.toString());
//       return false;
//     }
//   }

//   void signOut() async {
//     await _auth.signOut();
//   }

//   Future<bool> changePassword(String password, BuildContext context) async {
//     try {
//       ShowLoderDialog(context);

//       _auth.currentUser!.updatePassword(password);

//       // UserCredential? userCredential = await _auth
//       //     .createUserWithEmailAndPassword(email: email, password: Password);

//       // UserModel userModel = UserModel(
//       //     id: userCredential.user!.uid, name: name, email: email, image: null);
//       // Routes.instance
//       //     .pushAndRemoveUntil(widget: const Home(), context: context);

//       // _firestore.collection('users').doc(userModel.id).set(userModel.toJson());
//       Navigator.of(context, rootNavigator: true).pop();
//       showMessage('Password changed');
//       Navigator.of(context).pop();
//       return true;
//     } on FirebaseAuthException catch (error) {
//       showMessage(error.code.toString());
//       return false;
//     }
//   }
// }
