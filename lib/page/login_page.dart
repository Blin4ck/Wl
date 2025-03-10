import 'package:flutter/material.dart';
import 'package:wl/page/authorization/log.dart';
import '../anim/my_custom_painter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const LoginPage());
  }

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF3F51B5),
              border: Border.all(color: Colors.black),
            ),
          ),
          BatmanCon(),
          Log()
        ],
      ),
    );
  }
}
