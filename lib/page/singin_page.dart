import 'package:flutter/material.dart';
import 'package:wl/page/authorization/reg.dart';
import '../anim/my_custom_painter.dart';

class RegPage extends StatefulWidget {
  const RegPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const RegPage());
  }

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<RegPage> {
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
          Reg()
        ],
      ),
    );
  }
}
