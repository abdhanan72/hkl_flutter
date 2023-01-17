import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hakl/home/home.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:open_settings/open_settings.dart';
import 'package:lottie/lottie.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hasinternet = false;
  bool _obscuretext = true;
  void _toggle() {
    setState(() {
      _obscuretext = !_obscuretext;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child:
                    Image.asset('assets/hklogo.png', height: 150, width: 150),
              )),
              SizedBox(
                  height: 350,
                  width: 310,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Center(
                              child: Padding(
                            padding: EdgeInsets.only(top: 25.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          )),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                                decoration: InputDecoration(
                                    labelText: 'Username',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color(0xff000080),
                                      width: 1,
                                    )))),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
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
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color(0xff000080),
                                      width: 1,
                                    )))),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                hasinternet = await InternetConnectionChecker()
                                    .hasConnection;

                                if (hasinternet == false) {
                                  _showdialog();
                                } else {
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HomePage(),
                                      ));
                                }
                              },
                              child: const Text('SIGN IN'))
                        ],
                      ))),
              Image.asset(
                'assets/splogo.png',
                height: 180,
                width: 180,
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
          title: Lottie.asset('assets/45721-no-internet.json',width: 100,height: 100),
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
