// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sellers/constants/constants.dart';
import 'package:sellers/constants/primary_button.dart';
import 'package:sellers/models/catagory_model.dart';
import 'package:sellers/providers/app_provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({
    super.key,
    required,
  });

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  TextEditingController price = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController size = TextEditingController();
  TextEditingController measurement = TextEditingController();
  CategoryModel? _selectedCategory;
  List<String> measurments = ['Kilogram', 'Litter'];
  String? _selectedUnit;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(title: const Text('Product edit')),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          children: [
            image == null
                ? CupertinoButton(
                    onPressed: () {
                      takePicture();
                    },
                    child: const CircleAvatar(
                      radius: 55,
                      child: Icon(Icons.camera_alt),
                    ),
                  )
                : CupertinoButton(
                    onPressed: () {
                      takePicture();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: Image.file(image!),
                    ),
                  ),
            SizedBox(height: 12),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Product name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter product name';
                }
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField(
              dropdownColor: Colors.white,
              value: _selectedCategory,
              hint: Text(
                'Select category',
              ),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              items: appProvider.getCategoryList.map((CategoryModel val) {
                return DropdownMenuItem(
                  value: val,
                  child: Text(
                    val.name,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: description,
              minLines: 2,
              maxLines: 10,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Product discription'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter product description';
                }
              },
            ),
            const SizedBox(height: 12),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: price,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Price',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter product price';
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: discount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Discount',
                    ),
                  ),
                ),
              ],
            )),
            const SizedBox(height: 12),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: quantity,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Quantity',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter product quantity';
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: size,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Size',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter product size';
                      }
                    },
                  ),
                ),
              ],
            )),
            const SizedBox(height: 12),
            DropdownButtonFormField(
              dropdownColor: Colors.white,
              value: _selectedUnit,
              hint: Text('Measurement unit'),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _selectedUnit = value;
                });
              },
              items: measurments
                  .map<DropdownMenuItem<String>>((String selectedUnit) {
                return DropdownMenuItem<String>(
                  value: selectedUnit,
                  child: Text(selectedUnit),
                );
              }).toList(),
            ),
            SizedBox(height: 12),
            const SizedBox(height: 20),
            SizedBox(
                child: PrimaryButton(
                    onPressed: () async {
                      if (image == null) {
                        showMessage('Please add image of product');
                      } else if (_selectedCategory == null) {
                        snackBar(context, 'Category not selected');
                      } else if (_selectedUnit == null) {
                        showMessage('Measurment unit not selected');
                      } else if (image != null &&
                          _formKey.currentState!.validate()) {
                        appProvider.addProduct(
                          image!,
                          name.text,
                          description.text,
                          _selectedCategory!.id,
                          price.text.toString(),
                          discount.text.toString(),
                          quantity.text.toString(),
                          size.text.toString(),
                          _selectedUnit!,
                        );
                        showMessage('Product successfully Added');
                        setState(() {
                          image = null;
                          name.clear();
                          description.clear();
                          _selectedCategory = null;
                          price.clear();
                          discount.clear();
                          quantity.clear();
                          size.clear();
                          _selectedUnit = null;
                        });
                      }

                      //   appProvider.updateUserInfoFirebase(
                      //   context, userModel, image);
                    },
                    title: 'Add')),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
