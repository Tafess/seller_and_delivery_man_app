// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellers/constants/routes.dart';
import 'package:sellers/providers/app_provider.dart';
import 'package:sellers/screens/category_view.dart';
import 'package:sellers/screens/order_list.dart';
import 'package:sellers/screens/orders_screen.dart';
import 'package:sellers/screens/product_view.dart';
import 'package:sellers/widgets/custom_drawer.dart';
import 'package:sellers/widgets/single_dash_item.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home-page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isloading = false;
  void getData() async {
    setState(() {
      isloading = true;
    });
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.callBackFunction();
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: CustomDrawer(),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Divider(),
                      GridView.count(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.only(top: 20),
                        crossAxisCount: 2,
                        children: [
                          // SingleDashItem(
                          //     onPressed: () {
                          //       Routes.instance.push(
                          //           widget: const UserViewScreen(),
                          //           context: context);
                          //     },
                          //     title: 'Users',
                          //     subtitle:
                          //         appProvider.getUserList.length.toString()),
                          SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: const CategoryViewScreen(),
                                    context: context);
                              },
                              icon: Icons.category_outlined,
                              title: 'Categories',
                              subtitle: appProvider.getCategoryList.length
                                  .toString()),
                          SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: const ProductView(),
                                    context: context);
                              },
                              icon: Icons.shop_2,
                              title: 'Products',
                              subtitle:
                                  appProvider.getProducts.length.toString()),
                          SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: const ProductView(),
                                    context: context);
                              },
                              icon: Icons.money,
                              title: 'Earnings',
                              subtitle: 'ETB ${appProvider.getTotalEarnings}'),
                          SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: OrdersScreen(), context: context);
                              },
                              icon: Icons.circle_outlined,
                              title: 'Orders',
                              subtitle: appProvider.getAllOrderList.length
                                  .toString()),
                          SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: OrderListView(title: 'Pending'),
                                    context: context);
                              },
                              icon: Icons.pending_actions,
                              title: 'Pending orders',
                              subtitle: appProvider.getPendingOrderList.length
                                  .toString()),
                          SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: OrderListView(
                                      title: 'Completed',
                                    ),
                                    context: context);
                              },
                              icon: Icons.fullscreen,
                              title: 'Completed orders',
                              subtitle: appProvider.getCompletedOrder.length
                                  .toString()),
                          // SingleDashItem(
                          //     onPressed: () {
                          //       Routes.instance.push(
                          //           widget: OrderListView(title: 'Canceled'),
                          //           context: context);
                          //     },
                          //     icon: Icons.cancel_outlined,
                          //     title: 'Canceled orders',
                          //     subtitle: appProvider.getCanceledOrderList.length
                          //         .toString()),
                          SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: OrderListView(title: 'Delivery'),
                                    context: context);
                              },
                              icon: Icons.delivery_dining_rounded,
                              title: 'Delvery orders',
                              subtitle: appProvider.getDeliveryOrderList.length
                                  .toString()),
                          Spacer(),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}












// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sellers/constants/primary_button.dart';
// import 'package:sellers/constants/routes.dart';
// import 'package:sellers/constants/top_titles.dart';
// import 'package:sellers/controllers/firebase_firestore_helper.dart';
// import 'package:sellers/models/catagory_model.dart';
// import 'package:sellers/models/product_model.dart';
// import 'package:sellers/providers/app_provider.dart';
// import 'package:sellers/screens/category_view.dart';
// import 'package:sellers/screens/check_out.dart';
// import 'package:sellers/screens/product_details.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List<CategoryModel> categoriesList = [];
//   List<ProductModel> productModelList = [];
//   bool isLoding = false;

//   @override
//   void initState() {
//     AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
//     appProvider.getUserInfoFirebase();
//     getCategoyList();
//     // getBestProducts();
//     super.initState();
//   }

//   void getCategoyList() async {
//     setState(() {
//       isLoding = true;
//     });
//     FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
//     categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
//     productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();
//     productModelList.shuffle();
//     if (mounted) {
//       setState(() {
//         isLoding = false;
//       });
//     }
//   }

//   TextEditingController search = TextEditingController();
//   List<ProductModel> searchList = [];
//   void searchProduct(String value) {
//     searchList = productModelList
//         .where((element) =>
//             element.name.toLowerCase().contains(value.toLowerCase()))
//         .toList();
//     setState(() {});
//   }

