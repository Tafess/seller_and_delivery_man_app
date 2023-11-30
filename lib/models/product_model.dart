import 'dart:convert';

class ProductModel {
  String categoryId;
  String description;
  String id;
  String image;
  String name;
  double price;
  double discount;
  int quantity;
  double size;
  String measurement;
  String status;
  bool isFavorite;
  bool disabled;
  String productId;
  String sellerId;

  ProductModel({
    required this.categoryId,
    required this.description,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.discount,
    required this.quantity,
    required this.size,
    required this.measurement,
    required this.status,
    required this.isFavorite,
    required this.disabled,
    required this.productId,
    required this.sellerId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      categoryId: json['categoryId'] ?? '',
      description: json['description'] ?? '',
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      size: (json['size'] as num?)?.toDouble() ?? 0.0,
      measurement: json['measurement'] ?? '',
      status: json['status'] ?? '',
      isFavorite: false,
      disabled: json['disabled'],
      productId: json['productId'],
      sellerId: json['sellerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'description': description,
      'id': id,
      'image': image,
      'name': name,
      'price': price,
      'quantity': quantity,
      'size': size,
      'measurement': measurement,
      'status': status,
      'isFavorite': false,
      'disabled': false,
      'productId': productId,
      'sellerId':sellerId,
    };
  }

  ProductModel copyWith({
    String? categoryId,
    String? description,
    String? id,
    String? image,
    String? name,
    double? price,
    int? quantity,
    double? size,
    String? measurement,
    double? discount,
    String? status,
    String? productId,
    String? sellerId,
  }) {
    return ProductModel(
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      discount: price ?? this.price,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      measurement: measurement ?? this.measurement,
      status: status ?? this.status,
      isFavorite: false,
      disabled: false,
      productId: productId??'',
      sellerId: sellerId??'',
    );
  }
}

String productModelToJson(ProductModel data) => json.encode(data.toJson());

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));