import 'dart:math';

import 'package:crypto_project/Coins.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CoinsListPage extends StatefulWidget {
  List<Coins> coins;

  CoinsListPage({super.key, required this.coins});

  @override
  State<CoinsListPage> createState() => _CoinsListPageState();
}

class _CoinsListPageState extends State<CoinsListPage> {
  List<Coins>? passedCoins;

  @override
  void initState() {
    passedCoins = widget.coins;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Financial Market', style: TextStyle(fontFamily: 'myFont')),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 52, 52, 52),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Color.fromARGB(255, 28, 28, 28),
      body: SafeArea(
          child: Column(
        children: [
          TextField(),
          Expanded(
            child: RefreshIndicator(
              color: Colors.white,
              backgroundColor: Color.fromARGB(255, 38, 252, 202),
              child: ListView.builder(
                itemCount: passedCoins!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(
                      passedCoins![index].rank.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Container(
                      width: 100,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  double.parse(passedCoins![index]
                                          .priceUsd
                                          .toString())
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                                Text(
                                  double.parse(
                                    passedCoins![index]
                                        .changePercent24Hr
                                        .toString(),
                                  ).toStringAsFixed(2),
                                  style: TextStyle(
                                      color: getBenefitOrDamageColor(
                                        double.parse(
                                          passedCoins![index]
                                              .changePercent24Hr
                                              .toString(),
                                        ),
                                      ),
                                      fontSize: 10),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            getBenefitOrDamageIcon(
                              double.parse(
                                passedCoins![index]
                                    .changePercent24Hr
                                    .toString(),
                              ),
                            ),
                          ]),
                    ),
                    title: Text(
                      passedCoins![index].name.toString(),
                      style:
                          TextStyle(color: Color.fromARGB(255, 38, 252, 202)),
                    ),
                  );
                },
              ),
              onRefresh: () {
                getFreshData();
                return Future<void>.delayed(
                  Duration(seconds: 3),
                );
              },
            ),
          ),
        ],
      )),
    );
  }

  Color getBenefitOrDamageColor(double price) {
    if (price > 0) {
      return Colors.green;
    } else if (price == 0) {
      return Colors.grey;
    } else {
      return Colors.red;
    }
  }

  Icon getBenefitOrDamageIcon(double price) {
    if (price > 0) {
      return Icon(
        Icons.arrow_upward_sharp,
        color: Colors.green,
      );
    } else if (price == 0) {
      return Icon(Icons.cabin);
    } else {
      return Icon(
        Icons.arrow_downward_sharp,
        color: Colors.red,
      );
    }
  }

  void getFreshData() async {
    Response res = await Dio().get('https://api.coincap.io/v2/assets');
    var data = res.data['data'];
    List<Coins> freshList = data
        .map<Coins>((jsonObject) => Coins.buildObjectFromJson(jsonObject))
        .toList();

    setState(() {
      passedCoins = freshList;
    });
  }
}
