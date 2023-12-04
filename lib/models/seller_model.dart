import 'dart:convert';

import 'package:image_picker/image_picker.dart';

SellerModel sellerModelFromJson(String str) =>
    SellerModel.fromJson(json.decode(str));

String sellerModelToJson(SellerModel data) => json.encode(data.toJson());

class SellerModel {
  bool approved;
  String id;
  String firstName;
  String middleName;
  String lastName;
  String email;
  String phoneNumber;
  String country;
  String region;
  String city;
  String zone;
  String woreda;
  String kebele;
  String idCard;
  String profilePhoto;

  SellerModel(
      {required this.approved,
      required this.id,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.country,
      required this.region,
      required this.city,
      required this.zone,
      required this.woreda,
      required this.kebele,
      required this.idCard,
      required this.profilePhoto});

  factory SellerModel.fromJson(Map<String, dynamic> json) => SellerModel(
        approved: json['approved'],
        id: json['id']!,
        firstName: json['firstName'],
        middleName: json['middleName'],
        lastName: json['lastName'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        country: json['country'],
        region: json['region'],
        city: json['city'],
        zone: json['zone'],
        woreda: json['woreda'],
        kebele: json['kebele'],
        idCard: json['idCard'],
        profilePhoto: json['profilePhoto'],
      );
  Map<String, dynamic> toJson() => {
        'approved': false,
        'id': id,
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'country': country,
        'region': region,
        'city': city,
        'zone': zone,
        'woreda': woreda,
        'kebele': kebele,
        'idCard': idCard,
        'profilePhoto': profilePhoto,
      };

  SellerModel copyWith({
    String? firstName,
    idCard,
  }) =>
      SellerModel(
        approved: approved,
        id: id,
        firstName: firstName ?? this.firstName,
        middleName: middleName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        country: country,
        region: region,
        city: city,
        zone: zone,
        woreda: woreda,
        kebele: kebele,
        idCard: idCard ?? this.idCard,
        profilePhoto: profilePhoto,
      );
}
