import 'package:desafio_app/app/util/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class AddClient extends StatefulWidget {
  const AddClient({Key? key}) : super(key: key);

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final _formKey = GlobalKey<FormState>();
  String? _clientName;
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  void _addClient() async {
    _formKey.currentState?.save();
    final Database? db = await _databaseHelper.db;

    await db
        ?.rawInsert("INSERT INTO client(clientName) VALUES('$_clientName')");
  }

  void _showClient() async {
    final Database? db = await _databaseHelper.db;
    final List<Map> result = await db!.rawQuery("SELECT * FROM client");
    print(result);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text("Adicione um cliente!"),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Nome do Cliente'),
                ),
                onSaved: (value) => _clientName = value,
              ),
              ElevatedButton(
                  child: const Text("Adicionar"),
                  onPressed: () {
                    _addClient();
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        ),
      );
}
