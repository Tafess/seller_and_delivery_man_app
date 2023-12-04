// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sellers/constants/constants.dart';
import 'package:sellers/controllers/firebase_storage_helper.dart';
import 'package:sellers/models/catagory_model.dart';
import 'package:sellers/models/order_model.dart';
import 'package:sellers/models/product_model.dart';
import 'package:sellers/models/seller_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  /////////////////////////////////////////////////////
  Future<SellerModel> getSellerInformation() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection('sellers')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();
      return SellerModel.fromJson(querySnapshot.data()!);
    } catch (e) {
      print('Error retrieving seller information: $e');
      // Handle the error or return a default SellerModel
      return SellerModel(
        approved: false,
        id: FirebaseAuth.instance.currentUser!.uid,
        firstName: 'Tafesse',
        middleName: '',
        lastName: '',
        email: '',
        phoneNumber: '',
        country: '',
        region: '',
        city: '',
        zone: '',
        woreda: '',
        kebele: '',
        idCard: '',
        profilePhoto: '',
      );
    }
  }

  Future<List<SellerModel>> getUserList() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collection('users').get();
    return querySnapshot.docs
        .map((e) => SellerModel.fromJson(e.data()))
        .toList();
  }

  Future<List<CategoryModel>> getcategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection('categories').get();
      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();
      return categoriesList; // Return the mapped categoriesList
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<String> deleteSingleUser(String id) async {
    try {
      _firebaseFirestore.collection('users').doc(id).delete();
      return 'Successfully deleted';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateUser(SellerModel sellerModel) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(sellerModel.id)
          .update(sellerModel.toJson());
    } catch (e) {}
  }

  Future<String> deleteSingleCategory(String id) async {
    try {
      await _firebaseFirestore.collection('categories').doc(id).delete();

      //  await Future.delayed(const Duration(seconds: 3), () {});
      return 'Successfully deleted';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateSingleCategory(CategoryModel categoryModel) async {
    try {
      await _firebaseFirestore
          .collection('categories')
          .doc(categoryModel.id)
          .update(categoryModel.toJson());
    } catch (e) {}
  }

  Future<CategoryModel> addSingleCategory(File image, String name) async {
    DocumentReference<Map<String, dynamic>> reference =
        _firebaseFirestore.collection('categories').doc();
    String imageUrl = await FirebaseStorageHelper.instance
        .uploadUserImage(reference.id, image);
    CategoryModel addCategory =
        CategoryModel(image: imageUrl, id: reference.id, name: name);
    await reference.set(addCategory.toJson());
    return addCategory;
  }

  ///////// products /////////////
  ///
  Future<List<ProductModel>> getProducts() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collectionGroup('products').get();
    List<ProductModel> productList =
        querySnapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    return productList;
  }

  Future<String> deleteProduct(String categoryId, String productId) async {
    try {
      await _firebaseFirestore
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .doc(productId)
          .delete();

      await Future.delayed(const Duration(seconds: 1), () {});
      return 'Successfully deleted';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateSingleProduct(ProductModel productModel) async {
    DocumentReference productRef = _firebaseFirestore
        .collection('categories')
        .doc(productModel.categoryId) // Use categoryId as the document ID
        .collection('products')
        .doc(productModel.id); // Use productId as the document ID

    //DocumentSnapshot productSnapshot = await productRef.get();

    //  if (productSnapshot.exists) {
    await productRef.update(productModel.toJson());
    // }
  }

  Future<ProductModel> addSingleProduct(
    File image,
    String name,
    String categoryId,
    // String id,
    String description,
    String price,
    double discount,
    int quantity,
    double size,
    String measurement,
  ) async {
    DocumentReference<Map<String, dynamic>> reference = _firebaseFirestore
        .collection('categories')
        .doc(categoryId)
        .collection('products')
        .doc();

    ///////////////////////////

    DocumentReference admin =
        _firebaseFirestore.collection('adminProducts').doc(reference.id);
    // String sellerId = FirebaseAuth.instance.currentUser!.uid;

    admin.set({
      'productId': admin.id,
      'sellerId': FirebaseAuth.instance.currentUser!.uid,
    });
    String imageUrl = await FirebaseStorageHelper.instance
        .uploadUserImage(reference.id, image);
    ProductModel addProduct = ProductModel(
      image: imageUrl,
      id: reference.id,
      name: name,
      description: description,
      categoryId: categoryId,
      price: double.parse(price),
      discount: double.parse(price),
      quantity: 1,
      size: 0,
      measurement: measurement,
      status: 'pending',
      isFavorite: false,
      disabled: false,
      productId: reference.id,
      sellerId: "sellerId",
    );
    await reference.set(addProduct.toJson());
    return addProduct;
  }

  Future<List<OrderModel>> getCompletedOrderList() async {
    QuerySnapshot<Map<String, dynamic>> completedOrders =
        await _firebaseFirestore
            .collection('orders')
            .where('status', isEqualTo: 'completed')
            // .where('status', isEqualTo: 'completed')
            .get();

    List<OrderModel> completedOrderList =
        completedOrders.docs.map((e) => OrderModel.fromJson(e.data())).toList();
    return completedOrderList;
  }

  Future<List<OrderModel>> getPendingOrders() async {
    QuerySnapshot<Map<String, dynamic>> pendingOrders = await _firebaseFirestore
        .collection('orders')
        .where('status', isEqualTo: 'pending')
        // .where('status', isEqualTo: 'completed')
        .get();

    List<OrderModel> pendingOrderList =
        pendingOrders.docs.map((e) => OrderModel.fromJson(e.data())).toList();
    return pendingOrderList;
  }

  Future<List<OrderModel>> getCancelOrders() async {
    QuerySnapshot<Map<String, dynamic>> canceledOrders =
        await _firebaseFirestore
            .collection('orders')
            .where('status', isEqualTo: 'canceled')
            .get();

    List<OrderModel> canceledOrderList =
        canceledOrders.docs.map((e) => OrderModel.fromJson(e.data())).toList();
    return canceledOrderList;
  }

  Future<List<OrderModel>> getDeliveryOrders() async {
    QuerySnapshot<Map<String, dynamic>> deliveryOrders =
        await _firebaseFirestore
            .collection('orders')
            .where('status', isEqualTo: 'delivery')
            .get();

    List<OrderModel> getDeliveryOrders = deliveryOrders.docs
        .map(
          (e) => OrderModel.fromJson(e.data()),
        )
        .toList();
    return getDeliveryOrders;
  }

  Future<void> updateOrder(OrderModel orderModel, String status) async {
    try {
      DocumentSnapshot orderSnapshot = await _firebaseFirestore
          .collection('orders')
          .doc(orderModel.orderId)
          .get();

      if (orderSnapshot.exists) {
        String userIdFromDatabase = orderSnapshot['userId'];

        // print('userIdFromDatabase: $userIdFromDatabase');

        await _firebaseFirestore
            .collection('userOrders')
            .doc(userIdFromDatabase)
            .collection('orders')
            .doc(orderModel.orderId)
            .update({'status': status});

        await _firebaseFirestore
            .collection('orders')
            .doc(orderModel.orderId)
            .update({'status': status});
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error updating order: $e');
    }
  }
}





















///
///$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
///
///
///




// // ignore_for_file: use_build_context_synchronously

// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// // Import the RxDart library
// import 'package:sellers/constants/constants.dart';
// import 'package:sellers/controllers/firebase_storage_helper.dart';
// import 'package:sellers/models/catagory_model.dart';
// import 'package:sellers/models/order_model.dart';
// import 'package:sellers/models/product_model.dart';
// import 'package:sellers/models/user_model.dart';

// class FirebaseFirestoreHelper {
//   static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   /////////////////////////////////////////////////////
//   Stream<List<UserModel>> getUserList() {
//     return _firebaseFirestore.collection('users').snapshots().map(
//       (QuerySnapshot<Map<String, dynamic>> querySnapshot) {
//         return querySnapshot.docs.map(
//           (QueryDocumentSnapshot<Map<String, dynamic>> doc) {
//             return UserModel.fromJson(doc.data()!);
//           },
//         ).toList();
//       },
//     );
//   }

//   Stream<List<CategoryModel>> getCategories() {
//     return _firebaseFirestore.collection('categories').snapshots().map(
//       (QuerySnapshot<Map<String, dynamic>> querySnapshot) {
//         return querySnapshot.docs.map(
//           (QueryDocumentSnapshot<Map<String, dynamic>> doc) {
//             return CategoryModel.fromJson(doc.data()!);
//           },
//         ).toList();
//       },
//     );
//   }

//   Stream<List<ProductModel>> getProducts(String categoryId) {
//     return _firebaseFirestore
//         .collection('categories')
//         .doc(categoryId)
//         .collection('products')
//         .snapshots()
//         .map(
//       (QuerySnapshot<Map<String, dynamic>> querySnapshot) {
//         return querySnapshot.docs.map(
//           (QueryDocumentSnapshot<Map<String, dynamic>> doc) {
//             return ProductModel.fromJson(doc.data()!);
//           },
//         ).toList();
//       },
//     );
//   }

//   Stream<List<OrderModel>> getCompletedOrderList() {
//     return _firebaseFirestore
//         .collection('orders')
//         .where('status', isEqualTo: 'completed')
//         .snapshots()
//         .map(
//       (QuerySnapshot<Map<String, dynamic>> querySnapshot) {
//         return querySnapshot.docs.map(
//           (QueryDocumentSnapshot<Map<String, dynamic>> doc) {
//             return OrderModel.fromJson(doc.data()!);
//           },
//         ).toList();
//       },
//     );
//   }

//   Stream<List<OrderModel>> getPendingOrders() {
//     return _firebaseFirestore
//         .collection('orders')
//         .where('status', isEqualTo: 'pending')
//         .snapshots()
//         .map(
//       (QuerySnapshot<Map<String, dynamic>> querySnapshot) {
//         return querySnapshot.docs.map(
//           (QueryDocumentSnapshot<Map<String, dynamic>> doc) {
//             return OrderModel.fromJson(doc.data()!);
//           },
//         ).toList();
//       },
//     );
//   }

//   Stream<List<OrderModel>> getCancelOrders() {
//     return _firebaseFirestore
//         .collection('orders')
//         .where('status', isEqualTo: 'canceled')
//         .snapshots()
//         .map(
//       (QuerySnapshot<Map<String, dynamic>> querySnapshot) {
//         return querySnapshot.docs.map(
//           (QueryDocumentSnapshot<Map<String, dynamic>> doc) {
//             return OrderModel.fromJson(doc.data()!);
//           },
//         ).toList();
//       },
//     );
//   }

//   Stream<List<OrderModel>> getDeliveryOrders() {
//     return _firebaseFirestore
//         .collection('orders')
//         .where('status', isEqualTo: 'delivery')
//         .snapshots()
//         .map(
//       (QuerySnapshot<Map<String, dynamic>> querySnapshot) {
//         return querySnapshot.docs.map(
//           (QueryDocumentSnapshot<Map<String, dynamic>> doc) {
//             return OrderModel.fromJson(doc.data()!);
//           },
//         ).toList();
//       },
//     );
//   }

//   Stream<void> updateOrder(OrderModel orderModel, String status) async* {
//     try {
//       DocumentSnapshot orderSnapshot = await _firebaseFirestore
//           .collection('orders')
//           .doc(orderModel.orderId)
//           .get();

//       if (orderSnapshot.exists) {
//         String userIdFromDatabase = orderSnapshot['userId'];

//         await _firebaseFirestore
//             .collection('userOrders')
//             .doc(userIdFromDatabase)
//             .collection('orders')
//             .doc(orderModel.orderId)
//             .update({'status': status});

//         await _firebaseFirestore
//             .collection('orders')
//             .doc(orderModel.orderId)
//             .update({'status': status});
//       } else {
//         print('Document does not exist.');
//       }
//     } catch (e) {
//       print('Error updating order: $e');
//     }
//   }
// }

