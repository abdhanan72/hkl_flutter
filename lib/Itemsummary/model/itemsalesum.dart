// To parse this JSON data, do
//
//     final itemSummaryModel = itemSummaryModelFromJson(jsonString);

import 'dart:convert';

ItemSummaryModel itemSummaryModelFromJson(String str) =>
    ItemSummaryModel.fromJson(json.decode(str));

String itemSummaryModelToJson(ItemSummaryModel data) =>
    json.encode(data.toJson());

class ItemSummaryModel {
  ItemSummaryModel({
    required this.responseCode,
    required this.responseDesc,
    required this.data,
  });

  int responseCode;
  String responseDesc;
  List<Datum> data;

  factory ItemSummaryModel.fromJson(Map<String, dynamic> json) =>
      ItemSummaryModel(
        responseCode: json["response_code"],
        responseDesc: json["response_desc"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_desc": responseDesc,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.the0,
    required this.the1,
    required this.the2,
    required this.the3,
    required this.the4,
    required this.the5,
    required this.itemCode,
    required this.itemName,
    required this.tqty,
    required this.amt,
    required this.cost,
    required this.margin,
  });

  String the0;
  String the1;
  String the2;
  String the3;
  String the4;
  String the5;
  String itemCode;
  String itemName;
  String tqty;
  String amt;
  String cost;
  String margin;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        the0: json["0"],
        the1: json["1"],
        the2: json["2"],
        the3: json["3"],
        the4: json["4"],
        the5: json["5"],
        itemCode: json["item_code"],
        itemName: json["item_name"],
        tqty: json["tqty"],
        amt: json["amt"],
        cost: json["cost"],
        margin: json["margin"],
      );

  Map<String, dynamic> toJson() => {
        "0": the0,
        "1": the1,
        "2": the2,
        "3": the3,
        "4": the4,
        "5": the5,
        "item_code": itemCode,
        "item_name": itemName,
        "tqty": tqty,
        "amt": amt,
        "cost": cost,
        "margin": margin,
      };
}
