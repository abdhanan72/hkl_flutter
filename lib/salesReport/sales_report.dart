
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalesReport extends StatefulWidget {
  const SalesReport({super.key});

  @override
  State<SalesReport> createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {
  TextEditingController fromdate = TextEditingController(),
      todate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff000080),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
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
                              DateFormat("dd-MM-yyyy").format(pickdate);
                          setState(() {
                            fromdate.text = formateddate.toString();
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
                          String formatdate = DateFormat("dd-MM-yyyy").format(pickeddate);
                          setState(() {
                            todate.text = formatdate.toString();
                          });
                        } else {
                          print('Invalid date');
                        }
                      },
                    ),
                  ),
                 const SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Generate'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
