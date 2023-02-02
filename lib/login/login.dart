// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hakl/home/home.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:open_settings/open_settings.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool hasinternet = false;
  bool _obscuretext = true;
  void _toggle() {
    setState(() {
      _obscuretext = !_obscuretext;
    });
  }

  late String unm, pwd;

  late SharedPreferences prefs;

  void _saveForm(http.Response response) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', unm);
      await prefs.setString('password', pwd);
      var jsonData = jsonDecode(response.body);
      if (jsonData["response_code"] == 27) {
        var fid = jsonData["data"]["firm_id"];
        await prefs.setString('firm_id', fid);
        var fullname = jsonData["data"]["fullname"];
        await prefs.setString('fullname', fullname);
      }
      await prefs.setBool('isLoggedIn', true);
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
    
  }

  Future<void> checkLogin() async {
    if (await isLoggedIn()) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    }
  }

  Future<bool> isLoggedIn() async {
    prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }

  Future<void> saveResponseToSharedPreferences(String responseBody) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('data', responseBody);
  }

  Future<http.Response> login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var url = Uri.parse(
          'http://hkal.dyndns.org:82/api/alogin.php?unm=$unm&pwd=$pwd');
      final response = await http.get(url);
      return response;
    } else {
      return Future.value(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset('assets/hklogo.png', height: 120.h, width: 120.w)),

                  
              SizedBox(
                  height: 360.h,
                  width: 310.w,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                      elevation: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           Center(
                              child: Padding(
                            padding: EdgeInsets.only(top: 25.h),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25.sp),
                            ),
                          )),
                           SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding:
                                 EdgeInsets.symmetric(horizontal: 10.w),
                            child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter a username';
                                  }
                                  return null;
                                },
                                onSaved: (value) => unm = value!,
                                decoration:  InputDecoration(
                                    labelText: 'Username',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: const Color(0xff000080),
                                      width: 1.w,
                                    )))),
                          ),
                           SizedBox(
                            height: 30.h,
                          ),
                          Padding(
                            padding:
                                 EdgeInsets.symmetric(horizontal: 10.w),
                            child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  return null;
                                },
                                onSaved: (value) => pwd = value!,
                                obscureText: _obscuretext,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscuretext
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.visibility_off,
                                        color: const Color(0xff000080),
                                      ),
                                      onPressed: _toggle,
                                    ),
                                    labelText: 'Password',
                                    border:  OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: const Color(0xff000080),
                                      width: 1.w,
                                    )))),
                          ),
                           SizedBox(
                            height: 30.h,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              hasinternet = await InternetConnectionChecker()
                                  .hasConnection;

                              if (hasinternet == false) {
                                _showdialog();
                              }

                              final response = await login();

                              if (response.statusCode == 200) {
                                final responseBody =
                                    jsonDecode(response.body);
                                if (responseBody['response_code'] == 27) {
                                    var fullname = responseBody["data"]["fullname"];
        await prefs.setString('fullname', fullname);
                                  _saveForm(response);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage(),
                                      ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text(responseBody['response_desc']),
                                  ));
                                }
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Login Failed'),
                                ));
                              }
                            },
                            child: const Text('Login'),
                          )
                        ],
                      ))),
              Image.asset(
                'assets/splogo.png',
                height: 150.h,
                width: 150.w,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showdialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Lottie.asset('assets/45721-no-internet.json',
              width: 100, height: 100),
          content:
              const Text('Please check your internet connection and try again'),
          actions: [
            MaterialButton(
              onPressed: () {
                OpenSettings.openNetworkOperatorSetting();
              },
              child: const Text('Turn on mobile data'),
            ),
            MaterialButton(
              onPressed: () {
                OpenSettings.openWIFISetting();
              },
              child: const Text('Turn on wifi'),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
