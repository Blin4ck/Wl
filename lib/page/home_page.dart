import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const HomePage());
  }

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center());
  }
}
