import 'dart:convert';
import 'dart:ui';

import 'package:todo/models/modelTextToDo.dart';
import 'package:todo/pages/todo_list.dart';

final String tableToDoList = 'todolist';

class ModelToDoCard {
  final int todoCardID;
  String todoCardName;
  String todoCardTaskNum;
  int iconID;
  Color color;
  List<ModelTextToDo> listToDo;

  ModelToDoCard(
      {required this.todoCardID,
      required this.todoCardName,
      required this.todoCardTaskNum,
      required this.iconID,
      required this.color,
      required this.listToDo});

  void setListToDo(ModelTextToDo newObject) {
    listToDo.add(newObject);
  }

  ModelToDoCard copy(
          {int? todoCardID,
          String? todoCardName,
          String? todoCardTaskNum,
          int? iconID,
          Color? color,
          List<ModelTextToDo>? listToDo}) =>
      ModelToDoCard(
          todoCardID: todoCardID ?? this.todoCardID,
          todoCardName: todoCardName ?? this.todoCardName,
          todoCardTaskNum: todoCardTaskNum ?? this.todoCardTaskNum,
          iconID: iconID ?? this.iconID,
          color: color ?? this.color,
          listToDo: listToDo ?? this.listToDo);

  static ModelToDoCard fromJson(Map<String, Object?> json) => ModelToDoCard(
        todoCardID: json['_id'] as int,
        todoCardName: json['todoCardName'] as String,
        todoCardTaskNum: json['todoCardTaskNum'] as String,
        iconID: json['iconID'] as int,
        color: Color(json['color'] as int),
        listToDo: [],
      );

  Map<String, Object?> toJson() => {
        ToDoListFields.todoCardID: todoCardID,
        ToDoListFields.todoCardName: todoCardName,
        ToDoListFields.todoCardTaskNum: todoCardTaskNum,
        ToDoListFields.iconID: iconID,
        ToDoListFields.color: color.value,
        ToDoListFields.listToDo: listToDo,
      };
}

//-- for sqlite db
class ToDoListFields {
  // สร้างเป็นลิสรายการสำหรับคอลัมน์ฟิลด์
  static final List<String> values = [
    todoCardID,
    todoCardName,
    todoCardTaskNum,
    iconID,
    color,
    listToDo
  ];

  // กำหนดแต่ละฟิลด์ของตาราง ต้องเป็น String ทั้งหมด
  static const String todoCardID =
      '_id'; // ตัวแรกต้องเป็น _id ส่วนอื่นใช้ชื่อะไรก็ได้
  static const String todoCardName = 'todoCardName';
  static const String todoCardTaskNum = 'todoCardTaskNum';
  static const String iconID = 'iconID';
  static const String color = 'color';
  static const String listToDo = 'listToDo';
}
