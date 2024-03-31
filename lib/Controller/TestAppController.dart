import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../Model/TestModelsClass.dart';
import '../Services/TestApiClasss.dart';

class TestAppStateController extends ChangeNotifier {
  TestAppStateController() {
    showConnection();
    connectivityAlert();
    notifyListeners();
  }
  List<TestAppModelData> itemDataList = [];
  List<TestAppModelData> get getItemDataList => itemDataList;
  List<TestAppModelData> scannedItemDataList = [];
  List<TestAppModelData> get getScannedItemDataList => scannedItemDataList;
  List<TextEditingController> qtyController = List.generate(100, (ij) => TextEditingController());
  List<TextEditingController> priceController = List.generate(100, (ij) => TextEditingController());
  List<TextEditingController> sumController = List.generate(100, (ij) => TextEditingController());
  int il = 0;

  List<String>? selectedValues = [];
  bool noInternet = false;
  bool visibleLoading = false;
  disableKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    notifyListeners();
  }

  init() async {
    await clearAllData();
    await callApi();
    notifyListeners();
  }

  clearAllData() {
    scannedItemDataList = [];
    itemDataList = [];
    qtyController = List.generate(100, (ij) => TextEditingController());

    priceController = List.generate(100, (ij) => TextEditingController());
    sumController = List.generate(100, (ij) => TextEditingController());
  }

  selectProduct(int i, val) {
    selectedValues![i] = val;
    notifyListeners();
  }

  sumofProduct(int i) {
    double sum = 0;
    int qty = int.parse(qtyController[i].text);
    double price = double.parse(priceController[i].text);

    sum = qty * price;
    sumController[i].text = sum.toStringAsFixed(1);
    notifyListeners();
  }

  qtyIncrement(int ind) {
    int qtyctrl = int.parse(qtyController[ind].text);
    qtyctrl = qtyctrl + 1;
    qtyController[ind].text = qtyctrl.toString();
    sumofProduct(ind);

    notifyListeners();
  }

  qtyEdit(int ind) {
    int qtyctrl = int.parse(qtyController[ind].text);
    qtyController[ind].text = qtyctrl.toString();
    sumofProduct(ind);

    notifyListeners();
  }

  qtyDecrement(int ind) {
    int qtydctrl = int.parse(qtyController[ind].text);
    if (qtydctrl > 0) {
      qtydctrl = qtydctrl - 1;
      qtyController[ind].text = qtydctrl.toString();
      sumofProduct(ind);
      notifyListeners();
    } else {}
    notifyListeners();
  }

  deleteRows(int ind) {
    log('indd 33::$ind');
    qtyController.removeAt(ind);
    priceController.removeAt(ind);
    sumController.removeAt(ind);
    selectedValues!.removeAt(ind);
    scannedItemDataList.removeAt(ind);

    log('scannedItemDataList len::${scannedItemDataList.length}');
    notifyListeners();
  }

  addItemListtt() async {
    log('lllllllllllllllll:${getItemDataList.length}');
    scannedItemDataList.add(TestAppModelData(
        brandId: itemDataList[0].brandId,
        categoryId: itemDataList[0].categoryId,
        codCharge: itemDataList[0].codCharge,
        createdBy: itemDataList[0].createdBy,
        created_ts: itemDataList[0].created_ts,
        dealerId: itemDataList[0].dealerId,
        deliveryCharge: itemDataList[0].deliveryCharge,
        exchangeableQtyAmt: itemDataList[0].exchangeableQtyAmt,
        isActive: itemDataList[0].isActive,
        isExchangeable: itemDataList[0].isExchangeable,
        lastActiveDate: itemDataList[0].lastActiveDate,
        prodImage: itemDataList[0].prodImage,
        productDescription: itemDataList[0].productDescription,
        productDiscount: itemDataList[0].productDiscount,
        productId: itemDataList[0].productId,
        productName: itemDataList[0].productName,
        productPrice: itemDataList[0].productPrice,
        productPriceId: itemDataList[0].productPriceId,
        productSellingPrice: itemDataList[0].productSellingPrice,
        productStockQuantity: itemDataList[0].productStockQuantity,
        subCategoryId: itemDataList[0].subCategoryId,
        updatedBy: itemDataList[0].updatedBy,
        updated_ts: itemDataList[0].updated_ts));
    notifyListeners();

    if (scannedItemDataList.length == 1) {
      il = 0;
      priceController[il].text = scannedItemDataList[0].productPrice.toString();
      qtyController[il].text = 1.toString();
      selectedValues!.add(itemDataList[0].productName!);
      sumofProduct(il);
      notifyListeners();
    } else {
      il = scannedItemDataList.length - 1;
      priceController[il].text = scannedItemDataList[0].productPrice.toString();
      qtyController[il].text = 1.toString();
      selectedValues!.add(itemDataList[0].productName!);

      sumofProduct(il);
      notifyListeners();
    }
    notifyListeners();
  }

  priceChanged(int ind) {
    for (var i = 0; i < itemDataList.length; i++) {
      if (selectedValues![ind] == itemDataList[i].productName) {
        priceController[ind].text = itemDataList[i].productPrice.toString();
        sumofProduct(ind);
      }
    }
    notifyListeners();
  }

  callApi() async {
    await TestAppApi.getData().then((value) {
      if (value.statusCode >= 200 && value.statusCode <= 210) {
        if (value.data != null) {
          itemDataList = value.data!;
          notifyListeners();
        }
      } else if (value.statusCode >= 400 && value.statusCode <= 410) {
        Get.defaultDialog(
            title: 'Alert',
            // ignore: prefer_const_constructors
            content: Column(
              children: const [Text('Something Went Wrong..!!'), Text('Try Again..!!')],
            ));

        notifyListeners();
      } else {
        Get.defaultDialog(
            title: 'Alert',
            content: Column(
              children: const [Text('Something Went Wrong..!!'), Text('Try Again..!!')],
            ));
      }
      notifyListeners();
    });
    notifyListeners();
  }

  StreamSubscription? subscription;
  void connectivityAlert() async {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      final hasInternet = event != ConnectivityResult.none;
      if (hasInternet == true) {
        noInternet = false;
        visibleLoading = true;
      } else if (hasInternet == false) {
        // Utils.showTopSnackBar(context, "You have no internet", Colors.red);
        noInternet = true;
        //  print("aaaaaaaaaaaaaaa");
        visibleLoading = false;
        showConnection();
      }
    });
  }

  void showConnection() async {
    final result = await Connectivity().checkConnectivity();
    final hasInternet = result != ConnectivityResult.none;
    if (hasInternet == false) {
      noInternet = true;
      visibleLoading = false;
      Get.defaultDialog(
        title: 'Alert',
        titleStyle: TextStyle(color: Colors.red),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'You Have No Internet Please Check!!..',
            ),
            SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  Get.back();
                  notifyListeners();
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                )),
                child: Text(' OK ')),
          ],
        ),
      );
    } else {
      log("MMMMMMMMMMMM");
      noInternet = false;
      visibleLoading = true;
      await init();
    }
  }
}
