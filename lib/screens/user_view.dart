
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellers/models/seller_model.dart';
import 'package:sellers/provider/app_provider.dart';
import 'package:sellers/widgets/single_user_card.dart';

class UserViewScreen extends StatelessWidget {
  const UserViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Consumer<AppProvider>(builder: (context, value, child) {
        return ListView.builder(
            itemCount: value.getUserList.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              SellerModel sellerModel = value.getUserList[index];
              return SingleUserCard(
                index: index,
                sellerModel: sellerModel,
              );
            });
      }),
    );
  }
}
