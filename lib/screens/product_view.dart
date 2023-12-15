// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellers/constants/routes.dart';
import 'package:sellers/models/product_model.dart'; // Import your ProductModel class
import 'package:sellers/providers/app_provider.dart';
import 'package:sellers/screens/add_product.dart';
import 'package:sellers/screens/product_details.dart';
import 'package:sellers/widgets/custom_drawer.dart';

class ProductView extends StatefulWidget {
  static const String id = 'product-view';
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final int index = 0;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(('Products')),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Expanded(
              child: Container(
                alignment: Alignment.center,
                width: 80,
                height: 40,
                color: Colors.green,
                child: Text(
                  appProvider.getProducts.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: FutureBuilder<List<ProductModel>>(
        future: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No data available');
          } else {
            return Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.green),
                          showCheckboxColumn: false,
                          //columnSpacing: 0.0,
                          columns: [
                            DataColumn(
                                label: Text(
                              'Image',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text('Name',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Quantity',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Price',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Discount',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                          ],
                          rows: snapshot.data!.asMap().entries.map((entry) {
                            final int rowIndex = entry.key;
                            final ProductModel product = entry.value;
                            return DataRow(
                              color: MaterialStateColor.resolveWith((states) =>
                                  rowIndex % 2 == 0
                                      ? Colors.grey
                                          .shade300 // Zebra color for even rows
                                      : Colors.white),
                              cells: [
                                DataCell(
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image.network(
                                      product.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    width: 60,
                                    child: Text(
                                      product.name,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    width: 30,
                                    child: Text(
                                      product.quantity.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    product.price.toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 14,
                                      decoration: product.discount != 0.0
                                          ? TextDecoration.lineThrough
                                          : null,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  product.discount != 0.0
                                      ? Text(
                                          product.discount.toStringAsFixed(2),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                        )
                                      : Text(''),
                                ),
                              ],
                              onSelectChanged: (selected) {
                                Routes.instance.push(
                                  widget: ProductDetails(
                                    productModel: product,
                                    index: index,
                                  ),
                                  context: context,
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 30,
                  right: 2,
                  child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    onPressed: () {
                      Routes.instance.push(
                        widget: AddProduct(),
                        context: context,
                      );
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<List<ProductModel>> getProducts() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
        .collectionGroup('products')
        .where('sellerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    print('Number of Products: ${querySnapshot.size}');

    List<ProductModel> productList =
        querySnapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();

    print('Product List: $productList');
    return productList;
  }
}









// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sellers/constants/routes.dart';
// import 'package:sellers/models/product_model.dart'; // Import your ProductModel class
// import 'package:sellers/providers/app_provider.dart';
// import 'package:sellers/screens/add_product.dart';
// import 'package:sellers/screens/product_details.dart';
// import 'package:sellers/widgets/custom_drawer.dart';

// class ProductView extends StatefulWidget {
//   static const String id = 'product-view';
//   const ProductView({Key? key}) : super(key: key);

//   @override
//   State<ProductView> createState() => _ProductViewState();
// }

// class _ProductViewState extends State<ProductView> {
//   final int index = 0;
//   @override
//   Widget build(BuildContext context) {
//     AppProvider appProvider = Provider.of<AppProvider>(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(('Products').toUpperCase()),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: CircleAvatar(
//               radius: 18,
//               backgroundColor: Colors.green,
//               child: Text(
//                 appProvider.getProducts.length.toString(),
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//       drawer: CustomDrawer(),
//       body: FutureBuilder<List<ProductModel>>(
//         future:
//             getProducts(), // Replace with your function to fetch data from Firebase
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Text('No data available');
//           } else {
//             return Stack(
//               children: [
//                 SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       DataTable(
//                         headingRowColor: MaterialStateColor.resolveWith(
//                             (states) => Colors.green),
//                         columns: [
//                           DataColumn(
//                               label: Text(
//                             'Image',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           )),
//                           DataColumn(
//                               label: Text('Name',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold))),
//                           DataColumn(
//                               label: Text('Price',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold))),
//                           DataColumn(
//                               label: Text('Discount',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold))),
//                           DataColumn(
//                               label: Text('Quantity',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold))),
//                           DataColumn(
//                               label: Text('More',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold))),
//                         ],
//                         columnSpacing: 10,
//                         rows: snapshot.data!.asMap().entries.map((entry) {
//                           final int rowIndex = entry.key;
//                           final ProductModel product = entry.value;
//                           return DataRow(
//                             color: MaterialStateColor.resolveWith((states) =>
//                                 rowIndex % 2 == 0
//                                     ? Colors.grey
//                                         .shade300 // Zebra color for even rows
//                                     : Colors.white),
//                             cells: [
//                               DataCell(
//                                 SizedBox(
//                                   height: 30,
//                                   width: 30,
//                                   child: Image.network(
//                                     product.image,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               DataCell(
//                                 Container(
//                                   width: 60,
//                                   child: Text(
//                                     product.name,
//                                     style: TextStyle(
//                                         overflow: TextOverflow.ellipsis,
//                                         fontSize: 14,
//                                         color: Colors.black),
//                                   ),
//                                 ),
//                               ),
//                               DataCell(
//                                 Text(
//                                   product.price.toStringAsFixed(2),
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     decoration: product.discount != 0.0
//                                         ? TextDecoration.lineThrough
//                                         : null,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                               DataCell(
//                                 product.discount != 0.0
//                                     ? Text(
//                                         product.discount.toStringAsFixed(2),
//                                         style: TextStyle(
//                                             fontSize: 14, color: Colors.black),
//                                       )
//                                     : Text(''),
//                               ),
//                               DataCell(
//                                 Container(
//                                   width: 30,
//                                   child: Text(
//                                     product.quantity.toString(),
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 1,
//                                     style: TextStyle(
//                                         fontSize: 14, color: Colors.black),
//                                   ),
//                                 ),
//                               ),
//                               DataCell(
//                                 ElevatedButton(
//                                   style: ButtonStyle(
//                                     backgroundColor:
//                                         MaterialStateProperty.all(Colors.white),
//                                     side: MaterialStateProperty.all(
//                                         BorderSide(color: Colors.grey)),
//                                     shape: MaterialStateProperty.all(
//                                       RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(8.0),
//                                       ),
//                                     ),
//                                   ),
//                                   onPressed: () {
//                                     // Handle button tap
//                                     Routes.instance.push(
//                                       widget: ProductDetails(
//                                         productModel: product,
//                                         index: index,
//                                       ),
//                                       context: context,
//                                     );
//                                   },
//                                   child: FittedBox(
//                                     child: Text(
//                                       'More',
//                                       style: TextStyle(
//                                         color: Colors.green,
//                                         fontSize: 16.0,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           );
//                         }).toList(),
//                       ),
//                       SizedBox(
//                         height: 100,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 30,
//                   right: 2,
//                   child: FloatingActionButton(
//                     backgroundColor: Colors.green,
//                     onPressed: () {
//                       Routes.instance.push(
//                         widget: AddProduct(),
//                         context: context,
//                       );
//                     },
//                     child: Icon(
//                       Icons.add,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }

//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   Future<List<ProductModel>> getProducts() async {
//     QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
//         .collectionGroup('products')
//         .where('sellerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//         .get();

//     print('Number of Products: ${querySnapshot.size}');

//     List<ProductModel> productList =
//         querySnapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();

//     print('Product List: $productList');
//     return productList;
//   }
// }
