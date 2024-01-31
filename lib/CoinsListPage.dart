import 'package:crypto_project/Coins.dart';
import 'package:flutter/material.dart';

class CoinsListPage extends StatefulWidget {
  List<Coins> coins;

  CoinsListPage({super.key, required this.coins});

  @override
  State<CoinsListPage> createState() => _CoinsListPageState();
}

class _CoinsListPageState extends State<CoinsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text('ErfAn'),
      ),
    );
  }
}
