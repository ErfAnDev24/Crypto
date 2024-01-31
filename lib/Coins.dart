class Coins {
  String? name;
  String? priceUsd;
  String? rank;
  String? changePercent24Hr;

  Coins(this.name, this.priceUsd, this.rank, this.changePercent24Hr);

  factory Coins.buildObjectFromJson(Map<String, dynamic> jsonObject) {
    return Coins(jsonObject['name'], jsonObject['priceUsd'], jsonObject['rank'],
        jsonObject['changePercent24Hr']);
  }
}
