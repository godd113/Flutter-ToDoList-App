import 'dart:ui';

class ModelToDoCard {
  final int todoCardID;
  String todoCardName;
  String todoCardTaskNum;
  int iconID;
  Color color;

  ModelToDoCard(
      {required this.todoCardID,
      required this.todoCardName,
      required this.todoCardTaskNum,
      required this.iconID,
      required this.color});
}
