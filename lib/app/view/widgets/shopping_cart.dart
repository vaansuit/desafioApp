import 'package:flutter/material.dart';

import '../../util/database_helper.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  State<ShoppingCart> createState() => _AddProductState();
}

class _AddProductState extends State<ShoppingCart> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedCustomer;
  List<String>? _customers;
  List<String>? _products;
  String? _selectedProduct;
  double _price = 0;
  int _quantity = 0;
  double _totalInvoice = 0;

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _getCustomers();
    _getProduct();
  }

  @override
  void _getCustomers() async {
    final List<Map<String, dynamic>> clients =
        await _databaseHelper.getClient();
    final Set<String> customers =
        Set.from(clients.map((client) => client['clientName']));
    setState(() {
      _customers = customers.toList();
    });
  }

  void _getProduct() async {
    final List<Map<String, dynamic>> items =
        await _databaseHelper.selectItemName();

    final Set<String> products =
        Set.from(items.map((product) => product['itemName']));
    setState(() {
      _products = products.toList();
    });
  }

  void _calculateTotalInvoice() {
    setState(() {
      _totalInvoice = _price * _quantity;
    });
  }

  Future<void> saveSale(String customerName, String itemName, double itemPrice,
      int quantity, double totalInvoice) async {
    final db = await _databaseHelper.db;
    await db!.rawInsert(
        'INSERT INTO sale (customerName, itemName, itemPrice, quantity, totalInvoice) VALUES (?, ?, ?, ?, ?)',
        [customerName, itemName, itemPrice, quantity, totalInvoice]);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text("Adicione uma venda!"),
              Row(
                children: [
                  const Text('Cliente: '),
                  DropdownButton(
                    items: _customers?.map((String customer) {
                      return DropdownMenuItem(
                        value: customer,
                        child: Text(customer),
                      );
                    }).toList(),
                    onChanged: (String? customer) {
                      setState(() {
                        _selectedCustomer = customer;
                        // _getSalesByCustomer(customer);
                      });
                    },
                    value: _selectedCustomer,
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Produtos: '),
                  DropdownButton(
                    items: _products?.map((String products) {
                      return DropdownMenuItem(
                        value: products,
                        child: Text(products),
                      );
                    }).toList(),
                    onChanged: (String? products) async {
                      setState(() {
                        _selectedProduct = products;

                        // _getSalesByCustomer(customer);
                      });
                      final List<Map<String, dynamic>> prices =
                          await _databaseHelper.getPriceByName(products!);
                      setState(() {
                        _price = prices[0]['itemPrice'];
                      });
                    },
                    value: _selectedProduct,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(r"Preço R$" "$_price"),
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Quantidade"),
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  setState(() {
                    _quantity = int.parse(value);
                    _calculateTotalInvoice();
                  });
                },
              ),
              Text('$_totalInvoice'),
              ElevatedButton(
                  child: const Text("Adicionar Venda"),
                  onPressed: () {
                    saveSale(_selectedCustomer!, _selectedProduct!, _price,
                        _quantity, _totalInvoice);
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        ),
      );
}
