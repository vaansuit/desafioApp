import 'package:desafio_app/app/view/widgets/add_client.dart';
import 'package:desafio_app/app/view/widgets/add_product.dart';
import 'package:desafio_app/app/view/widgets/show_sale.dart';
import 'package:flutter/material.dart';

import '../util/database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return const AddProduct();
                      }),
                  child: const Text('Cadastro Produto'),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return const AddClient();
                      }),
                  child: const Text('Cliente'),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ShowSale()),
                    );
                  },
                  child: const Text('Vendas'),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Sincronizar'),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await _databaseHelper.deleteDb();
                  },
                  child: const Text('Deletar base de dados'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
