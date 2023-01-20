import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    } else {
      return _db;
    }
  }

  initDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'baseDesafio.db');
    Database myDb = await openDatabase(path, onCreate: _onCreate, version: 1);
    return myDb;
  }

  _onCreate(Database db, int ver) async {
    await db.execute('''
      CREATE TABLE user (
        login TEXT NOT NULL,
        pass TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE product (
        itemName TEXT NOT NULL,
        itemCode TEXT NOT NULL,
        itemPrice REAL NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE client (
        clientName TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE sale (
        customerName TEXT NOT NULL,
        itemName TEXT NOT NULL,
        itemPrice REAL NOT NULL,
        quantity INTEGER NOT NULL,
        totalInvoice REAL NOT NULL
      )
    ''');
    await db.execute("INSERT INTO user(login,pass) VALUES('ADMIN','1234')");
    await db.execute(
        "INSERT INTO sale(customerName, itemName, itemPrice, quantity, totalInvoice) VALUES ('Joãozinho Maluco', 'Salgado', 5.63, 2, 11.26)");
    await db.execute(
        "INSERT INTO sale(customerName, itemName, itemPrice, quantity, totalInvoice) VALUES ('Clebinho do grau', 'Milho', 2.5, 3, 7.5)");
    await db.execute(
        "INSERT INTO sale(customerName, itemName, itemPrice, quantity, totalInvoice) VALUES ('Fantasma', 'Coca-cola ', 7.50, 2, 15)");
  }

  Future<void> deleteDb() async {
    final Database? db = await this.db;
    await db?.close();
    final String path = db!.path;
    await deleteDatabase(path);
    _db = null;
  }

  Future<List<Map<String, dynamic>>> getSalesByCustomerName(
      String customerName) async {
    final Database? db = await this.db;
    final List<Map<String, dynamic>>? results = await db?.query(
      'sale',
      where: 'customerName = ?',
      whereArgs: [customerName],
    );
    return Future.value(results);
  }

  Future<List<Map<String, dynamic>>> getSales() async {
    final Database? db = await this.db;
    final List<Map<String, dynamic>>? results = await db?.query('sale');
    return Future.value(results);
  }
}
