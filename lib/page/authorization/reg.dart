import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wl/anim/animated_route.dart';
import 'package:wl/page/login_page.dart';
import 'package:wl/page/profile_page.dart';

class Reg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegState();
}

class _RegState extends State<Reg> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String password2 = _passwordController2.text.trim();

      if (password != password2) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Пароли не совпадают!')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        await Supabase.instance.client.auth.signUp(
          email: email,
          password: password,
        );
        _emailController.clear();
        _passwordController.clear();
        _passwordController2.clear();

        Navigator.of(context)
            .pushAndRemoveUntil(ProfilePage.route(), (route) => false);
      } on AuthException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: ${error.message}')),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Неизвестная ошибка!')),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 45.0, right: 20.0),
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
              height: 440,
              width: 400,
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontFamily: 'nyashasans'),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.5),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),

                    // Поле ввода Пароля
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Пароль',
                        labelStyle: TextStyle(fontFamily: 'nyashasans'),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.5),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите пароль';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),

                    // Поле ввода Повторного Пароля
                    TextFormField(
                      controller: _passwordController2,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Повторите пароль',
                        labelStyle: TextStyle(fontFamily: 'nyashasans'),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.5),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Повторите пароль';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),

                    // Кнопка "Регистрация"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (_isLoading)
                          CircularProgressIndicator()
                        else
                          TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _signUp();
                              }
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

                        // Кнопка "Вход"
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              AnimatedRoute(page: LoginPage()),
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
                            'Вход',
                            style: TextStyle(
                                fontFamily: 'nyashasans',
                                fontSize: 13.2,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
