// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellers/constants/routes.dart';
import 'package:sellers/provider/app_provider.dart';
import 'package:sellers/screens/category_view.dart';
import 'package:sellers/screens/completed_order_list.dart';
import 'package:sellers/screens/product_view.dart';
import 'package:sellers/screens/user_view.dart';
import 'package:sellers/widgets/single_dash_item.dart';

class HomePage extends StatefulWidget {
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
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Admin Name'),
                            Text('admin@gmail.com'),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Send Notification',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      GridView.count(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.only(top: 12),
                        crossAxisCount: 2,
                        children: [
                          SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: const UserViewScreen(),
                                    context: context);
                              },
                              title: 'Users',
                              subtitle:
                                  appProvider.getUserList.length.toString()),
                          SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: const CategoryViewScreen(),
                                    context: context);
                              },
                              title: 'Category',
                              subtitle: appProvider.getCategoryList.length
                                  .toString()),
                          SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: const ProductView(),
                                    context: context);
                              },
                              title: 'Products',
                              subtitle:
                                  appProvider.getProducts.length.toString()),
                          SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: const ProductView(),
                                    context: context);
                              },
                              title: 'Earnings',
                              subtitle: 'ETB ${appProvider.getTotalEarnings}'),
                          SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: OrderListView(title: 'Pending'),
                                    context: context);
                              },
                              title: 'Pending order',
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
                              title: 'Completed order',
                              subtitle: appProvider.getCompletedOrder.length
                                  .toString()),
                          SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: OrderListView(title: 'Canceled'),
                                    context: context);
                              },
                              title: 'Canceled order',
                              subtitle: appProvider.getCanceledOrderList.length
                                  .toString()),
                          SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: OrderListView(title: 'Delivery'),
                                    context: context);
                              },
                              title: 'Delverd order',
                              subtitle: appProvider.getDeliveryOrderList.length
                                  .toString()),
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
