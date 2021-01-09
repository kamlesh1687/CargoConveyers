import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userId;
  String userName;
  String email;
  String companyName;
  String city;
  String contactNumber;
  bool isShipper;

  UserModel({
    this.userId,
    this.userName,
    this.email,
    this.companyName,
    this.city,
    this.contactNumber,
    this.isShipper,
  });

//fromDocumentSnapshot
  UserModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    userId = documentSnapshot.data()["userId"];
    userName = documentSnapshot.data()["userName"];
    email = documentSnapshot.data()["email"];
    companyName = documentSnapshot.data()["companyName"];
    city = documentSnapshot.data()["city"];
    contactNumber = documentSnapshot.data()["contactNumber"];
    isShipper = documentSnapshot.data()["isShipper"];
  }

//toString
  @override
  String toString() {
    return '''UserModel: {userId = ${this.userId},userName = ${this.userName},email = ${this.email},companyName = ${this.companyName},city = ${this.city},contactNumber = ${this.contactNumber},isShipper = ${this.isShipper}}''';
  }

//fromJson
  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    email = json['email'];
    companyName = json['companyName'];
    city = json['city'];
    contactNumber = json['contactNumber'];
    isShipper = json['isShipper'];
  }

//toJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['companyName'] = this.companyName;
    data['city'] = this.city;
    data['contactNumber'] = this.contactNumber;
    data['isShipper'] = this.isShipper;
    return data;
  }
}
