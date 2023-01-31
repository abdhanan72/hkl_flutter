import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hakl/CustomerSummary/api2.dart';
import 'package:hakl/CustomerSummary/model/cusalesum.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerSalesSummary extends StatefulWidget {
  const CustomerSalesSummary({super.key});

  @override
  State<CustomerSalesSummary> createState() => _CustomerSalesSummaryState();
}

class _CustomerSalesSummaryState extends State<CustomerSalesSummary> {
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
               SizedBox(
                height: 30.h,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8.w),
                child: TextField(
                  controller: fromdate,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r)),
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
                height: 20.h,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8.w),
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
                height: 20.h,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                  },
                  child: const Text('Generate')),
              if (_isLoading)
                FutureBuilder<CustomerSummaryModel>(
                  future: fetchdata(
                      fid: firmId.toString(),
                      frdt: fromdate.text,
                      todt: todate.text,
                      t: ti),
                  builder: (BuildContext context,
                      AsyncSnapshot<CustomerSummaryModel> snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data?.data;

                      return Expanded(
                        child: SizedBox(
                          height: 200.h,
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
                                height: 80.h,
                                child: Container(
                                  height: 100.h,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                         SizedBox(
                                          height: 3.h,
                                          width: 345.w,
                                          child: const Divider(
                                            thickness: 1.3,
                                            color: Colors.black,
                                          ),
                                        ),
                                         SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(datum.custName),
                                         SizedBox(
                                          height: 8.h,
                                        ),
                                        Padding(
                                          padding:
                                               EdgeInsets.only(right: 3.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Amt: ${datum.invamt}"),
                                              Text("Cost: ${datum.cost}"),
                                              Padding(
                                                padding:  EdgeInsets.only(
                                                    right: 8.w),
                                                child: Text(
                                                    "Profit: ${datum.profit}"),
                                              ),
                                            ],
                                          ),
                                        ),
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
