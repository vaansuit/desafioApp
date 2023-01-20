import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Login'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: const [
                Icon(Icons.abc),
                SizedBox(
                  width: 10,
                ),
                Text('Login'),
                SizedBox(
                  width: 30,
                ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      helperText: 'Usuario ADMIN',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: const [
                Icon(Icons.abc),
                SizedBox(
                  width: 10,
                ),
                Text('Senha'),
                SizedBox(
                  width: 30,
                ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      helperText: 'Senha 1234',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
