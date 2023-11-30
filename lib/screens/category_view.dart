// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellers/constants/routes.dart';
import 'package:sellers/constants/top_titles.dart';
import 'package:sellers/models/catagory_model.dart';
import 'package:sellers/provider/app_provider.dart';
import 'package:sellers/widgets/add_category.dart';
import 'package:sellers/widgets/single_category_item.dart';

class CategoryViewScreen extends StatelessWidget {
  const CategoryViewScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: const Text('categories'),
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance.push(widget: AddCategory(), context: context);
            },
            icon: const Icon(Icons.add_circle),
          )
        ],
      ),
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
