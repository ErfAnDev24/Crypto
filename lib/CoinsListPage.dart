import 'package:crypto_project/Coins.dart';
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
      backgroundColor: Color.fromARGB(255, 28, 28, 28),
      body: SafeArea(
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
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [Text('Cost'), Text('Change')],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text('Sec2'),
                ]),
              ),
              title: Text(
                passedCoins![index].name.toString(),
                style: TextStyle(color: Color.fromARGB(255, 38, 252, 202)),
              ),
            );
          },
        ),
      ),
    );
  }
}
