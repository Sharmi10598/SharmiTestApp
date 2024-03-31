import 'dart:convert';
import 'dart:developer';

class TestAppModel {
  int? status;
  String? message;
  int statusCode;
  String? errorMsg;
  List<TestAppModelData>? data;

  TestAppModel({required this.status, required this.message, required this.data, this.errorMsg, required this.statusCode});
  factory TestAppModel.fromJson(Map<String, dynamic> jsons, int resCode) {
    if (jsons["data"] != null) {
      var list = jsons["data"] as List;
      log('message::$list');
      List<TestAppModelData> dataList = list.map((data) => TestAppModelData.fromJson(data)).toList();

      return TestAppModel(data: dataList, message: jsons['message'].toString(), status: jsons['status'], statusCode: resCode);
    } else {
      return TestAppModel(message: jsons['message'].toString(), status: jsons['status'], data: null, statusCode: resCode);
    }
  }
  factory TestAppModel.exception(String e, int resCode) {
    return TestAppModel(data: null, message: null, status: null, statusCode: resCode, errorMsg: e);
  }
}

class TestAppModelData {
  int? productId;
  String? productName;
  int? categoryId;
  int? subCategoryId;
  int? brandId;
  String? productDescription;
  int? productStockQuantity;
  int? dealerId;
  int? isActive;
  String? lastActiveDate;
  int? createdBy;
  String? created_ts;
  int? updatedBy;
  String? updated_ts;
  int? productPriceId;
  int? productPrice;
  int? productDiscount;
  int? productSellingPrice;
  int? deliveryCharge;
  int? codCharge;
  int? isExchangeable;
  int? exchangeableQtyAmt;
  String? prodImage;

  TestAppModelData(
      {required this.brandId,
      required this.categoryId,
      required this.codCharge,
      required this.createdBy,
      required this.created_ts,
      required this.dealerId,
      required this.deliveryCharge,
      required this.exchangeableQtyAmt,
      required this.isActive,
      required this.isExchangeable,
      required this.lastActiveDate,
      required this.prodImage,
      required this.productDescription,
      required this.productDiscount,
      required this.productId,
      required this.productName,
      required this.productPrice,
      required this.productPriceId,
      required this.productSellingPrice,
      required this.productStockQuantity,
      required this.subCategoryId,
      required this.updatedBy,
      required this.updated_ts});

  factory TestAppModelData.fromJson(Map<String, dynamic> json) {
    return TestAppModelData(
        brandId: json['brand_id'],
        categoryId: json['category_id'],
        codCharge: json['cod_charge'],
        createdBy: json['created_by'],
        created_ts: json['created_ts'],
        dealerId: json['dealer_id'],
        deliveryCharge: json['delivery_charge'],
        exchangeableQtyAmt: json['exchangeable_qty_amt'],
        isActive: json['is_active'],
        isExchangeable: json['is_exchangeable'],
        lastActiveDate: json['last_active_date'],
        prodImage: json['prod_image'],
        productDescription: json['product_description'],
        productDiscount: json['product_discount'],
        productId: json['product_id'],
        productName: json['product_name'],
        productPrice: json['product_price'],
        productPriceId: json['product_price_id'],
        productSellingPrice: json['product_selling_price'],
        productStockQuantity: json['product_stock_quantity'],
        subCategoryId: json['sub_category_id'],
        updatedBy: json['updated_by'],
        updated_ts: json['updated_ts']);
  }
}

     

        //  "product_name": "Bisleri 30 Litre Can",
        //     "category_id": 1,
        //     "sub_category_id": 1,
        //     "brand_id": 1,
        //     "product_description": "Be it use at home or in office, it ensures that you have pure, safe and healthy drinking water available all the time. In terms of its usage, hygiene is best maintained with the push tap and stand mechanism.",
        //     "product_image": "product_1.png",
        //     "product_stock_quantity": 2541,
        //     "dealer_id": 1,
        //     "is_active": 1,
        //     "last_active_date": "2023-05-04",
        //     "created_by": 1,
        //     "created_ts": "2023-05-04 16:21:40",
        //     "updated_by": 1,
        //     "updated_ts": "2023-05-04 16:21:40",
        //     "product_price_id": 1,
        //     "product_price": 120,
        //     "product_discount": 0,
        //     "product_selling_price": 120,
        //     "delivery_charge": 10,
        //     "cod_charge": 10,
        //     "is_exchangeable": 1,
        //     "exchangeable_qty_amt": 10,
        //     "prod_image": "https://bycuat.fatneedle.c