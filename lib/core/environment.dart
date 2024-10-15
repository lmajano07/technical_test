import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  Environment._();

  static String dbName = dotenv.get('DB_NAME', fallback: '');
  static String transactionsName = dotenv.get(
    'TRANSACTIONS_TABLE_NAME',
    fallback: '',
  );
}
