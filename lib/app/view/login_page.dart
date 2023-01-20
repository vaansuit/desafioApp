import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../util/database_helper.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _password;
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                onSaved: (value) => _username = value,
                decoration: const InputDecoration(
                  labelText: 'Usuário ADMIN',
                ),
              ),
              TextFormField(
                onSaved: (value) => _password = value,
                decoration: const InputDecoration(
                  labelText: 'Senha 1234',
                ),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: _isButtonDisabled ? null : _checkCredentials,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkCredentials() async {
    _formKey.currentState!.save();
    _isButtonDisabled = true;
    final Database? db = await _databaseHelper.db;
    final List<Map> result = await db!.rawQuery(
        "SELECT * FROM user WHERE login = '$_username' AND pass = '$_password'");
    if (result.isNotEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      _isButtonDisabled = false;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro!'),
            content: const Text('Usuário e/ou senha inválido!'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
