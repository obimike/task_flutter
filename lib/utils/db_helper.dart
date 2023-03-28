import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final _dbName = 'todo.db';
  static final _dbVersion = 1;

  static final table = 'todoTable';

  static final c_id = "id";
  static final c_title = "title";
  static final c_isChecked = "done";
  static final c_dateStamp = "stamp";
  static final c_priority = "priority";
}
