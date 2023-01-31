import 'package:flutter/material.dart';
import 'package:hakl/Itemsummary/api3.dart';
import 'package:hakl/Itemsummary/model/itemsalesum.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemSalesSummary extends StatefulWidget {
  const ItemSalesSummary({super.key});

  @override
  State<ItemSalesSummary> createState() => _ItemSalesSummaryState();
}

class _ItemSalesSummaryState extends State<ItemSalesSummary> {
  TextEditingController fromdate = TextEditingController(),
      todate = TextEditingController();
  String ti = DateTime.now().millisecondsSinceEpoch.toString();
  String? firmId;
  bool _isLoading = false;
  List<Datum> data = [];
  int? dataLength;
  Future<String?> getFirmId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? firmId = await prefs.getString('firm_id');
    return firmId;
  }

  @override
  void initState() {
    super.initState();
    getFirmId().then((value) {
      setState(() {
        firmId = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff000080),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: fromdate,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.calendar_today_outlined),
                      labelText: 'From Date'),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickdate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100));

                    if (pickdate != null) {
                      String formateddate =
                          DateFormat("yyyy-MM-dd").format(pickdate);
                      setState(() {
                        fromdate.text = formateddate.toString();
                      });
                    } else {}
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: todate,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.calendar_today_outlined),
                      labelText: 'To Date'),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickeddate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100));

                    if (pickeddate != null) {
                      String formatdate =
                          DateFormat("yyyy-MM-dd").format(pickeddate);
                      setState(() {
                        todate.text = formatdate.toString();
                      });
                    } else {
                      print('Invalid date');
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                  },
                  child: const Text('Generate')),
              if (_isLoading)
                FutureBuilder<ItemSummaryModel>(
                  future: fetchdata(
                      fid: firmId.toString(),
                      frdt: fromdate.text,
                      todt: todate.text,
                      t: ti),
                  builder: (BuildContext context,
                      AsyncSnapshot<ItemSummaryModel> snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data?.data;

                      return Expanded(
                        child: SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              final Datum datum = data[index];
                              // return ListTile(
                              //   title: Text(datum.the0),
                              //   subtitle: Text(datum.the1),
                              //   trailing: Text(datum.custName),
                              // );
                              return SizedBox(
                                height: 100,
                                child: Container(
                                  height: 110,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 3,
                                          width: 345,
                                          child: Divider(
                                            thickness: 1.3,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text("#: ${datum.itemCode}"),
                                      const   SizedBox(height: 5,),
                                        Text(datum.itemName),
                                       const  SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          
                                          children: [
                                            Text("Qty: ${datum.tqty}"),
                                            const SizedBox(width: 65,),
                                            Text("Amt: ${datum.amt}")
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Text("Cost: ${datum.cost}"),
                                            const SizedBox(
                                              width: 65,
                                            ),
                                            Text("Margin: ${datum.margin}"),
                                          ],
                                        )
                                        
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Text("Not a valid date ");
                    }
                    return const CircularProgressIndicator();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
