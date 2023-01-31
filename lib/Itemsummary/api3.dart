import 'dart:convert';


import 'package:http/http.dart' as http;

import 'model/itemsalesum.dart';

Future<ItemSummaryModel> fetchdata(
    {required String fid,
    required String frdt,
    required String todt,
    required String t}) async {
  final response = await http.get(Uri.parse(
      'http://hkal.dyndns.org:82/api/rep3.php?fid=$fid&frdt=$frdt&todt=$todt&t=$t'));

  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
    final itemsummary = ItemSummaryModel.fromJson(responseJson);

    for (Datum datum in itemsummary.data) {
      print(datum.the0);
      print(datum.the1);
      print(datum.the2);
    }
    return itemsummary;
  } else {
    throw Exception('Failed to load data');
  }
}
