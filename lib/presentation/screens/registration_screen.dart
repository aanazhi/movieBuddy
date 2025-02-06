import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviebuddy/main.dart';
import 'package:moviebuddy/presentation/screens/enterance_screen.dart';

class RegistationScreen extends StatefulWidget {
  const RegistationScreen({super.key});

  @override
  State<RegistationScreen> createState() => _RegistationScreenState();
}

class _RegistationScreenState extends State<RegistationScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void register() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        nicknameController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ошибка'),
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
    if (passwordController.text != confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Пароли не совпадают!"),
          );
        },
      );
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );

      print("Пользователь зарегистрирован: ${userCredential.user?.uid}");
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message ?? "Ошибка регистрации"),
          );
        },
      );
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
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EnteranceScreen()),
                    );
                  },
                  icon: Image.asset(
                    'assets/icons/arrow_back.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
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
                    "Введите ваш ник:",
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
                    controller: nicknameController,
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
                  padding: const EdgeInsets.only(right: 132.0),
                  child: Text(
                    "Введите ваш пароль:",
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
                SizedBox(height: 21),
                Padding(
                  padding: const EdgeInsets.only(right: 132.0),
                  child: Text(
                    "Повторите пароль:",
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
                    controller: confirmPasswordController,
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
                SizedBox(height: 21),
                ElevatedButton(
                  onPressed: () {
                    register();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(170, 63),
                    backgroundColor: Color.fromRGBO(74, 125, 255, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      'Зарегистрироваться',
                      style: TextStyle(
                        fontFamily: 'Aldrich',
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                        color: const Color.fromRGBO(207, 220, 253, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
