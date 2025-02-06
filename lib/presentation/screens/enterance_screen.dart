import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviebuddy/presentation/screens/registration_screen.dart';

import '../../main.dart';

class EnteranceScreen extends StatefulWidget {
  const EnteranceScreen({super.key});

  @override
  State<EnteranceScreen> createState() => _EnteranceScreenState();
}

class _EnteranceScreenState extends State<EnteranceScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Ошибка'),
            content: Text('Пожалуйста, заполните все поля.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ОК'),
              ),
            ],
          );
        },
      );
      return;
    }
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(34, 34, 34, 1),
        centerTitle: true,
        toolbarHeight: 150,
        title: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Welcome to",
                style: TextStyle(
                  fontFamily: 'Aldrich',
                  fontWeight: FontWeight.w400,
                  fontSize: 40,
                  color: const Color.fromRGBO(207, 220, 253, 1),
                ),
              ),
              Text(
                "MovieBuddy!",
                style: TextStyle(
                  fontFamily: 'Aldrich',
                  fontWeight: FontWeight.w400,
                  fontSize: 40,
                  color: const Color.fromRGBO(207, 220, 253, 1),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(34, 34, 34, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 89,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Впервые здесь?",
                  style: TextStyle(
                    fontFamily: 'Aldrich',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: const Color.fromRGBO(207, 220, 253, 1),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistationScreen()),
                    );
                  },
                  child: Text(
                    "Зарегистрироваться!",
                    style: TextStyle(
                      fontFamily: 'Aldrich',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: const Color.fromRGBO(207, 220, 253, 1),
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 59,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 132.0),
                  child: Text(
                    "Введите ваш email:",
                    style: TextStyle(
                      fontFamily: 'Aldrich',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: const Color.fromRGBO(207, 220, 253, 1),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 325,
                  height: 50,
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Aldrich',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color.fromRGBO(207, 220, 253, 1),
                    ),
                    validator: (value) {},
                  ),
                ),
                SizedBox(height: 21),
                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: Text(
                    "Пароль:",
                    style: TextStyle(
                      fontFamily: 'Aldrich',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: const Color.fromRGBO(207, 220, 253, 1),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  width: 325,
                  height: 50,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Aldrich',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Color.fromRGBO(207, 220, 253, 1),
                    ),
                    validator: (value) {},
                  ),
                ),
                SizedBox(height: 11),
                TextButton(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Text(
                      "Забыли пароль?",
                      style: TextStyle(
                        fontFamily: 'Aldrich',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: const Color.fromARGB(255, 240, 244, 255),
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            IconButton(
              onPressed: _signIn,
              icon: SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(
                  'assets/icons/arrow_2.png',
                  fit: BoxFit.contain,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
