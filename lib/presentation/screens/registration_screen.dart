import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/domain/user_entity/user_entity.dart';
import 'package:moviebuddy/presentation/screens/enterance_screen.dart';
import 'package:moviebuddy/presentation/screens/home_screen.dart';
import 'package:moviebuddy/provider/providers.dart';
import 'package:uuid/uuid.dart';

class RegistationScreen extends ConsumerWidget {
  final _emailController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordTwoController = TextEditingController();
  RegistationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorsStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final loginUseCase = ref.watch(loginRegisterProvider);
    //final saveUsersOnRegProvider = ref.watch(saveUserProvider);

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
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorsStyle.shadow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: textStyle.bodyMedium,
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
                    controller: _nicknameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorsStyle.shadow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: textStyle.bodyMedium,
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
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorsStyle.shadow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: textStyle.bodyMedium,
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
                    controller: _passwordTwoController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorsStyle.shadow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: textStyle.bodyMedium,
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final email = _emailController.text;
                    final nickname = _nicknameController.text;
                    final password = _passwordController.text;
                    final passwordTwo = _passwordTwoController.text;

                    if (password != passwordTwo) {
                      SnackBar(
                        backgroundColor: colorsStyle.onPrimary,
                        content: Text(
                          'Пароли не соответсвуют',
                          style: textStyle.bodyMedium,
                        ),
                      );
                    }
                    try {
                      await loginUseCase.reg(email, password);

                      const uuid = Uuid();
                      final id = uuid.v4();
                      // ignore: unused_local_variable
                      final user = UserEntity(
                        id: id,
                        email: email,
                        nickname: nickname,
                        photo: '',
                        movieCollections: [],
                      );

                      // await saveUsersOnRegProvider.call(user);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    } on FirebaseAuthException catch (error) {
                      if (error.code == 'invalid-email') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: colorsStyle.onPrimary,
                            content: Text(
                              'Некорректный email',
                              style: textStyle.bodyMedium,
                            ),
                          ),
                        );
                      } else if (error.code == 'email-already-in-use') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: colorsStyle.onPrimary,
                            content: Text(
                              'Пользователь с данным email уже существует',
                              style: textStyle.bodyMedium,
                            ),
                          ),
                        );
                      } else if (error.code == 'weak-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: colorsStyle.onPrimary,
                            content: Text(
                              'Ненадежный пароль',
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