//   void getBestProducts() async {
//     setState(() {
//       isLoding = true;
//     });

//     productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();

//     setState(() {
//       isLoding = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const TopTitles(title: '........', subtitle: ''),
//       ),
//       body: isLoding
//           ? Center(
//               child: Container(
//                 height: 100,
//                 width: 100,
//                 alignment: Alignment.center,
//                 child: const CircularProgressIndicator(),
//               ),
//             )
//           : SingleChildScrollView(
//               child: Center(
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8),
//                                 child: TextFormField(
//                                   controller: search,
//                                   onChanged: (String value) {
//                                     searchProduct(value);
//                                   },
//                                   decoration: const InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10.0)),
//                                     ),
//                                     hintStyle: TextStyle(color: Colors.grey),
//                                     hintText: 'Search products ...',
//                                     prefixIcon: Icon(Icons.search),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10.0,
//                                 width: double.infinity,
//                                 child: Divider(
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               const Text(
//                                 'Categories',
//                                 style: TextStyle(
//                                   fontSize: 20.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.blue,
//                                 ),
//                               ),
//                               categoriesList.isEmpty
//                                   ? const Center(
//                                       child: Text('Category is Empty'),
//                                     )
//                                   : SingleChildScrollView(
//                                       scrollDirection: Axis.horizontal,
//                                       child: Row(
//                                         children: categoriesList
//                                             .map(
//                                               (category) => Padding(
//                                                 padding: const EdgeInsets.only(
//                                                   left: 8.0,
//                                                 ),
//                                                 child: Column(
//                                                   children: [
//                                                     CupertinoButton(
//                                                       padding: EdgeInsets.zero,
//                                                       onPressed: () {
//                                                         Routes.instance.push(
//                                                             widget: CategoryView(
//                                                                 categoryModel:
//                                                                     category),
//                                                             context: context);
//                                                       },
//                                                       child: Card(
//                                                         color: Colors.white,
//                                                         elevation: 0,
//                                                         shape:
//                                                             RoundedRectangleBorder(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(10),
//                                                         ),
//                                                         child: SizedBox(
//                                                           height: 50,
//                                                           width: 50,
//                                                           child: ClipOval(
//                                                             child:
//                                                                 Image.network(
//                                                               category.image,
//                                                               fit: BoxFit.cover,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Text(
//                                                       category
//                                                           .name, // Category name
//                                                       style: const TextStyle(
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             )
//                                             .toList(),
//                                       ),
//                                     ),
//                               const Divider(),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               const Text(
//                                 'Products',
//                                 style: TextStyle(
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.blue),
//                               ),
//                               isSearched()
//                                   ? const Center(
//                                       child: Text('No such product found'),
//                                     )
//                                   : searchList.isNotEmpty
//                                       ? Padding(
//                                           padding: const EdgeInsets.all(12.0),
//                                           child: GridView.builder(
//                                               padding: const EdgeInsets.only(
//                                                   bottom: 20),
//                                               shrinkWrap: true,
//                                               primary: false,
//                                               itemCount: searchList.length,
//                                               gridDelegate:
//                                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                                       childAspectRatio: 0.8,
//                                                       mainAxisSpacing: 20,
//                                                       crossAxisSpacing: 20,
//                                                       crossAxisCount: 2),
//                                               itemBuilder: (ctx, index) {
//                                                 ProductModel singleProduct =
//                                                     searchList[index];
//                                                 return Container(
//                                                   decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             20),
//                                                     color: Colors.white,
//                                                   ),
//                                                   child: InkWell(
//                                                     onTap: () {
//                                                       Routes.instance.push(
//                                                           widget: ProductDetails(
//                                                               singleProduct:
//                                                                   singleProduct),
//                                                           context: context);
//                                                     },
//                                                     child: Column(children: [
//                                                       SizedBox(
//                                                         height: 50,
//                                                         width: double.infinity,
//                                                         child: ClipOval(
//                                                           child: Image.network(
//                                                             singleProduct.image,
//                                                             fit: BoxFit.cover,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       const SizedBox(
//                                                         height: 12,
//                                                       ),
//                                                       Text(
//                                                         singleProduct.name,
//                                                         style: const TextStyle(
//                                                             fontSize: 18,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .bold),
//                                                       ),
//                                                       Text(
//                                                         'ETB ${singleProduct.price.toStringAsFixed(2)}',
//                                                         style: const TextStyle(
//                                                             fontSize: 18,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .bold),
//                                                       ),
//                                                       const SizedBox(
//                                                         height: 6.0,
//                                                       ),
//                                                       SizedBox(
//                                                         height: 40,
//                                                         width: 100,
//                                                         child: PrimaryButton(
//                                                           onPressed: () {
//                                                             Routes.instance.push(
//                                                                 widget: ProductDetails(
//                                                                     singleProduct:
//                                                                         singleProduct),
//                                                                 context:
//                                                                     context);
//                                                             // Routes.instance.push(
//                                                             //     widget:
//                                                             //         ProductDetails,
//                                                             //     context: context);
//                                                           },
//                                                           title: 'Buy',
//                                                         ),
//                                                       ), // onPressed: () {}, child: Text('Buy'))
//                                                     ]),
//                                                   ),
//                                                 );
//                                               }),
//                                         )
//                                       : productModelList.isEmpty
//                                           ? const Center(
//                                               child: Text(
//                                                   'Best product is Empity'),
//                                             )
//                                           : Padding(
//                                               padding:
//                                                   const EdgeInsets.all(12.0),
//                                               child: GridView.builder(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           bottom: 20),
//                                                   shrinkWrap: true,
//                                                   primary: false,
//                                                   itemCount:
//                                                       productModelList.length,
//                                                   gridDelegate:
//                                                       const SliverGridDelegateWithFixedCrossAxisCount(
//                                                           childAspectRatio: 0.8,
//                                                           mainAxisSpacing: 20,
//                                                           crossAxisSpacing: 20,
//                                                           crossAxisCount: 2),
//                                                   itemBuilder: (ctx, index) {
//                                                     ProductModel singleProduct =
//                                                         productModelList[index];
//                                                     return Container(
//                                                       decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(20),
//                                                         color: Colors.white,
//                                                       ),
//                                                       child: InkWell(
//                                                         onTap: () {
//                                                           Routes.instance.push(
//                                                               widget: ProductDetails(
//                                                                   singleProduct:
//                                                                       singleProduct),
//                                                               context: context);
//                                                         },
//                                                         child:
//                                                             Column(children: [
//                                                           SizedBox(
//                                                             height: 50,
//                                                             width: 50,
//                                                             child: ClipOval(
//                                                               child:
//                                                                   Image.network(
//                                                                 singleProduct
//                                                                     .image,
//                                                                 fit: BoxFit
//                                                                     .cover,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           const SizedBox(
//                                                             height: 12,
//                                                           ),
//                                                           Text(
//                                                             singleProduct.name,
//                                                             style: const TextStyle(
//                                                                 fontSize: 18,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold),
//                                                           ),
//                                                           Text(
//                                                             'ETB ${singleProduct.price.toStringAsFixed(2)}',
//                                                             style: const TextStyle(
//                                                                 fontSize: 18,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold),
//                                                           ),
//                                                           const SizedBox(
//                                                             height: 6.0,
//                                                           ),
//                                                           SizedBox(
//                                                             height: 40,
//                                                             width: 100,
//                                                             child:
//                                                                 PrimaryButton(
//                                                               onPressed: () {
//                                                                 Routes.instance.push(
//                                                                     widget: ProductDetails(
//                                                                         singleProduct:
//                                                                             singleProduct),
//                                                                     context:
//                                                                         context);
//                                                                 Routes.instance.push(
//                                                                     widget: CheckOutScreen(
//                                                                         singleProduct:
//                                                                             singleProduct),
//                                                                     context:
//                                                                         context);
//                                                               },
//                                                               title: 'Buy',
//                                                             ),
//                                                           ), // onPressed: () {}, child: Text('Buy'))
//                                                         ]),
//                                                       ),
//                                                     );
//                                                   }),
//                                             ),
//                             ]),
//                       ),
//                     ]),
//               ),
//             ),
//     );
//   }

//   bool isSearched() {
//     if (search.text.isNotEmpty && searchList.isEmpty) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }
