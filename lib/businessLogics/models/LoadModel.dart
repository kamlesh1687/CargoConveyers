import 'package:cloud_firestore/cloud_firestore.dart';

class LoadModel {
  String requestId;
  String from;
  String to;
  var posTime;
  String goodDetail;
  String ownerId;
  String capacity;
  String payMode;
  String rate;
  String priceFlexible;
  bool isExpired;

  LoadModel({
    this.requestId,
    this.from,
    this.to,
    this.posTime,
    this.goodDetail,
    this.ownerId,
    this.capacity,
    this.payMode,
    this.rate,
    this.priceFlexible,
    this.isExpired,
  });

//fromDocumentSnapshot
  factory LoadModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    return LoadModel(
      requestId: documentSnapshot.data()["requestId"],
      from: documentSnapshot.data()["from"],
      to: documentSnapshot.data()["to"],
      posTime: documentSnapshot.data()['posTime'],
      goodDetail: documentSnapshot.data()["goodDetail"],
      ownerId: documentSnapshot.data()["ownerId"],
      capacity: documentSnapshot.data()["capacity"],
      payMode: documentSnapshot.data()["payMode"],
      rate: documentSnapshot.data()["rate"],
      priceFlexible: documentSnapshot.data()["priceFlexible"],
      isExpired: documentSnapshot.data()["isExpired"],
    );
  }

//toString
  @override
  String toString() {
    return '''MarketPost: {requestId = ${this.requestId},from = ${this.from},to = ${this.to},posTime = ${this.posTime},goodDetail = ${this.goodDetail},ownerId = ${this.ownerId},capacity = ${this.capacity},payMode = ${this.payMode},rate = ${this.rate},priceFlexible = ${this.priceFlexible},isExpired = ${this.isExpired}}''';
  }

//fromJson
  LoadModel.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    from = json['from'];
    to = json['to'];
    posTime = json['posTime'];
    goodDetail = json['goodDetail'];
    ownerId = json['ownerId'];
    capacity = json['capacity'];
    payMode = json['payMode'];
    rate = json['rate'];
    priceFlexible = json['priceFlexible'];
    isExpired = json['isExpired'];
  }

//toJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['requestId'] = this.requestId;
    data['from'] = this.from;
    data['to'] = this.to;
    data['posTime'] = this.posTime;
    data['goodDetail'] = this.goodDetail;
    data['ownerId'] = this.ownerId;
    data['capacity'] = this.capacity;
    data['payMode'] = this.payMode;
    data['rate'] = this.rate;
    data['priceFlexible'] = this.priceFlexible;
    data['isExpired'] = this.isExpired;
    return data;
  }
}
