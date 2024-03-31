// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Constant/Screen.dart';
import '../Controller/TestAppController.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: WillPopScope(
          onWillPop: onWillPop,
          child: ChangeNotifierProvider<TestAppStateController>(
              create: (context) => TestAppStateController(),
              builder: (context, child) {
                return Consumer<TestAppStateController>(builder: (BuildContext context, prdCtrl, Widget? child) {
                  return SafeArea(
                      child: SingleChildScrollView(
                    child: Container(
                        height: Screens.bodyheight(context),
                        padding: EdgeInsets.only(
                          top: Screens.bodyheight(context) * 0.02,
                          left: Screens.bodyheight(context) * 0.01,
                          right: Screens.bodyheight(context) * 0.01,
                          bottom: Screens.bodyheight(context) * 0.03,
                        ),
                        child: context.watch<TestAppStateController>().itemDataList.isEmpty
                            ? Center(
                                child: CircularProgressIndicator(color: Colors.deepPurple),
                              )
                            : Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            context.read<TestAppStateController>().addItemListtt();
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        )),
                                        child: Text('Add')),
                                  ),
                                  Expanded(
                                      child: ListView.builder(
                                          itemCount: context.read<TestAppStateController>().scannedItemDataList.length,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              elevation: 0,
                                              child: Container(
                                                  height: Screens.bodyheight(context) * 0.23,
                                                  width: Screens.width(context) * 0.1,
                                                  padding: EdgeInsets.only(
                                                    top: Screens.bodyheight(context) * 0.01,
                                                    left: Screens.bodyheight(context) * 0.01,
                                                    right: Screens.bodyheight(context) * 0.01,
                                                    bottom: Screens.bodyheight(context) * 0.015,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                    DropdownButtonHideUnderline(
                                                      child: DropdownButton(
                                                        items: context
                                                            .read<TestAppStateController>()
                                                            .getItemDataList
                                                            .map((item) => DropdownMenuItem<String>(
                                                                  value: item.productName,
                                                                  child: Text(
                                                                    item.productName.toString(),
                                                                    style: const TextStyle(
                                                                      fontSize: 14,
                                                                    ),
                                                                  ),
                                                                ))
                                                            .toList(),
                                                        value: context.read<TestAppStateController>().selectedValues![index],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            context.read<TestAppStateController>().selectedValues![index] = value.toString();
                                                            context.read<TestAppStateController>().priceChanged(index);
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment: Alignment.centerRight,
                                                      child: ElevatedButton(
                                                          onPressed: () {
                                                            context.read<TestAppStateController>().deleteRows(index);
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                              shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(6),
                                                          )),
                                                          child: Text('Del')),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          height: Screens.bodyheight(context) * 0.05,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Container(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(
                                                                    "Price",
                                                                    maxLines: 2,
                                                                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                                                                  )),
                                                              Container(
                                                                  width: Screens.width(context) * 0.1,
                                                                  height: Screens.bodyheight(context) * 0.05,
                                                                  alignment: Alignment.centerLeft,
                                                                  child: TextFormField(
                                                                    readOnly: true,
                                                                    textAlign: TextAlign.right,
                                                                    style: theme.textTheme.bodyMedium,
                                                                    onChanged: (v) {},
                                                                    decoration: InputDecoration(
                                                                      filled: false,
                                                                      // enabledBorder: InputBorder.none,
                                                                      enabledBorder: UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Colors.black),
                                                                      ),
                                                                      focusedBorder: UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Colors.black),
                                                                      ),
                                                                    ),
                                                                    textDirection: TextDirection.ltr,
                                                                    keyboardType: TextInputType.number,
                                                                    controller: context.watch<TestAppStateController>().priceController[index],
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          height: Screens.bodyheight(context) * 0.05,
                                                          width: Screens.width(context) * 0.43,
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Container(
                                                                width: Screens.width(context) * 0.08,
                                                                child: Center(
                                                                  child: ElevatedButton(
                                                                    onPressed: () {
                                                                      context.read<TestAppStateController>().qtyIncrement(index);
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                        padding: EdgeInsets.all(0),
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(6),
                                                                        )),
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      color: Colors.white,
                                                                      size: Screens.bodyheight(context) * 0.02,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                  alignment: Alignment.center,
                                                                  child: Text(
                                                                    "Quantity",
                                                                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                                                                  )),
                                                              Container(
                                                                  width: Screens.width(context) * 0.09,
                                                                  height: Screens.bodyheight(context) * 0.05,
                                                                  alignment: Alignment.centerLeft,
                                                                  child: TextFormField(
                                                                    textAlign: TextAlign.right,
                                                                    style: theme.textTheme.bodyMedium,
                                                                    onChanged: (v) {},
                                                                    onEditingComplete: () {
                                                                      context.read<TestAppStateController>().qtyEdit(index);
                                                                      context.read<TestAppStateController>().disableKeyBoard(context);
                                                                    },
                                                                    onTap: () {
                                                                      context.read<TestAppStateController>().qtyController[index].text = context.read<TestAppStateController>().qtyController[index].text;
                                                                      context.read<TestAppStateController>().qtyController[index].selection = TextSelection(
                                                                        baseOffset: 0,
                                                                        extentOffset: context.read<TestAppStateController>().qtyController[index].text.length,
                                                                      );
                                                                    },
                                                                    decoration: InputDecoration(
                                                                      filled: false,

                                                                      // enabledBorder: InputBorder.none,
                                                                      enabledBorder: UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Colors.black),
                                                                      ),
                                                                      focusedBorder: UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Colors.black),
                                                                      ),
                                                                      contentPadding: const EdgeInsets.symmetric(
                                                                        vertical: 12,
                                                                        horizontal: 5,
                                                                      ),
                                                                    ),
                                                                    // cursorColor: Colors.grey,
                                                                    textDirection: TextDirection.ltr,
                                                                    keyboardType: TextInputType.number,
                                                                    controller: context.watch<TestAppStateController>().qtyController[index],
                                                                  )),
                                                              Container(
                                                                width: Screens.width(context) * 0.09,
                                                                child: Center(
                                                                  child: ElevatedButton(
                                                                    onPressed: () {
                                                                      context.read<TestAppStateController>().qtyDecrement(index);
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                        padding: EdgeInsets.all(0),
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(6),
                                                                        )),
                                                                    child: Icon(
                                                                      Icons.remove,
                                                                      color: Colors.white,
                                                                      size: Screens.bodyheight(context) * 0.02,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          height: Screens.bodyheight(context) * 0.05,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Container(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(
                                                                    "Sum",
                                                                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                                                                  )),
                                                              SizedBox(width: Screens.width(context) * 0.02),
                                                              Container(
                                                                  width: Screens.width(context) * 0.13,
                                                                  height: Screens.bodyheight(context) * 0.05,
                                                                  alignment: Alignment.centerLeft,
                                                                  child: TextFormField(
                                                                    readOnly: true,
                                                                    textAlign: TextAlign.right,
                                                                    style: theme.textTheme.bodyMedium,
                                                                    onChanged: (v) {
                                                                      // context.read<TestAppStateController>().sumofProduct(index);
                                                                    },
                                                                    decoration: InputDecoration(
                                                                      filled: false,

                                                                      // enabledBorder: InputBorder.none,
                                                                      enabledBorder: UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Colors.black),
                                                                      ),
                                                                      focusedBorder: UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Colors.black),
                                                                      ),
                                                                    ),
                                                                    textDirection: TextDirection.ltr,
                                                                    keyboardType: TextInputType.number,
                                                                    controller: context.watch<TestAppStateController>().sumController[index],
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ])),
                                            );
                                          })),
                                ],
                              )),
                  ));
                });
              }),
        ));
  }

  Future<bool> onWillPop() async {
    return (await Get.defaultDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.all(5),
          title: 'Alert', titleStyle: TextStyle(color: Colors.red),
          content: Container(
            width: Screens.width(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: EdgeInsets.only(left: 40),
                    width: Screens.width(context) * 0.85,
                    child: Divider(
                      color: Colors.grey,
                    )),
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Are you sure",
                      style: TextStyle(fontSize: 15),
                    )),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.01,
                ),
                Container(alignment: Alignment.center, child: Text("Do you want to exit?", style: TextStyle(fontSize: 15))),
                Container(padding: EdgeInsets.only(left: 40), width: Screens.width(context) * 0.85, child: Divider(color: Colors.grey)),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Screens.width(context) * 0.37,
                      height: Screens.bodyheight(context) * 0.05,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(color: Colors.white),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(0),
                            )),
                          ),
                          onPressed: () {
                            exit(0);
                          },
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    Container(
                      width: Screens.width(context) * 0.37,
                      height: Screens.bodyheight(context) * 0.05,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(color: Colors.white),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(10),
                            )),
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.of(context).pop(false);
                            });
                          },
                          child: Text(
                            "No",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Text(
          //       'You Have No Internet Please Check!!..',
          //     ),
          //     SizedBox(height: 15),
          //     ElevatedButton(
          //         onPressed: () {
          //           Get.back();
          //           notifyListeners();
          //         },
          //         style: ElevatedButton.styleFrom(
          //             shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(6),
          //         )),
          //         child: Text('OK')),
          //   ],
          // ),
        )
        // showDialog(
        //       context: context,
        //       builder: (context) => AlertDialog(
        //         insetPadding: EdgeInsets.all(10),
        //         contentPadding: EdgeInsets.all(0),
        //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        // content: Container(
        //   width: Screens.width(context),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Container(
        //         width: Screens.width(context),
        //         height: Screens.bodyheight(context) * 0.04,
        //         child: ElevatedButton(
        //             onPressed: () {},
        //             style: ElevatedButton.styleFrom(
        //               textStyle: TextStyle(),
        //               shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.only(
        //                 topRight: Radius.circular(10),
        //                 topLeft: Radius.circular(10),
        //               )),
        //             ),
        //             child: Text("Alert", style: TextStyle(fontSize: 15))),
        //       ),
        //       SizedBox(
        //         height: Screens.padingHeight(context) * 0.01,
        //       ),
        //       Container(
        //           padding: EdgeInsets.only(left: 40),
        //           width: Screens.width(context) * 0.85,
        //           child: Divider(
        //             color: Colors.grey,
        //           )),
        //       Container(
        //           alignment: Alignment.center,
        //           child: Text(
        //             "Are you sure",
        //             style: TextStyle(fontSize: 15),
        //           )),
        //       SizedBox(
        //         height: Screens.padingHeight(context) * 0.01,
        //       ),
        //       Container(alignment: Alignment.center, child: Text("Do you want to exit?", style: TextStyle(fontSize: 15))),
        //       Container(padding: EdgeInsets.only(left: 40), width: Screens.width(context) * 0.85, child: Divider(color: Colors.grey)),
        //       SizedBox(
        //         height: Screens.bodyheight(context) * 0.01,
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Container(
        //             width: Screens.width(context) * 0.47,
        //             height: Screens.bodyheight(context) * 0.06,
        //             child: ElevatedButton(
        //                 style: ElevatedButton.styleFrom(
        //                   textStyle: TextStyle(color: Colors.white),
        //                   shape: RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.only(
        //                     bottomLeft: Radius.circular(10),
        //                     bottomRight: Radius.circular(0),
        //                   )),
        //                 ),
        //                 onPressed: () {
        //                   exit(0);
        //                 },
        //                 child: Text(
        //                   "Yes",
        //                   style: TextStyle(color: Colors.white),
        //                 )),
        //           ),
        //           Container(
        //             width: Screens.width(context) * 0.47,
        //             height: Screens.bodyheight(context) * 0.06,
        //             child: ElevatedButton(
        //                 style: ElevatedButton.styleFrom(
        //                   textStyle: TextStyle(color: Colors.white),
        //                   shape: RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.only(
        //                     bottomLeft: Radius.circular(0),
        //                     bottomRight: Radius.circular(10),
        //                   )),
        //                 ),
        //                 onPressed: () {
        //                   setState(() {
        //                     Navigator.of(context).pop(false);
        //                   });
        //                 },
        //                 child: Text(
        //                   "No",
        //                   style: TextStyle(color: Colors.white),
        //                 )),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        //       ),
        //     )) ??

        ) ??
        false;
  }
}
