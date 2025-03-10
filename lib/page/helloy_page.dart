import 'package:flutter/material.dart';
import 'package:wl/anim/animated_route.dart';
import 'package:wl/page/login_page.dart';

class Helloy extends StatefulWidget {
  const Helloy({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const Helloy());
  }

  @override
  State<StatefulWidget> createState() => HelloyState();
}

class HelloyState extends State<Helloy> {
  int _currentIndex = 0;
  int _currentIndex2 = 0;

  final List<String> _texts = [
    'Музыка — это универсальный язык любви. Каждый трек, каждая нота способна рассказать о нас больше, чем тысячи слов. Какие мелодии заставляют ваше сердце биться чаще?',
    'Мы уверены, что музыка способна соединять сердца. Расскажите о своих любимых исполнителях, предпочтительных жанрах или особенных композициях — это станет первым шагом на вашем пути к необычным и значимым встречам.',
    'Добро пожаловать в Wave Love! Здесь каждый найдет свою волну и человека, который будет созвучен вашей душе. Погрузитесь в мир, где музыка становится ключом к настоящим чувствам.',
  ];

  final List<String> _textButen = [
    'У понятно',
    'Обязательно расскажу!',
    'Начнем!'
  ];

  void _switchText() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _texts.length;
      _currentIndex2 = (_currentIndex2 + 1) % _textButen.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3F51B5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              final offsetAnimation = Tween<Offset>(
                begin: Offset(1.0, 0.0),
                end: Offset(0.0, 0.0),
              ).animate(animation);

              return SlideTransition(position: offsetAnimation, child: child);
            },
            child: Center(
              child: Container(
                key: ValueKey<int>(
                    _currentIndex), // Уникальный ключ для анимации
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    _texts[_currentIndex],
                    style: TextStyle(fontSize: 24, fontFamily: 'Rockwell'),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_currentIndex2 == 2) {
                  Navigator.of(context).pushAndRemoveUntil(
                    AnimatedRoute(page: LoginPage()),
                    (route) => false,
                  );
                } else {
                  _switchText();
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              child: Text(
                _textButen[_currentIndex2],
                key: ValueKey<int>(_currentIndex2),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'nyashasans'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
