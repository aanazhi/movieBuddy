import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/presentation/screens/home_screen.dart';
import 'package:moviebuddy/presentation/screens/registration_screen.dart';
import 'package:moviebuddy/provider/providers.dart';

class EnteranceScreen extends ConsumerWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  EnteranceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorsStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final loginUseCase = ref.watch(loginRegisterProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorsStyle.primary,
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
      backgroundColor: colorsStyle.primary,
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
                          builder: (context) => RegistationScreen()),
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
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorsStyle.tertiary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: textStyle.labelLarge,
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
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorsStyle.tertiary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: textStyle.labelLarge,
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
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;
                try {
                  final result = await loginUseCase.execute(email, password);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                } on FirebaseAuthException catch (error) {
                  if (error.code == 'user-not-found') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: colorsStyle.onPrimary,
                        content: Text(
                          'Пользователь не найден',
                          style: textStyle.bodyMedium,
                        ),
                      ),
                    );
                  } else if (error.code == 'invalid-email') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: colorsStyle.onPrimary,
                        content: Text(
                          'Неккоректный email',
                          style: textStyle.bodyMedium,
                        ),
                      ),
                    );
                  } else if (error.code == 'wrong-password') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: colorsStyle.onPrimary,
                        content: Text(
                          'Неправильный пароль',
                          style: textStyle.bodyMedium,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: colorsStyle.onPrimary,
                        content: Text(
                          'Ошибка входа',
                          style: textStyle.bodyMedium,
                        ),
                      ),
                    );
                  }
                }
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
