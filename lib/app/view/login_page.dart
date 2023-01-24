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
  BoxConstraints constraints = const BoxConstraints();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 32, 32, 32),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    bottom: 50,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 10,
                            blurRadius: 10,
                          ),
                        ]),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              bottom: 20,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 200,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('img/icon_guts.png'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              left: 20,
                              right: 20,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 92, 188, 236),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: TextFormField(
                                onSaved: (value) => _username = value,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Usuário ADMIN',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  prefixIcon: Icon(Icons.person),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              left: 20,
                              right: 20,
                              bottom: 30,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 92, 188, 236),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: TextFormField(
                                onSaved: (value) => _password = value,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Senha 1234',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: ElevatedButton(
                              onPressed:
                                  _isButtonDisabled ? null : _checkCredentials,
                              child: const Text('Login'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
