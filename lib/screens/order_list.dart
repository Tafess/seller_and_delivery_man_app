// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellers/models/order_model.dart';
import 'package:sellers/providers/app_provider.dart';

class OrderListView extends StatelessWidget {
  final String title;

  const OrderListView({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    List<OrderModel> orders = getOrders(appProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor:
                  MaterialStateColor.resolveWith((states) => Colors.green),
              showCheckboxColumn: false,
              columnSpacing: 1,
              columns: [
                DataColumn(
                  label: Container(
                    margin: EdgeInsets.fromLTRB(1, 0, 2, 0),
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                    ),
                    child: Text(
                      'Image',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 80,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        //   border: Border.all(color: Colors.white),
                        ),
                    child: Text(' Name',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 50,
                    margin: EdgeInsets.fromLTRB(1, 0, 2, 0),
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                    ),
                    child: Text('Quantity',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
                DataColumn(
                  label: Text('Total(ETB)',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Container(
                    width: 70,
                    margin: EdgeInsets.fromLTRB(1, 0, 2, 0),
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                    ),
                    child: Text('Status',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 80,
                    margin: EdgeInsets.fromLTRB(1, 0, 2, 0),
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 14),
                    decoration: BoxDecoration(
                        //color: Colors.white,
                        // border: Border.all(color: Colors.white),
                        ),
                    child: Text('Details',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
              rows: orders.map((order) {
                List<DataCell> cells = [
                  DataCell(
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.network(
                        order.products[0].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 80,
                      padding:
                          EdgeInsets.symmetric(horizontal: 2, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.green),
                          bottom: BorderSide(color: Colors.green),
                          left: BorderSide(color: Colors.grey),
                          right: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Text(
                        order.products[0].name,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 50,
                      margin: EdgeInsets.fromLTRB(1, 0, 2, 0),
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border(
                          top: BorderSide(color: Colors.green),
                          bottom: BorderSide(color: Colors.green),
                          // left: BorderSide(color: Colors.grey),
                          // right: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Text(
                        order.products[0].quantity.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 80,
                      padding:
                          EdgeInsets.symmetric(horizontal: 4, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.green),
                          bottom: BorderSide(color: Colors.green),
                          left: BorderSide(color: Colors.grey),
                          right: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Text(
                        order.totalprice.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 70,
                      padding:
                          EdgeInsets.symmetric(horizontal: 2, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border(
                          top: BorderSide(color: Colors.green),
                          bottom: BorderSide(color: Colors.green),
                          left: BorderSide(color: Colors.grey),
                          right: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Text(
                        order.status,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: orderStatusColor(order.status),
                        ),
                      ),
                    ),
                  ),
                ];

                if (order.products.length > 1) {
                  cells.add(
                    DataCell(
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black54),
                          side: MaterialStateProperty.all(
                              BorderSide(color: Colors.white)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          showBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(2),
                                      bottom: Radius.circular(30),
                                    ),
                                    border: Border.all(
                                        color: Colors.blue, width: 5)),
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        color: Colors.blue,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 0, 0, 0),
                                                child: Text(
                                                  'Details',
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 24),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 40,
                                              color: Colors.red,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'X',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 30),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          headingRowColor:
                                              MaterialStateColor.resolveWith(
                                            (states) => Colors.grey.shade300,
                                          ),
                                          columns: [
                                            DataColumn(label: Text('Image')),
                                            DataColumn(label: Text('Name')),
                                            DataColumn(label: Text('Quantity')),
                                            DataColumn(
                                                label: Text('Total(ETB)')),
                                          ],
                                          rows: order.products
                                              .map((singleProduct) {
                                            return DataRow(cells: [
                                              DataCell(
                                                Container(
                                                  height: 30,
                                                  width: 30,
                                                  color: Colors.grey.shade400,
                                                  child: Image.network(
                                                    singleProduct.image,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  singleProduct.name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  singleProduct.quantity
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              DataCell(
                                                FittedBox(
                                                  child: Text(
                                                    singleProduct.price
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ]);
                                          }).toList(),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.zero,
                            child: Text(
                              'More',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  // Add an empty DataCell for "Details" when there is only one product
                  cells.add(DataCell(Text('')));
                }

                return DataRow(
                  color: MaterialStateColor.resolveWith((states) =>
                      orders.indexOf(order) % 2 == 0
                          ? Colors.grey.shade300
                          : Colors.white),
                  cells: cells,
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  List<OrderModel> getOrders(AppProvider appProvider) {
    if (title == 'All') {
      return appProvider.getAllOrderList;
    } else if (title == 'Pending') {
      return appProvider.getPendingOrderList;
    } else if (title == 'Completed') {
      return appProvider.getCompletedOrder;
    } else if (title == 'Canceled') {
      return appProvider.getCanceledOrderList;
    } else if (title == 'Delivery') {
      return appProvider.getDeliveryOrderList;
    } else {
      return [];
    }
  }

  Color orderStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.yellow.shade900;
      case 'canceled':
        return Colors.red;
      case 'completed':
        return Colors.green;
      case 'delivery':
        return Colors.blue;
      default:
        return Colors.black;
    }
  }
}









      // showDialog(
      //                       context: context,
      //                       builder: (BuildContext context) {
      //                         return AlertDialog(
      //                           shape: RoundedRectangleBorder(
      //                             borderRadius: BorderRadius.vertical(
      //                               top: Radius.circular(20),
      //                               bottom: Radius.circular(30),
      //                             ),
      //                           ),
      //                           contentPadding:
      //                               EdgeInsets.fromLTRB(2, 0, 20, 20),
      //                           titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      //                           title: Container(
      //                             color: Colors.white,
      //                             child: Row(
      //                               mainAxisAlignment:
      //                                   MainAxisAlignment.spaceBetween,
      //                               children: [
      //                                 Center(
      //                                   child: Padding(
      //                                     padding: const EdgeInsets.fromLTRB(
      //                                         20, 0, 0, 0),
      //                                     child: Text(
      //                                       'Details',
      //                                       style: TextStyle(
      //                                           color: Colors.black87,
      //                                           fontSize: 24),
      //                                     ),
      //                                   ),
      //                                 ),
      //                                 Container(
      //                                   width: 40,
      //                                   color: Colors.red,
      //                                   child: TextButton(
      //                                     style: TextButton.styleFrom(
      //                                       padding: EdgeInsets.zero,
      //                                     ),
      //                                     onPressed: () {
      //                                       Navigator.of(context).pop();
      //                                     },
      //                                     child: Text(
      //                                       'X',
      //                                       style: TextStyle(
      //                                           color: Colors.white,
      //                                           fontSize: 30),
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                           content: SingleChildScrollView(
      //                             scrollDirection: Axis.vertical,
      //                             child: Column(
      //                               children: [
      //                                 SingleChildScrollView(
      //                                   scrollDirection: Axis.horizontal,
      //                                   child: DataTable(
      //                                     headingRowColor:
      //                                         MaterialStateColor.resolveWith(
      //                                       (states) => Colors.grey.shade300,
      //                                     ),
      //                                     columns: [
      //                                       DataColumn(label: Text('Image')),
      //                                       DataColumn(label: Text('Name')),
      //                                       DataColumn(label: Text('Quantity')),
      //                                       DataColumn(
      //                                           label: Text('Total(ETB)')),
      //                                     ],
      //                                     rows: order.products
      //                                         .map((singleProduct) {
      //                                       return DataRow(cells: [
      //                                         DataCell(
      //                                           Container(
      //                                             height: 30,
      //                                             width: 30,
      //                                             color: Colors.grey.shade400,
      //                                             child: Image.network(
      //                                               singleProduct.image,
      //                                               fit: BoxFit.cover,
      //                                             ),
      //                                           ),
      //                                         ),
      //                                         DataCell(
      //                                           Text(
      //                                             singleProduct.name,
      //                                             style: const TextStyle(
      //                                                 fontSize: 16,
      //                                                 color: Colors.black),
      //                                           ),
      //                                         ),
      //                                         DataCell(
      //                                           Text(
      //                                             singleProduct.quantity
      //                                                 .toString(),
      //                                             style: TextStyle(
      //                                                 color: Colors.black),
      //                                           ),
      //                                         ),
      //                                         DataCell(
      //                                           FittedBox(
      //                                             child: Text(
      //                                               singleProduct.price
      //                                                   .toString(),
      //                                               style: TextStyle(
      //                                                   color: Colors.black),
      //                                             ),
      //                                           ),
      //                                         ),
      //                                       ]);
      //                                     }).toList(),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         );
      //                       },
      //                     );
                    