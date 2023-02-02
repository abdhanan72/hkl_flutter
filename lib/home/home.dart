import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hakl/login/login.dart';
import 'package:hakl/salesReport/sales_report.dart';
import 'package:lottie/lottie.dart';
import '../CustomerSummary/customersummary.dart';
import '../Itemsummary/itemsummary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> _clearData() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    }

    void showdialog() {
      showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Logout',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
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
                  _clearData();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Login()));
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
          body:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: 25.h,
            ),
            Center(
              child: SizedBox(
                  height: 150.h,
                  width: 340.w,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 90.h,
                            width: 90.w,
                            child: Image.asset('assets/hklogo.png')),
                        Text(
                          'ADMIN POTATALLO',
                          style: TextStyle(
                              fontSize: 25.sp, color: const Color(0xff000080)),
                        )
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SalesReport(),
                        )),
                    child: const Menuitem(
                        imagePath: 'assets/sales.png', text: 'Sales Report')),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomerSalesSummary(),
                      )),
                  child: const Menuitem(
                      imagePath: 'assets/target.png',
                      text: 'Customer sales \n     Summary'),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ItemSalesSummary(),
                      )),
                  child: const Menuitem(
                      imagePath: 'assets/deliverybox.png',
                      text: 'Item Sales   \nSummary'),
                )
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Menuitem(
                    imagePath: 'assets/warehouse.png',
                    text: 'Current Stock \n      Report'),
                GestureDetector(
                    onTap: () {
                      showdialog();
                    },
                    child: const Menuitem(
                        imagePath: 'assets/logout.png', text: 'Logout'))
              ],
            )
          ]),
        ),
      ),
    );
  }
}

class Menuitem extends StatelessWidget {
  final String imagePath;
  final String text;

  const Menuitem({
    super.key,
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 60.h, width: 60.h, child: Image.asset(imagePath)),
        SizedBox(
          height: 6.h,
        ),
        Text(text)
      ],
    );
  }
}
