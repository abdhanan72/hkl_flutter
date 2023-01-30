import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hakl/login/login.dart';
import 'package:hakl/salesReport/sales_report.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {


String? fullname;

@override
  void initState() {
    super.initState();
    _loadFullName();
  }

 _loadFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullname = prefs.getString('fullname');
    });
  }


  @override
  Widget build(BuildContext context) {
    void _showdialog() {
      showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Logout',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            content: Column(
              children: [
                Lottie.asset('assets/90919-logout.json'),
                const Text(
                  'Are you sure you want to logout?',
                )
              ],
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context, true);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: const Text('Yes'),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              )
            ],
          );
        },
      );
    }

    return Container(
      color: const Color(0xff000080),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
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
                             Text(
                              fullname!,
                              style: const TextStyle(
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
                              builder: (context) => const SalesReport(),
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
                            const SizedBox(
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
                          const SizedBox(
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
                          const SizedBox(
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
                          const SizedBox(
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
                    InkWell(
                      onTap: () async {
                        _showdialog();
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        await pref.clear();
                      },
                      child: Padding(
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
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Logout',
                              style: TextStyle(color: Colors.grey.shade800),
                            ),
                          ],
                        ),
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
