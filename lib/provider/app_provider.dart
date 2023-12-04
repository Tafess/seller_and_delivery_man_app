// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sellers/constants/constants.dart';
import 'package:sellers/controllers/firebase_firestore_helper.dart';
import 'package:sellers/models/catagory_model.dart';
import 'package:sellers/models/order_model.dart';
import 'package:sellers/models/product_model.dart';
import 'package:sellers/models/seller_model.dart';
import 'package:sellers/screens/outp_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider with ChangeNotifier {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // bool _isSignedIn = false;
  // bool get isSignedIn => _isSignedIn;
  // bool _isLoading = false;
  // bool get isLoading => _isLoading;
  // String? _userId;
  // String get userId => _userId!;

  // AppProvider() {
  //   checkSignIn();
  // }
  // void checkSignIn() async {
  //   final SharedPreferences sign = await SharedPreferences.getInstance();
  //   _isSignedIn = sign.getBool('is_signedIn') ?? false;
  //   notifyListeners();
  // }

  // void signInWithPhone(BuildContext context, String phoneNumber) async {
  //   try {
  //     await _firebaseAuth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       verificationCompleted: (
  //         PhoneAuthCredential phoneAuthCredntial,
  //       ) async {
  //         await _firebaseAuth.signInWithCredential(phoneAuthCredntial);
  //       },
  //       verificationFailed: (error) {
  //         throw Exception(error.message);
  //       },
  //       codeSent: (VerificationId, forceResendingToken) {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute<void>(
  //             builder: (BuildContext context) => AutpScreen(
  //               VerificationId: VerificationId,
  //             ),
  //           ),
  //         );
  //       },
  //       codeAutoRetrievalTimeout: (verificationId) {},
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     showMessage(e.toString());
  //   }
  // }

  // void verifyOtp(
  //     {required String verificationId,
  //     required String userOtp,
  //     required Function onSuccess}) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: verificationId, smsCode: userOtp);
  //     User user = (await _firebaseAuth.signInWithCredential(credential)).user!;

  //     if (user != null) {
  //       _userId = user.uid;
  //       onSuccess();
  //     }
  //     _isLoading = false;
  //     notifyListeners();
  //   } on FirebaseAuthException catch (e) {
  //     showMessage(e.toString());
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<bool> checkExistingUser() async {
  //   DocumentSnapshot snapshot =
  //       await _firebaseFirestore.collection('sellers').doc(_userId).get();
  //   if (snapshot.exists) {
  //     print('User exist');
  //     return true;
  //   } else {
  //     print('New User');
  //     return false;
  //   }
  // }

  ///////////////////////////////

  void getSellerInfoFirebase() async {
    _sellerModel =
        await FirebaseFirestoreHelper.instance.getSellerInformation();
    notifyListeners();
  }

  SellerModel? _sellerModel;
  List<SellerModel> _userList = [];
  List<CategoryModel> _categoryList = [];
  List<ProductModel> _productlist = [];
  List<OrderModel> _completedOrders = [];
  List<OrderModel> _pendingOrders = [];
  List<OrderModel> _canceledOrders = [];
  List<OrderModel> _deliveryOrders = [];

  double _totalEarning = 0.0;

  Future<void> getUserListFunction() async {
    _categoryList = await FirebaseFirestoreHelper.instance.getcategories();
    notifyListeners();
  }

  Future<void> getCategoryListFunction() async {
    _userList = await FirebaseFirestoreHelper.instance.getUserList();
    notifyListeners();
  }

  Future<void> getCompletedOrderList() async {
    _completedOrders =
        await FirebaseFirestoreHelper.instance.getCompletedOrderList();
    for (var element in _completedOrders) {
      _totalEarning += element.totalprice;
    }
    notifyListeners();
  }

  Future<void> getPendingOrders() async {
    _pendingOrders = await FirebaseFirestoreHelper.instance.getPendingOrders();
    notifyListeners();
  }

  Future<void> getCanceledOrders() async {
    _canceledOrders = await FirebaseFirestoreHelper.instance.getCancelOrders();
    notifyListeners();
  }

  Future<void> getDeliveryOrders() async {
    _deliveryOrders =
        await FirebaseFirestoreHelper.instance.getDeliveryOrders();
    notifyListeners();
  }

  Future<void> deleteUserFromFirebase(SellerModel SellerModel) async {
    notifyListeners();
    String value =
        await FirebaseFirestoreHelper.instance.deleteSingleUser(SellerModel.id);

    if (value == 'Successfully deleted') {
      _userList.remove(SellerModel);
      showMessage('User deleted successfully');
    }
    notifyListeners();
  }

  List<SellerModel> get getUserList => _userList;
  double get getTotalEarnings => _totalEarning;
  List<CategoryModel> get getCategoryList => _categoryList;
  List<ProductModel> get getProducts => _productlist;
  List<OrderModel> get getCompletedOrder => _completedOrders;
  List<OrderModel> get getPendingOrderList => _pendingOrders;
  List<OrderModel> get getCanceledOrderList => _canceledOrders;
  List<OrderModel> get getDeliveryOrderList => _deliveryOrders;
  SellerModel get getSellerInformation => _sellerModel!;

  Future<void> callBackFunction() async {
    await getUserListFunction();
    await getCategoryListFunction();
    await getProduct();
    await getCompletedOrderList();
    await getPendingOrders();
    await getCanceledOrders();
    await getDeliveryOrders();
    //await getSellerInfoFirebase();
  }

  void updateUserList(int index, SellerModel sellerModel) async {
    await FirebaseFirestoreHelper.instance.updateUser(sellerModel);

    // int index=_userList.indexOf(SellerModel);
    _userList[index] = sellerModel;
    notifyListeners();
  }

/////////     category

  Future<void> deleteCategoryFromFirebase(CategoryModel categoryModel) async {
    notifyListeners();
    String value = await FirebaseFirestoreHelper.instance
        .deleteSingleCategory(categoryModel.id);

    if (value == 'Successfully deleted') {
      _categoryList.remove(categoryModel);
      showMessage('Category deleted successfully');
    }
    notifyListeners();
  }

  void updateCategoryList(int index, CategoryModel categoryModel) async {
    await FirebaseFirestoreHelper.instance.updateSingleCategory(categoryModel);

    _categoryList[index] = categoryModel;
    notifyListeners();
  }

  void addCategory(File image, String name) async {
    CategoryModel categoryModel =
        await FirebaseFirestoreHelper.instance.addSingleCategory(image, name);

    _categoryList.add(categoryModel);
    notifyListeners();
  }

  Future<void> getProduct() async {
    _productlist = await FirebaseFirestoreHelper.instance.getProducts();
    notifyListeners();
  }

  Future<void> deleteProductFromFirebase(ProductModel productModel) async {
    notifyListeners();
    String value = await FirebaseFirestoreHelper.instance
        .deleteProduct(productModel.categoryId, productModel.id);

    if (value == 'Successfully deleted') {
      _productlist.remove(productModel);
      showMessage('Product deleted successfully');
    }
    notifyListeners();
  }

  Future<void> updateProductList(int index, ProductModel productModel) async {
    await FirebaseFirestoreHelper.instance.updateSingleProduct(productModel);
    _productlist[index] = productModel;
    notifyListeners();
  }

  void addProduct(
    File image,
    String name,

    //  String id,
    String description,
    String categoryId,
    String price,
    double discount,
    int quantity,
    double size,
    String measurement,
    // String status,
    // bool isFavorite,
  ) async {
    ProductModel productModel = await FirebaseFirestoreHelper.instance
        .addSingleProduct(image, name, categoryId, description, price, discount,
            quantity, size, measurement);

    _productlist.add(productModel);
    notifyListeners();
  }

  /////////// pending  Orders          ///////
  ///
  ///
  ///

  void updatePendingOrder(OrderModel order) {
    _deliveryOrders.add(order);
    _pendingOrders.remove(order);
    notifyListeners();
    showMessage('order sent to Delivery');
  }

  void updateCancelPendingOrder(OrderModel order) {
    _canceledOrders.add(order);
    _pendingOrders.remove(order);
    notifyListeners();
    showMessage('Order canceled from pending');
  }

  void updateCanceleDeliveryOrder(OrderModel order) {
    _canceledOrders.add(order);
    _deliveryOrders.remove(order);
    notifyListeners();
    showMessage('Order canceled from delivery');
  }
}

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$




// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:sellers/controllers/firebase_firestore_helper.dart';
// import 'package:sellers/models/catagory_model.dart';
// import 'package:sellers/models/order_model.dart';
// import 'package:sellers/models/product_model.dart';
// import 'package:sellers/models/user_model.dart';

// class AppProvider with ChangeNotifier {
//   final BehaviorSubject<List<SellerModel>> _userListController =
//       BehaviorSubject<List<UserModel>>();
//   final BehaviorSubject<List<CategoryModel>> _categoryListController =
//       BehaviorSubject<List<CategoryModel>>();
//   final BehaviorSubject<List<ProductModel>> _productListController =
//       BehaviorSubject<List<ProductModel>>();
//   final BehaviorSubject<List<OrderModel>> _completedOrdersController =
//       BehaviorSubject<List<OrderModel>>();
//   final BehaviorSubject<List<OrderModel>> _pendingOrdersController =
//       BehaviorSubject<List<OrderModel>>();
//   final BehaviorSubject<List<OrderModel>> _canceledOrdersController =
//       BehaviorSubject<List<OrderModel>>();
//   final BehaviorSubject<List<OrderModel>> _deliveryOrdersController =
//       BehaviorSubject<List<OrderModel>>();
//   final BehaviorSubject<double> _totalEarningController =
//       BehaviorSubject<double>();

