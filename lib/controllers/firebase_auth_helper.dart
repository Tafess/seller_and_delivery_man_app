// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sellers/constants/constants.dart';
import 'package:sellers/constants/routes.dart';
import 'package:sellers/models/seller_model.dart';
import 'package:sellers/screens/home.dart';

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
    String phoneNumber,
    String email,
    String password,
    String country,
    String region,
    String city,
    String zone,
    String woreda,
    String kebele,
    BuildContext context,
  ) async {
    try {
      ShowLoderDialog(context);

      UserCredential? userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      SellerModel sellerModel = SellerModel(
        id: userCredential.user!.uid,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        email: email,
        country: country,
        region: region,
        city: city,
        zone: zone,
        woreda: woreda,
        kebele: kebele,
        image: null,
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
