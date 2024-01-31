import 'package:crypto_project/Coins.dart';
import 'package:crypto_project/CoinsListPage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Coins>? coinList;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(79, 72, 72, 72),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 180,
              height: 180,
              child: Image(
                image: AssetImage('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SpinKitWave(size: 45, color: Color.fromARGB(255, 6, 255, 201)),
          ],
        ),
      ),
    );
  }

  Future<void> getData() async {
    Response response = await Dio().get('https://api.coincap.io/v2/assets');

    var data = response.data['data'];

    List<Coins> coins = data
        .map<Coins>((jsonObject) => Coins.buildObjectFromJson(jsonObject))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoinsListPage(coins: coins),
      ),
    );
  }
}