//   Stream<List<UserModel>> get userListStream => _userListController.stream;
//   Stream<List<CategoryModel>> get categoryListStream =>
//       _categoryListController.stream;
//   Stream<List<ProductModel>> get productListStream =>
//       _productListController.stream;
//   Stream<List<OrderModel>> get completedOrdersStream =>
//       _completedOrdersController.stream;
//   Stream<List<OrderModel>> get pendingOrdersStream =>
//       _pendingOrdersController.stream;
//   Stream<List<OrderModel>> get canceledOrdersStream =>
//       _canceledOrdersController.stream;
//   Stream<List<OrderModel>> get deliveryOrdersStream =>
//       _deliveryOrdersController.stream;
//   Stream<double> get totalEarningStream => _totalEarningController.stream;

//   List<UserModel> _userList = [];
//   List<CategoryModel> _categoryList = [];
//   List<ProductModel> _productlist = [];
//   List<OrderModel> _completedOrders = [];
//   List<OrderModel> _pendingOrders = [];
//   List<OrderModel> _canceledOrders = [];
//   List<OrderModel> _deliveryOrders = [];
//   double _totalEarning = 0.0;

//   Future<void> getUserListFunction() async {
//     _userListController.add(await FirebaseFirestoreHelper.instance.getUserList());
//   }

//   Future<void> getCategoryListFunction() async {
//     _categoryListController
//         .add(await FirebaseFirestoreHelper.instance.getcategories());
//   }

//   Future<void> getCompletedOrderList() async {
//     List<OrderModel> completedOrders =
//         await FirebaseFirestoreHelper.instance.getCompletedOrderList();
//     _completedOrdersController.add(completedOrders);
//     _totalEarningController.add(
//         completedOrders.map((order) => order.totalprice).fold(0.0, (a, b) => a + b));
//   }

//   Future<void> getPendingOrders() async {
//     _pendingOrdersController
//         .add(await FirebaseFirestoreHelper.instance.getPendingOrders());
//   }

//   Future<void> getCanceledOrders() async {
//     _canceledOrdersController
//         .add(await FirebaseFirestoreHelper.instance.getCancelOrders());
//   }

//   Future<void> getDeliveryOrders() async {
//     _deliveryOrdersController
//         .add(await FirebaseFirestoreHelper.instance.getDeliveryOrders());
//   }

//   // ... (existing methods)

//   AppProvider() {
//     getUserListFunction();
//     getCategoryListFunction();
//     getProduct();
//     getCompletedOrderList();
//     getPendingOrders();
//     getCanceledOrders();
//     getDeliveryOrders();
//   }

//   void dispose() {
//     _userListController.close();
//     _categoryListController.close();
//     _productListController.close();
//     _completedOrdersController.close();
//     _pendingOrdersController.close();
//     _canceledOrdersController.close();
//     _deliveryOrdersController.close();
//     _totalEarningController.close();
//     super.dispose();
//   }
// }
