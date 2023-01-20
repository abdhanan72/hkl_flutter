import 'dart:convert';

import 'package:hakl/salesReport/report_sales/report_sales.dart';
import 'package:http/http.dart' as http;

Future<Reportsales> fetchdata(
    {required String fid,
    required String frdt,
    required String todt,
    required String t}) async {
  final response = await http.get(Uri.parse(
      'http://hkal.dyndns.org:82/api/rep1.php?fid=$fid&frdt=$frdt&todt=$todt&t=$t'));

  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
    final reportsales = Reportsales.fromJson(responseJson);

    for (Datum datum in reportsales.data) {
      print(datum.the0);
      print(datum.the1);
      print(datum.the2);
    }
    return reportsales;
  } else {
    throw Exception('Failed to load data');
  }
}

