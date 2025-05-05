import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysql_client/mysql_client.dart';

class DbConnection {
  static late MySQLConnection dbPort;

  static void connect() async {
    String? host = dotenv.env['HOST'];
    String? port = dotenv.env['PORT'];
    String? userName = dotenv.env['USER'];
    String? password = dotenv.env['PASSWORD'];
    String? databaseName = dotenv.env['DATABASE'];

    dbPort = await MySQLConnection.createConnection(
      host: host!,
      port: int.parse(port!),
      userName: userName!,
      password: password!,
      databaseName: databaseName!,
      secure: false,
    );

    // actually connect to database
    await dbPort.connect();
    debugPrint("Connected to database");
  }
}
