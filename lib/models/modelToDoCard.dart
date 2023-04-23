import 'dart:ui';

import 'package:todo/models/modelTextToDo.dart';

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
}
