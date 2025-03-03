import 'package:flutter/material.dart';
import 'package:moviebuddy/presentation/screens/enterance_screen.dart';
import 'package:moviebuddy/presentation/screens/home_screen.dart';

class RegistationScreen extends StatefulWidget {
  const RegistationScreen({super.key});

  @override
  State<RegistationScreen> createState() => _RegistationScreenState();
}

class _RegistationScreenState extends State<RegistationScreen> {
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
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EnteranceScreen()),
                    );
                  },
                  icon: Image.asset(
                    'assets/icons/arrow_back.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
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
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 325,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorsStyle.shadow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: textStyle.bodySmall,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 32.0,
                  ),
                  child: Text(
                    "Введите ваш ник:",
                    style: textStyle.bodyMedium,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: 325,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorsStyle.shadow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: textStyle.bodySmall,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 132.0,
                  ),
                  child: Text(
                    "Введите ваш пароль:",
                    style: textStyle.bodyMedium,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 325,
                  height: 50,
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorsStyle.shadow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: textStyle.bodySmall,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 132,
                  ),
                  child: Text(
                    "Повторите пароль:",
                    style: textStyle.bodyMedium,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 325,
                  height: 50,
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorsStyle.shadow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: textStyle.bodySmall,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(
                      170,
                      63,
                    ),
                    backgroundColor: colorsStyle.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      'Зарегистрироваться',
                      style: textStyle.displayMedium,
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
