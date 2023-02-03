import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    var mediaquery = MediaQuery.of(context);
    return Container(
      color: const Color(0xff000080),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
               SizedBox(
                height: mediaquery.size.height * 0.04,
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: fromdate,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              12)),
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
               SizedBox(
                height: mediaquery.size.height * 0.04
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: todate,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r)),
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
               SizedBox(
                height: mediaquery.size.height * 0.04,
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
                              height: mediaquery.size.height*0.15,
                              child: Padding(
                                padding:  EdgeInsets.only(left: mediaquery.size.width*0.02,right:mediaquery.size.width*0.02, ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                     SizedBox(
                                      height: mediaquery.size.height*0.01,
                                      width: mediaquery.size.width*0.95,
                                      child:  Divider(
                                        thickness: mediaquery.size.height * 0.00125,
                                        color: Colors.black,
                                      ),
                                      
                                    ),
                                    SizedBox(height:mediaquery.size.height*0.01),
                                    Text("#: ${datum.itemCode}",
                                        style: TextStyle(
                                            fontSize:
                                                mediaquery.size.height * 0.018)),
                                     SizedBox(height: mediaquery.size.height*0.01,),
                                    Text(datum.itemName,
                                        style: TextStyle(
                                            fontSize:
                                                mediaquery.size.height * 0.018)),
                                     SizedBox(
                                      height: mediaquery.size.height * 0.01
                                    ),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      
                                      children: [
                                        Text("Qty: ${datum.tqty}",
                                            style: TextStyle(
                                                fontSize:
                                                    mediaquery.size.height *
                                                        0.018)),
                                         
                                        Text("Amt: ${datum.amt}",
                                            style: TextStyle(
                                                fontSize:
                                                    mediaquery.size.height *
                                                        0.018))
                                      ],
                                    ),
                                     SizedBox(
                                      height: mediaquery.size.height * 0.01
                                    ),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Cost: ${datum.cost}",
                                            style: TextStyle(
                                                fontSize:
                                                    mediaquery.size.height *
                                                        0.018)),
                                         
                                        Text("Margin: ${datum.margin}",
                                            style: TextStyle(
                                                fontSize:
                                                    mediaquery.size.height *
                                                        0.018)),
                                      ],
                                    )
                                    
                                  ],
                                ),
                              ),
                            );
                          },
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
