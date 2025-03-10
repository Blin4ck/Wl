import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wl/anim/animated_route.dart';
import 'package:wl/page/singin_page.dart';
import 'package:wl/page/home_page.dart';

class Log extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LogState();
}

class _LogState extends State<Log> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isEmailError = false;
  bool _isPasswordError = false;
  bool _isLoading = false;

  void _validateFields() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    setState(() {
      _isEmailError = email.isEmpty;
      _isPasswordError = password.isEmpty;
    });

    if (email.isEmpty || password.isEmpty) {
      return;
    }

    await _signIn(email, password);
  }

  Future<void> _signIn(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session != null) {
        Navigator.of(context)
            .pushAndRemoveUntil(HomePage.route(), (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Простите, что-то не так!')),
        );
      }
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка авторизации: ${error.message}'),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Произошла непредвиденная ошибка: $error'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0, right: 20.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(40, 10),
                  bottomLeft: Radius.elliptical(40, 10),
                  topRight: Radius.elliptical(100, 90),
                  bottomRight: Radius.elliptical(100, 90),
                ),
              ),
              height: 350,
              width: 370,
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Поле ввода Email
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(fontFamily: 'nyashasans'),
                      errorText: _isEmailError ? 'Введите email' : null,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.black, width: 2.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),

                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontFamily: 'nyashasans'),
                      errorText: _isPasswordError ? 'Введите пароль' : null,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.black, width: 2.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            AnimatedRoute(page: RegPage()),
                            (route) => false,
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                        child: Text(
                          'Регистрация',
                          style: TextStyle(
                              fontFamily: 'nyashasans',
                              fontSize: 13.2,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      _isLoading
                          ? CircularProgressIndicator()
                          : TextButton(
                              onPressed: () {
                                _validateFields();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 24.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              child: Text(
                                'Вход',
                                style: TextStyle(
                                    fontFamily: 'nyashasans',
                                    fontSize: 13.2,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
