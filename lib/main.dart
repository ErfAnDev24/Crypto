import 'package:crypto_project/Coins.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
      ),
    );
  }

  void getData() async {
    Response response = await Dio().get('https://api.coincap.io/v2/assets');

    if (response.statusCode == 200) {
      var data = response.data['data'];

      List<Coins> coins = data
          .map<Coins>((jsonObject) => Coins.buildObjectFromJson(jsonObject))
          .toList();

      for (int i = 0; i < coins.length; i++) {
        print(coins[i].name);
      }
    } else {
      print('request has been blocked!');
    }
  }
}
