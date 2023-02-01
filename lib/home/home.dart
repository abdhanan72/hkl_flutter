import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hakl/login/login.dart';
import 'package:hakl/salesReport/sales_report.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CustomerSummary/customersummary.dart';
import '../Itemsummary/itemsummary.dart';
import '../Itemsummary/model/itemsalesum.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void _showdialog() {
      showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title:  Text('Logout',
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
               SizedBox(
                height: 10.h,
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
                            Image.asset(
                              'assets/hklogo.png',
                              height: 90.h,
                              width: 90.h,
                            ),
                             SizedBox(
                              height: 15.h,
                            ),
                             Text(
                              'ADMIN POTATALLO',
                              style: TextStyle(
                                  color: const Color(0xff000080), fontSize: 25.sp),
                            )
                          ],
                        ),
                      ))),
               SizedBox(
                height: 30.h,
              ),
              Padding(
                padding:  EdgeInsets.all(2.r),
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
                        padding:  EdgeInsets.all(8.0.r),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/sales.png',
                              height: 80.h,
                              width: 80.w,
                            ),
                             SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'Sales Report',
                              style: TextStyle(
                                  color: Colors.grey.shade800, fontSize: 15.sp),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerSalesSummary())),
                      child: Padding(
                        padding:  EdgeInsets.all(10.r),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/target.png',
                              height: 80.h,
                              width: 80.w,
                            ),
                             SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'Customer Sales \nSummary',
                              style: TextStyle(color: Colors.grey.shade800,fontSize: 15.sp),
                              textAlign: TextAlign.center,
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context,MaterialPageRoute(builder:(context) => const ItemSalesSummary())),
                      child: Padding(
                        padding:  EdgeInsets.all(10.r),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/deliverybox.png',
                              height: 80.h,
                              width: 80.w,
                            ),
                             SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'Item \nSales Summary',
                              style: TextStyle(
                                  color: Colors.grey.shade800, fontSize: 15.sp),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(2.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(8.r),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/warehouse.png',
                            height: 80.h,
                            width: 80.w,
                          ),
                           SizedBox(
                            height: 10.h,
                          ),
                         Text(
                            'Current Stock \nReport',
                            style: TextStyle(
                                color: Colors.grey.shade800, fontSize: 15.sp),
                            textAlign: TextAlign.center,
                          ),
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
                        padding:  EdgeInsets.all(8.r),
                        child: Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(left: 10.r),
                              child: Image.asset(
                                'assets/logout.png',
                                height: 80.h,
                                width: 80.w,
                              ),
                            ),
                             SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'Logout',
                              style: TextStyle(
                                  color: Colors.grey.shade800, fontSize: 15.sp),
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
