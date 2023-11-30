// ignore_for_file: use_build_context_synchronously



import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sellers/constants/constants.dart';
import 'package:sellers/constants/primary_button.dart';
import 'package:sellers/controllers/firebase_storage_helper.dart';
import 'package:sellers/models/catagory_model.dart';
import 'package:sellers/provider/app_provider.dart';

class EditCategory extends StatefulWidget {
  final CategoryModel categoryModel;
  final int index;
  const EditCategory(
      {super.key, required this.categoryModel, required this.index});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
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

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Category edit')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        children: [
          image == null
              ? CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 50,
                      child: Icon(Icons.camera_alt)),
                )
              : CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: FileImage(image!),
                  ),
                ),
          const SizedBox(height: 12),
          TextFormField(
            controller: name,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: widget.categoryModel.name),
          ),
          const SizedBox(height: 20),
          SizedBox(
              child: PrimaryButton(
                  onPressed: () async {
                    if (image == null && name.text.isEmpty) {
                      Navigator.of(context).pop();
                    } else if (image != null) {
                      String imageUrl = await FirebaseStorageHelper.instance
                          .uploadCategoryImage(widget.categoryModel.id, image!);
                      CategoryModel categoryModel =
                          widget.categoryModel.copyWith(
                        image: imageUrl,
                        name: name.text.isEmpty ? null : name.text,
                      );
                      appProvider.updateCategoryList(
                          widget.index, categoryModel);
                      showMessage('Category successfuly updated');
                    } else {
                      CategoryModel categoryModel =
                          widget.categoryModel.copyWith(
                        name: name.text.isEmpty ? null : name.text,
                      );
                      appProvider.updateCategoryList(
                          widget.index, categoryModel);
                      showMessage('Category successfully updated');
                    }
                    Navigator.of(context).pop();
                    //   appProvider.updateUserInfoFirebase(
                    //   context, userModel, image);
                  },
                  title: 'Update'))
        ],
      ),
    );
  }
}
