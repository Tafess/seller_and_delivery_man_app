import 'dart:convert';

SellerModel sellerModelFromJson(String str) =>
    SellerModel.fromJson(json.decode(str));

String sellerModelToJson(SellerModel data) => json.encode(data.toJson());

class SellerModel {
  String? image;
  String? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? country;
  String? region;
  String? city;
  String? zone;
  String? woreda;
  String? kebele;

  SellerModel({
    this.image,
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.country,
    this.region,
    this.city,
    this.zone,
    this.woreda,
    this.kebele,
  });

  factory SellerModel.fromJson(Map<String, dynamic> json) => SellerModel(
        image: json['image'],
        id: json['id'],
        firstName: json['firstName'],
        middleName: json['middleName'],
        lastName: json['lastName'],
        phoneNumber: json['phoneNumber'],
        email: json['email'],
        country: json['country'],
        region: json['region'],
        city: json['city'],
        zone: json['zone'],
        woreda: json['woreda'],
        kebele: json['kebele'],
      );
  Map<String, dynamic> toJson() => {
        'image': image,
        'id': id,
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'email': email,
        'country': country,
        'region': region,
        'city': city,
        'zone': zone,
        'woreda': woreda,
        'kebele': kebele,
      };

  SellerModel copyWith({
    String? firstName,
    String? image,
  }) =>
      SellerModel(
        id: id,
        firstName: firstName ?? this.firstName,
        middleName: middleName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        image: image ?? this.image,
        email: email,
        country: country,
        region: region,
        city: city,
        zone: zone,
        woreda: woreda,
        kebele: kebele,
      );
}
