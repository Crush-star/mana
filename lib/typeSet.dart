// id name pnyin,单位，数量，单价，成本价，入库信息，出库信息，数量告警值，备注
//               {}         {}               [{时间，数量}]
import 'dart:convert';

// class ProductUnit {
//   ProductUnit({required this.id, required this.unit, required this.rate});
//   late int id;
//   late String unit;
//   late num rate;
//   ProductUnit.fromMap(Map<String, dynamic> map) {
//     id = map['id'];
//     unit = map['unit'];
//     rate = map['rate'];
//   }
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'unit': unit,
//       'rate': rate,
//     };
//   }
// }

class ProductPrice {
  ProductPrice({required this.id, required this.price, required this.unit});
  late String id;
  late String unit;
  late num price;
  ProductPrice.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    unit = map['unit'];
    price = map['price'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unit': unit,
      'price': price,
    };
  }
}

class ProductInOutInfo {
  ProductInOutInfo({required this.timestamp, required this.count});
  late int timestamp;
  late num count;
  ProductInOutInfo.fromMap(Map<String, dynamic> map) {
    timestamp = map['timestamp'];
    count = map['count'];
  }
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'count': count,
    };
  }
}

class Product {
  Product(
      {this.id,
      this.name,
      this.pinyin,
      this.count,
      this.alertValue,
      this.costPrice,
      this.price,
      this.productInInfo,
      this.productOutInfo,
      this.remark});
  String? id;
  String? name;
  String? pinyin;
  num? count;
  List<ProductPrice>? price;
  num? costPrice;
  List<ProductInOutInfo>? productInInfo;
  List<ProductInOutInfo>? productOutInfo;
  num? alertValue;
  String? remark;

  Product.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    pinyin = map['pinyin'];
    count = map['count'];
    price = map['price'] != null
        ? List<ProductPrice>.from(
            map['price'].map((x) => ProductPrice.fromMap(x)))
        : null;
    costPrice = map['costPrice'];
    productInInfo = map['productInInfo'] != null
        ? List<ProductInOutInfo>.from(
            map['productInInfo'].map((x) => ProductInOutInfo.fromMap(x)))
        : null;
    productOutInfo = map['productOutInfo'] != null
        ? List<ProductInOutInfo>.from(
            map['productOutInfo'].map((x) => ProductInOutInfo.fromMap(x)))
        : null;
    alertValue = map['alertValue'];
    remark = map['remark'];
  }

  Map<String, Object?> toMap() {
    final priceJson = json.encode(price?.map((e) => e.toMap()).toList());
    final productInInfoJson =
        json.encode(productInInfo?.map((e) => e.toMap()).toList());
    final productOutInfoJson =
        json.encode(productOutInfo?.map((e) => e.toMap()).toList());

    return {
      'id': id,
      'name': name,
      'pinyin': pinyin,
      'count': count,
      'alertValue': alertValue,
      'costPrice': costPrice,
      'price': priceJson,
      'productInInfo': productInInfoJson,
      'productOutInfo': productOutInfoJson,
      'remark': remark
    };
  }
}
