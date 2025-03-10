import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const ProfilePage());
  }

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
