final String tableToDoText = 'todotext';

class ModelTextToDo {
  int textToDoID;
  String textToDoName;
  bool done;

  ModelTextToDo(
      {required this.textToDoID,
      required this.textToDoName,
      required this.done});

  ModelTextToDo copy() {
    return ModelTextToDo(
        textToDoID: textToDoID, textToDoName: textToDoName, done: done);
  }

  static ModelTextToDo fromJson(Map<String, Object?> json) => ModelTextToDo(
      textToDoID: json['_id'] as int,
      textToDoName: json['textToDoName'] as String,
      done: json['done'] as bool);

  Map<String, Object?> toJson() => {
        ToDoTextFields.textToDoID: textToDoID,
        ToDoTextFields.textToDoName: textToDoName,
        ToDoTextFields.done: done
      };
}

class ToDoTextFields {
  // สร้างเป็นลิสรายการสำหรับคอลัมน์ฟิลด์
  static final List<String> values = [textToDoID, textToDoName, done];

  // กำหนดแต่ละฟิลด์ของตาราง ต้องเป็น String ทั้งหมด
  static const String textToDoID =
      '_id'; // ตัวแรกต้องเป็น _id ส่วนอื่นใช้ชื่อะไรก็ได้
  static const String textToDoName = 'textToDoName';
  static const String done = 'done';
}
