import 'package:flutter/material.dart';
import 'package:todo/models/modelIcon.dart';
import 'package:todo/models/modelToDoCard.dart';
import 'package:todo/widgets/card_todo.dart';

class ModuleCenter {
  static List<ModelIcon> listIcons = [
    ModelIcon(iconID: 1, icon: Icons.work),
    ModelIcon(iconID: 2, icon: Icons.cast_for_education),
    ModelIcon(iconID: 3, icon: Icons.umbrella_sharp),
    ModelIcon(iconID: 4, icon: Icons.favorite),
    ModelIcon(iconID: 5, icon: Icons.headphones),
    ModelIcon(iconID: 6, icon: Icons.home),
    ModelIcon(iconID: 7, icon: Icons.car_repair),
    ModelIcon(iconID: 8, icon: Icons.flight),
    ModelIcon(iconID: 9, icon: Icons.ac_unit),
    ModelIcon(iconID: 10, icon: Icons.run_circle),
    ModelIcon(iconID: 11, icon: Icons.book),
    ModelIcon(iconID: 12, icon: Icons.sports_rugby_rounded),
    ModelIcon(iconID: 13, icon: Icons.alarm),
    ModelIcon(iconID: 14, icon: Icons.call),
    ModelIcon(iconID: 15, icon: Icons.snowing),
    ModelIcon(iconID: 16, icon: Icons.music_note),
    ModelIcon(iconID: 17, icon: Icons.sunny),
    // add more icons here if you want
  ];
  static List<CardToDo> listCards = [
    CardToDo(
      indexOfObject: 0,
      oModelCard: ModelToDoCard(
        todoCardID: 0,
        todoCardName: "ToDo",
        todoCardTaskNum: "2 Task",
        iconID: 1,
        color: Colors.orangeAccent,
        listToDo: [],
      ),
    )
  ];
}
