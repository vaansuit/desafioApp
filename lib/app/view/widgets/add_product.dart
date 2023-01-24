import 'package:desafio_app/app/util/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String? _productName;
  String? _code;
  double? _price;
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  void _addProduct() async {
    _formKey.currentState?.save();
    final Database? db = await _databaseHelper.db;

    await db?.rawInsert(
        "INSERT INTO product(itemName, itemCode, itemPrice) VALUES('$_productName', '$_code', '$_price')");
  }

  void _showProducts() async {
    final Database? db = await _databaseHelper.db;
    final List<Map> result = await db!.rawQuery("SELECT * FROM product");
    print(result);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text("Adicione um produto!"),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Nome do produto'),
                ),
                onSaved: (value) => _productName = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Código do produto'),
                ),
                onSaved: (value) => _code = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Preço do produto'),
                ),
                onSaved: (value) => _price = double.parse(value.toString()),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                  child: const Text("Adicionar"),
                  onPressed: () {
                    _addProduct();
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        ),
      );
}
