import 'package:flutter/material.dart';
import 'package:moviebuddy/presentation/screens/home_screen.dart';
import 'package:moviebuddy/presentation/screens/registration_screen.dart';

class EnteranceScreen extends StatefulWidget {
  const EnteranceScreen({super.key});

  @override
  State<EnteranceScreen> createState() => _EnteranceScreenState();
}

class _EnteranceScreenState extends State<EnteranceScreen> {
  @override
  Widget build(BuildContext context) {
    final colorsStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: const Color.fromRGBO(34, 34, 34, 1),
        centerTitle: true,
        toolbarHeight: 150,
        title: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Welcome to",
                style: textStyle.displayLarge,
              ),
              Text(
                "MovieBuddy!",
                style: textStyle.displayLarge,
              ),
            ],
          ),
        ),
      ),
      //backgroundColor: const Color.fromRGBO(34, 34, 34, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 89,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Впервые здесь?",
                  style: textStyle.bodyMedium,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistationScreen()),
                    );
                  },
                  child: Text(
                    "Зарегистрироваться!",
                    style: textStyle.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 59,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 132.0),
                  child: Text(
                    "Введите ваш email:",
                    style: textStyle.bodyLarge,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 325,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorsStyle.tertiary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: textStyle.bodyMedium,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 21),
                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: Text(
                    "Пароль:",
                    style: textStyle.bodyLarge,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 325,
                  height: 50,
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorsStyle.tertiary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: textStyle.bodyMedium,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 11),
                TextButton(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Text(
                      "Забыли пароль?",
                      style: textStyle.bodySmall,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
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
