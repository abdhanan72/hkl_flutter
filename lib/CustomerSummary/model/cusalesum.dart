// To parse this JSON data, do
//
//     final customerSummaryModel = customerSummaryModelFromJson(jsonString);

import 'dart:convert';

CustomerSummaryModel customerSummaryModelFromJson(String str) =>
    CustomerSummaryModel.fromJson(json.decode(str));

String customerSummaryModelToJson(CustomerSummaryModel data) =>
    json.encode(data.toJson());

class CustomerSummaryModel {
  CustomerSummaryModel({
    required this.responseCode,
    required this.responseDesc,
    required this.data,
  });

  int responseCode;
  String responseDesc;
  List<Datum> data;

  factory CustomerSummaryModel.fromJson(Map<String, dynamic> json) =>
      CustomerSummaryModel(
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
    required this.custName,
    required this.totamt,
    required this.vat,
    required this.invamt,
    required this.cost,
    required this.profit,
  });

  String the0;
  String the1;
  String the2;
  String the3;
  String the4;
  String the5;
  String custName;
  String totamt;
  String vat;
  String invamt;
  String cost;
  String profit;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        the0: json["0"],
        the1: json["1"],
        the2: json["2"],
        the3: json["3"],
        the4: json["4"],
        the5: json["5"],
        custName: json["cust_name"],
        totamt: json["totamt"],
        vat: json["vat"],
        invamt: json["invamt"],
        cost: json["cost"],
        profit: json["profit"],
      );

  Map<String, dynamic> toJson() => {
        "0": the0,
        "1": the1,
        "2": the2,
        "3": the3,
        "4": the4,
        "5": the5,
        "cust_name": custName,
        "totamt": totamt,
        "vat": vat,
        "invamt": invamt,
        "cost": cost,
        "profit": profit,
      };
}
