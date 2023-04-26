import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo/models/modelTextToDo.dart';
import 'package:todo/models/modelToDoCard.dart';

class ToDoListDatabase {
  static final ToDoListDatabase instance = ToDoListDatabase._init();
  static Database? _database;

  ToDoListDatabase._init();

  Future<Database> get database async {
    // ถ้ามีฐานข้อมูลนี้แล้วคืนค่า
    if (_database != null) return _database!;
    // ถ้ายังไม่มี สร้างฐานข้อมูล กำหนดชื่อ นามสกุล .db
    _database = await _initDB('todolist.db');
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
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // สร้างตาราง
  Future _createDB(Database db, int version) async {
    // รูปแบบข้อมูล sqlite ที่รองรับ
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    // ทำคำสั่งสร้างตาราง
    await db.execute('''
CREATE TABLE $tableToDoList (
  ${ToDoListFields.todoCardID} $idType,
  ${ToDoListFields.todoCardName} $integerType,
  ${ToDoListFields.todoCardTaskNum} $textType,
  ${ToDoListFields.iconID} $integerType,
  ${ToDoListFields.color} $integerType
)
''');
  }

  Future _createDB_todoText(Database db, int version) async {
    // รูปแบบข้อมูล sqlite ที่รองรับ
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    // ทำคำสั่งสร้างตาราง
    await db.execute('''
CREATE TABLE $tableToDoText (
  ${ToDoTextFields.textToDoID} $idType,
  ${ToDoTextFields.textToDoName} $textType,
  ${ToDoTextFields.done} $boolType,
)
''');
  }

  Future<ModelToDoCard> create(ModelToDoCard todocard) async {
    final db = await instance.database; // อ้างอิงฐานข้อมูล

    final id = await db.insert(tableToDoList, todocard.toJson());
    return todocard.copy(todoCardID: id);
  }

  // คำสั่งสำหรับแสดงข้อมูลหนังสือตามค่า id ที่ส่งมา
  Future<ModelToDoCard> readToDoCard(int id) async {
    final db = await instance.database; // อ้างอิงฐานข้อมูล

    // ทำคำสั่งคิวรี่ข้อมูลตามเงื่อนไข
    final maps = await db.query(
      tableToDoList,
      columns: ToDoListFields.values,
      where: '${ToDoListFields.todoCardID} = ?',
      whereArgs: [id],
    );

    // ถ้ามีข้อมูล แสดงข้อมูลกลับออกไป
    if (maps.isNotEmpty) {
      return ModelToDoCard.fromJson(maps.first);
    } else {
      // ถ้าไม่มีแสดง error
      throw Exception('ID $id not found');
    }
  }

  Future<List<ModelToDoCard>> readAll() async {
    final db = await instance.database; // อ้างอิงฐานข้อมูล

    // กำหนดเงื่อนไขต่างๆ รองรับเงื่อนไขและรูปแบบของคำสั่ง sql ตัวอย่าง
    // ใช้แค่การจัดเรียงข้อมูล
    final orderBy = '${ToDoListFields.todoCardID} DESC';
    final result = await db.query(tableToDoList, orderBy: orderBy);

    // ข้อมูลในฐานข้อมูลปกติเป็น json string data เวลาสั่งค่ากลับต้องทำการ
    // แปลงข้อมูล จาก json ไปเป็น object กรณีแสดงหลายรายการก็ทำเป็น List
    return result.map((json) => ModelToDoCard.fromJson(json)).toList();
  }

  Future<int> update(ModelToDoCard oTodoCard) async {
    final db = await instance.database; // อ้างอิงฐานข้อมูล

    // คืนค่าเป็นตัวเลขจำนวนรายการที่มีการเปลี่ยนแปลง
    return db.update(
      tableToDoList,
      oTodoCard.toJson(),
      where: '${ToDoListFields.todoCardID} = ?',
      whereArgs: [oTodoCard.todoCardID],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database; // อ้างอิงฐานข้อมูล

    // คืนค่าเป็นตัวเลขจำนวนรายการที่มีการเปลี่ยนแปลง
    return db.delete(
      tableToDoList,
      where: '${ToDoListFields.todoCardID} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database; // อ้างอิงฐานข้อมูล
    // คืนค่าเป็นตัวเลขจำนวนรายการที่มีการเปลี่ยนแปลง
    return db.delete(
      tableToDoList,
    );
  }

  Future<List<ModelToDoCard>> selectDataFromTable() async {
    final db = await instance.database;
    final orderBy = '${ToDoListFields.todoCardID} DESC';
    List<Map<String, dynamic>> result =
        await db.query(tableToDoList, orderBy: orderBy);

    // ข้อมูลในฐานข้อมูลปกติเป็น json string data เวลาสั่งค่ากลับต้องทำการ
    // แปลงข้อมูล จาก json ไปเป็น object กรณีแสดงหลายรายการก็ทำเป็น List
    List<ModelToDoCard> _objects =
        result.map((json) => ModelToDoCard.fromJson(json)).toList();

    return _objects;
  }
}
