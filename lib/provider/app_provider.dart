// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sellers/constants/constants.dart';
import 'package:sellers/controllers/firebase_firestore_helper.dart';
import 'package:sellers/models/catagory_model.dart';
import 'package:sellers/models/order_model.dart';
import 'package:sellers/models/product_model.dart';
import 'package:sellers/models/user_model.dart';

class AppProvider with ChangeNotifier {
  List<UserModel> _userList = [];
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

  Future<void> deleteUserFromFirebase(UserModel userModel) async {
    notifyListeners();
    String value =
        await FirebaseFirestoreHelper.instance.deleteSingleUser(userModel.id);

    if (value == 'Successfully deleted') {
      _userList.remove(userModel);
      showMessage('User deleted successfully');
    }
    notifyListeners();
  }

  List<UserModel> get getUserList => _userList;
  double get getTotalEarnings => _totalEarning;
  List<CategoryModel> get getCategoryList => _categoryList;
  List<ProductModel> get getProducts => _productlist;
  List<OrderModel> get getCompletedOrder => _completedOrders;
  List<OrderModel> get getPendingOrderList => _pendingOrders;
  List<OrderModel> get getCanceledOrderList => _canceledOrders;
  List<OrderModel> get getDeliveryOrderList => _deliveryOrders;

  Future<void> callBackFunction() async {
    await getUserListFunction();
    await getCategoryListFunction();
    await getProduct();
    await getCompletedOrderList();
    await getPendingOrders();
    await getCanceledOrders();
    await getDeliveryOrders();
  }

  void updateUserList(int index, UserModel userModel) async {
    await FirebaseFirestoreHelper.instance.updateUser(userModel);

    // int index=_userList.indexOf(userModel);
    _userList[index] = userModel;
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
        .addSingleProduct(image, name, categoryId, description, price,
            discount , quantity , size , measurement);

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
//   final BehaviorSubject<List<UserModel>> _userListController =
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
