import 'package:firebasenote/modul/worknote.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase{
  static Database? db;
  static String? path;
  static final String TABLE = "noteTB";

  static Future initDB() async {
    if (db != null) {

    } else {
      path = join(await getDatabasesPath(), "note.db");
      db = await openDatabase(
        path!,
        version: 1,
        onCreate: (db, version) {
          String query =
              "CREATE TABLE IF NOT EXISTS $TABLE(id INTEGER PRIMARY KEY AUTOINCREMENT,work TEXT,isDone TEXT)";
          print("DATA BASE CREATED SUCCESSFULLY");
          return db.execute(query);
        },
      );
    }

    return db;
  }

  static Future insertDB(Note n) async {
    await initDB();
    String query = "INSERT INTO $TABLE(work,isDone) VALUES(?,?)";
    List arg = [n.work,n.isDone];

    int res = await db!.rawInsert(query, arg);

    return res;
  }

  static notCompleteTask()async{
    await initDB();

    String query = "SELECT COUNT(*) FROM $TABLE where isDone = ? GROUP BY isDone";
    List arg = ['false'];
    List<Map<String, Object?>> res = await db!.rawQuery(query,arg);
    if(res.isEmpty){
      return 0;
    }else{
      print(res[0]['COUNT(*)']);
      return res[0]['COUNT(*)'];
    }
  }

  static completeTask()async{
    await initDB();

    String query = "SELECT COUNT(*) FROM $TABLE where isDone = ? GROUP BY isDone";
    List arg = ['true'];
    List<Map<String, Object?>> res = await db!.rawQuery(query,arg);
    if(res.isEmpty){
      return 0;
    }else{
      print(res[0]['COUNT(*)']);
      return res[0]['COUNT(*)'];
    }
  }

  static Future<List<Note>> getAllNote() async {
    await initDB();
    String query = "SELECT * FROM $TABLE";
    List res = await db!.rawQuery(query);

    return await List.generate(
      res.length,
          (i) => Note.create(
            id: res[i]['id'],
            work: res[i]['work'],
            isDone: res[i]['isDone'],
      ),
    );
  }

  static Future<int> deleteData({required int id}) async {
    await initDB();
    String query = "DELETE FROM $TABLE WHERE id=?";
    List arg = [id];
    var res = await db!.rawDelete(query, arg);
    return res;
  }

  static isTaskComplete({required String done ,required int id})async{
    await initDB();
    String query = 'UPDATE $TABLE SET isDone = ? WHERE id = ?';
    List arg = [done,id];
    await db!.rawUpdate(query,arg);
  }

  static Future<int> editData({required String editWork,required int id}) async {
    await initDB();
    String query = "UPDATE $TABLE SET work = ? WHERE id = ?";
    List arg = [editWork, id];
    int res = await db!.rawUpdate(query, arg);
    return res;
  }

}