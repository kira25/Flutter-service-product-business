import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:service_products_business/models/AdminProduct/admin_product.dart';
import 'package:service_products_business/models/CreateProduct/create_product.dart';
import 'package:sqflite/sqflite.dart';

const DATABASE = 'Product';
const DATABASE_PATH = 'ProductDB.db';

class ProductDB {
  ProductDB._();

  static final ProductDB db = ProductDB._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DATABASE_PATH);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $DATABASE ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "description TEXT,"
          "productCategory  TEXT,"
          "stockType  INTEGER,"
          "stock  TEXT,"
          "priceType  INTEGER,"
          "price  TEXT,"
          "imageProduct  TEXT"
          ")");
    });
  }

  //CREATE PRODUCT
  // newProduct(CreateProduct newProduct) async {
  //   final db = await database;
  //   var res = await db.insert(DATABASE, newProduct.toJson());
  //   return res;
  // }

  
}
