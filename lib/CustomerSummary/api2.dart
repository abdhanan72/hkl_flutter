import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/cusalesum.dart';
Future<CustomerSummaryModel> fetchdata(
    {required String fid,
    required String frdt,
    required String todt,
    required String t}) async {
  final response = await http.get(Uri.parse(
      'http://hkal.dyndns.org:82/api/rep2.php?fid=$fid&frdt=$frdt&todt=$todt&t=$t'));

  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
    final customersales = CustomerSummaryModel.fromJson(responseJson);

    for (Datum datum in customersales.data) {
      print(datum.the0);
      print(datum.the1);
      print(datum.the2);
    }
    return customersales;
  } else {
    throw Exception('Failed to load data');
  }
}
