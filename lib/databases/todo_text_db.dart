import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo/models/modelTextToDo.dart';

class ToDoTextDatabase {
  static final ToDoTextDatabase instance = ToDoTextDatabase._init();
  static Database? _database;

  ToDoTextDatabase._init();

  Future<Database> get database_list async {
    // ถ้ามีฐานข้อมูลนี้แล้วคืนค่า
    if (_database != null) return _database!;
    // ถ้ายังไม่มี สร้างฐานข้อมูล กำหนดชื่อ นามสกุล .db
    _database = await _initDB('todolist_todotext.db');
    // คืนค่าฐานข้อมูล
    return _database!;
  }

  // ฟังก์ชั่นสร้างฐานข้อมูล รับชื่อไฟล์ที่กำหนดเข้ามา
  Future<Database> _initDB(String filePath) async {
    // หาตำแหน่งที่จะจัดเก็บในระบบ ที่เตรียมไว้ให้
    final dbPath = await getDatabasesPath();
    // ต่อกับชื่อที่ส่งมา จะเป็น path เต็มของไฟล์
    final path = join(dbPath, filePath);
    // สร้างฐานข้อมูล และเปิดใช้งาน หากมีการแก้ไข ให้เปลี่ยนเลขเวอร์ชั่น เพิ่มขึ้นไปเรื่อยๆ
    return await openDatabase(path, version: 1, onCreate: _createDB_todoText);
  }

  Future _createDB_todoText(Database db, int version) async {
    // รูปแบบข้อมูล sqlite ที่รองรับ
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final intType = 'INTEGER NOT NULL';

    // ทำคำสั่งสร้างตาราง
    await db.execute('''
CREATE TABLE $tableToDoText (
  ${ToDoTextFields.textToDoID} $idType,
  ${ToDoTextFields.todoCardID} $intType,
  ${ToDoTextFields.textToDoName} $textType,
  ${ToDoTextFields.done} $boolType
)
''');
  }

  Future<ModelTextToDo> createToDoText(ModelTextToDo todoText) async {
    final db = await instance.database_list; // อ้างอิงฐานข้อมูล

    final id = await db.insert(tableToDoText, todoText.toJson());
    return todoText.copy(textToDoID: id);
  }

  // คำสั่งสำหรับแสดงข้อมูลหนังสือตามค่า id ที่ส่งมา
  Future<ModelTextToDo> readToDoText(int id) async {
    final db = await instance.database_list; // อ้างอิงฐานข้อมูล

    // ทำคำสั่งคิวรี่ข้อมูลตามเงื่อนไข
    final maps = await db.query(
      tableToDoText,
      columns: ToDoTextFields.values,
      where: '${ToDoTextFields.textToDoID} = ?',
      whereArgs: [id],
    );

    // ถ้ามีข้อมูล แสดงข้อมูลกลับออกไป
    if (maps.isNotEmpty) {
      return ModelTextToDo.fromJson(maps.first);
    } else {
      // ถ้าไม่มีแสดง error
      throw Exception('ID $id not found');
    }
  }

  Future<int> update(ModelTextToDo oTodoText) async {
    final db = await instance.database_list; // อ้างอิงฐานข้อมูล

    // คืนค่าเป็นตัวเลขจำนวนรายการที่มีการเปลี่ยนแปลง
    return db.update(
      tableToDoText,
      oTodoText.toJson(),
      where: '${ToDoTextFields.textToDoID} = ?',
      whereArgs: [oTodoText.textToDoID],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database_list; // อ้างอิงฐานข้อมูล

    // คืนค่าเป็นตัวเลขจำนวนรายการที่มีการเปลี่ยนแปลง
    return db.delete(
      tableToDoText,
      where: '${ToDoTextFields.textToDoID} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database_list; // อ้างอิงฐานข้อมูล
    // คืนค่าเป็นตัวเลขจำนวนรายการที่มีการเปลี่ยนแปลง
    return db.delete(
      tableToDoText,
    );
  }

  Future<List<ModelTextToDo>> selectDataFromTableToDoText(int id) async {
    final db = await instance.database_list;
    final orderBy = '${ToDoTextFields.textToDoID} ASC';
    final whereCondition = '${ToDoTextFields.todoCardID} = ${id}';
    List<Map<String, dynamic>> result =
        await db.query(tableToDoText, orderBy: orderBy, where: whereCondition);

    // ข้อมูลในฐานข้อมูลปกติเป็น json string data เวลาสั่งค่ากลับต้องทำการ
    // แปลงข้อมูล จาก json ไปเป็น object กรณีแสดงหลายรายการก็ทำเป็น List
    List<ModelTextToDo> _objects =
        result.map((json) => ModelTextToDo.fromJson(json)).toList();

    return _objects;
  }
}
