// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellers/constants/top_titles.dart';
import 'package:sellers/models/catagory_model.dart';
import 'package:sellers/providers/app_provider.dart';
import 'package:sellers/widgets/single_category_item.dart';

class CategoryViewScreen extends StatelessWidget {
  static const String id = 'category-view-screen';
  const CategoryViewScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      // appBar: AppBar(
      //   title: const Text('categories'),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Routes.instance.push(widget: AddCategory(), context: context);
      //       },
      //       icon: const Icon(Icons.add_circle),
      //     )
      //   ],
      // ),

      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          AppProvider appProvider = Provider.of<AppProvider>(context);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopTitles(
                    title: 'categories',
                    subtitle: appProvider.getCategoryList.length.toString()),
                const SizedBox(height: 20),
                GridView.builder(
                  padding: EdgeInsets.all(12),
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // Disable GridView scrolling
                  itemCount: value.getCategoryList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    CategoryModel categoryModel = value.getCategoryList[index];
                    return SingleCategoryItem(
                      singleCategory: categoryModel,
                      index: index,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}










// import 'package:flutter/material.dart';
// import 'package:sellers/constants/primary_button.dart';
// import 'package:sellers/constants/routes.dart';
// import 'package:sellers/controllers/firebase_firestore_helper.dart';
// import 'package:sellers/models/catagory_model.dart';
// import 'package:sellers/models/product_model.dart';
// import 'package:sellers/screens/product_details.dart';

// class CategoryView extends StatefulWidget {
//   final CategoryModel categoryModel;
//   const CategoryView({super.key, required this.categoryModel});

//   @override
//   State<CategoryView> createState() => _CategoryViewState();
// }

// class _CategoryViewState extends State<CategoryView> {
//   List<ProductModel> productModelList = [];
//   bool isLoding = false;

//   get categoriesList => null;
//   void getCategoyList() async {
//     setState(() {
//       isLoding = true;
//     });
//     productModelList = await FirebaseFirestoreHelper.instance
//         .getCategoryViewProduct(widget.categoryModel.id);
//     productModelList.shuffle();
//     setState(() {
//       isLoding = false;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getCategoyList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.categoryModel.name)),
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
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   productModelList.isEmpty
//                       ? const Center(
//                           child: Text('Best product is Empity'),
//                         )
//                       : Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: GridView.builder(
//                             padding: EdgeInsets.zero,
//                             shrinkWrap: true,
//                             primary: false,
//                             itemCount: productModelList.length,
//                             gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                                     childAspectRatio: 0.6,
//                                     mainAxisSpacing: 20,
//                                     crossAxisSpacing: 20,
//                                     crossAxisCount: 2),
//                             itemBuilder: (ctx, index) {
//                               ProductModel singleProduct =
//                                   productModelList[index];
//                               return SingleChildScrollView(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     color: Colors.white,
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 10.0),
//                                         child: InkWell(
//                                           onTap: () {
//                                             Routes.instance.push(
//                                                 widget: ProductDetails(
//                                                     singleProduct:
//                                                         singleProduct),
//                                                 context: context);
//                                           },
//                                           child: SizedBox(
//                                             height: 100,
//                                             width: double.infinity,
//                                             child: ClipOval(
//                                               child: Image.network(
//                                                 singleProduct.image,
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 12,
//                                       ),
//                                       Text(
//                                         singleProduct.name,
//                                         style: const TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       Text(
//                                         'ETB:  ${singleProduct.price.toStringAsFixed(2)}',
//                                         style: const TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       const SizedBox(
//                                         height: 6.0,
//                                       ),
//                                       SizedBox(
//                                         height: 40,
//                                         width: 100,
//                                         child: PrimaryButton(
//                                           onPressed: () {
//                                             Routes.instance.push(
//                                                 widget: ProductDetails(
//                                                     singleProduct:
//                                                         singleProduct),
//                                                 context: context);
//                                           },
//                                           title: 'Buy',
//                                         ),
//                                       ), // onPressed: () {}, child: Text('Buy'))
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
