import 'package:flutter/material.dart';

import '../../util/database_helper.dart';

class ShowSale extends StatefulWidget {
  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<ShowSale> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  String? _selectedCustomer;
  List<String>? _customers; //<-- add this

  List<Map<String, dynamic>>? _sales;

  @override
  void initState() {
    super.initState();
    _getCustomers();
  }

  void _getCustomers() async {
    final List<Map<String, dynamic>> sales = await _dbHelper.getSales();
    final Set<String> customers =
        Set.from(sales.map((sale) => sale['customerName']));
    setState(() {
      _sales = sales;
      _customers = customers.toList();
    });
  }

  void _getSalesByCustomer(String? customerName) async {
    final List<Map<String, dynamic>> sales =
        await _dbHelper.getSalesByCustomerName(customerName.toString());
    setState(() {
      _sales = sales;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de vendas'),
      ),
      body: Column(
        children: <Widget>[
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
                _getSalesByCustomer(customer);
              });
            },
            value: _selectedCustomer,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedCustomer == null ? 1 : _sales?.length,
              itemBuilder: (BuildContext context, int index) {
                if (_selectedCustomer == null) {
                  return Container(
                    child: const Center(
                      child: Text("Selecione um cliente para ver as vendas."),
                    ),
                  );
                }
                final Map<String, dynamic> sale = _sales![index];
                return ListTile(
                  title: Text(sale['itemName']),
                  subtitle: Text(sale['itemPrice'].toString()),
                  trailing: Text(sale['quantity'].toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
