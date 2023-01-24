import 'package:desafio_app/app/view/widgets/add_client.dart';
import 'package:desafio_app/app/view/widgets/add_product.dart';
import 'package:desafio_app/app/view/widgets/shopping_cart.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const SizedBox(
                height: 58,
                child: DrawerHeader(
                  margin: EdgeInsets.only(
                    bottom: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Olá, ADMIN'),
                ),
              ),
              ListTile(
                title: const Text('Cadastro de produto'),
                onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return const AddProduct();
                    }),
              ),
              ListTile(
                title: const Text('Cadastro de clientes'),
                onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return const AddClient();
                    }),
              ),
              ListTile(
                title: const Text('Realizar venda'),
                onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return const ShoppingCart();
                    }),
              ),
              ListTile(
                title: const Text('Histórico de vendas'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ShowSale()),
                  );
                },
              ),
              ListTile(
                title: const Text('Sincronizar'),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Sincronizado com sucesso!'),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
              ListTile(
                title: const Text('Deletar banco de dados'),
                onTap: () async {
                  await _databaseHelper.deleteDb();
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            children: const [],
          ),
        ),
      ),
    );
  }
}
