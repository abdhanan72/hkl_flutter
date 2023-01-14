import 'package:flutter/material.dart';
import 'package:hakl/salesReport/sales_report.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff000080),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                  child: SizedBox(
                      height: 150,
                      width: 340,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/hklogo.png',
                              height: 90,
                              width: 90,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'ADMIN POTATALLO',
                              style: TextStyle(
                                  color: Color(0xff000080), fontSize: 25),
                            )
                          ],
                        ),
                      ))),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(17.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SalesReport(),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/sales.png',
                              height: 80,
                              width: 80,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Sales Report',
                              style: TextStyle(color: Colors.grey.shade800),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/target.png',
                            height: 80,
                            width: 80,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Customer',
                            style: TextStyle(color: Colors.grey.shade800),
                          ),
                          Text(
                            'Sales Summary',
                            style: TextStyle(color: Colors.grey.shade800),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/deliverybox.png',
                            height: 80,
                            width: 80,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Customer',
                            style: TextStyle(color: Colors.grey.shade800),
                          ),
                          Text(
                            'Sales Summary',
                            style: TextStyle(color: Colors.grey.shade800),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/warehouse.png',
                            height: 80,
                            width: 80,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Current Stock',
                            style: TextStyle(color: Colors.grey.shade800),
                          ),
                          Text(
                            'Report',
                            style: TextStyle(color: Colors.grey.shade800),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Image.asset(
                              'assets/logout.png',
                              height: 80,
                              width: 80,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(color: Colors.grey.shade800),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
