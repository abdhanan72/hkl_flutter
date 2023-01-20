// To parse this JSON data, do
//
//     final reportsales = reportsalesFromJson(jsonString);

import 'dart:convert';

Reportsales reportsalesFromJson(String str) =>
    Reportsales.fromJson(json.decode(str));

String reportsalesToJson(Reportsales data) => json.encode(data.toJson());

class Reportsales {
  Reportsales({
    required this.responseCode,
    required this.responseDesc,
    required this.data,
  });

  int responseCode;
  String responseDesc;
  List<Datum> data;

  factory Reportsales.fromJson(Map<String, dynamic> json) => Reportsales(
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
    required this.the6,
    required this.the7,
    required this.the8,
    required this.the9,
    required this.invnumber,
    required this.gstinv,
    required this.datex,
    required this.stpCode,
    required this.custName,
    required this.totamt,
    required this.gst,
    required this.invamt,
    required this.cost,
    required this.profit,
  });

  String the0;
  String the1;
  DateTime the2;
  String the3;
  String the4;
  String the5;
  String the6;
  String the7;
  String the8;
  String the9;
  String invnumber;
  String gstinv;
  DateTime datex;
  String stpCode;
  String custName;
  String totamt;
  String gst;
  String invamt;
  String cost;
  String profit;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        the0: json["0"],
        the1: json["1"],
        the2: DateTime.parse(json["2"]),
        the3: json["3"],
        the4: json["4"],
        the5: json["5"],
        the6: json["6"],
        the7: json["7"],
        the8: json["8"],
        the9: json["9"],
        invnumber: json["invnumber"],
        gstinv: json["gstinv"],
        datex: DateTime.parse(json["datex"]),
        stpCode: json["stp_code"],
        custName: json["cust_name"],
        totamt: json["totamt"],
        gst: json["gst"],
        invamt: json["invamt"],
        cost: json["cost"],
        profit: json["profit"],
      );

  Map<String, dynamic> toJson() => {
        "0": the0,
        "1": the1,
        "2": the2.toIso8601String(),
        "3": the3,
        "4": the4,
        "5": the5,
        "6": the6,
        "7": the7,
        "8": the8,
        "9": the9,
        "invnumber": invnumber,
        "gstinv": gstinv,
        "datex": datex.toIso8601String(),
        "stp_code": stpCode,
        "cust_name": custName,
        "totamt": totamt,
        "gst": gst,
        "invamt": invamt,
        "cost": cost,
        "profit": profit,
      };
}
