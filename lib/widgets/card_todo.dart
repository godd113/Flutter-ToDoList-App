import 'package:flutter/material.dart';
import 'package:todo/models/modelIcon.dart';
import 'package:todo/models/modelToDoCard.dart';
import 'package:todo/modules/module_center.dart';
import 'package:todo/pages/todo_list.dart';

class CardToDo extends StatefulWidget {
  final ModelToDoCard oModelCard;
  final List<ModelIcon> allIcons = ModuleCenter.listIcons;
  CardToDo({super.key, required this.oModelCard});

  @override
  State<CardToDo> createState() => _CardToDoState();
}

class _CardToDoState extends State<CardToDo> {
  @override
  Widget build(BuildContext context) {
    final double screenDeviceWidth = MediaQuery.of(context).size.width;
    ModelIcon imgIcon = widget.allIcons
        .firstWhere((icon) => icon.iconID == widget.oModelCard.iconID);
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(12),
        width: screenDeviceWidth - 30,
        decoration: BoxDecoration(
            color: widget.oModelCard.color,
            borderRadius: BorderRadius.circular(10)),
        child: Column(children: [
          Row(
            children: [
              Icon(imgIcon.icon),
              Container(
                padding: EdgeInsets.only(left: 5),
                width: (screenDeviceWidth - 105),
                child: Text(
                  widget.oModelCard.todoCardName,
                  style: TextStyle(
                      color: Colors.black, fontSize: 25, fontFamily: 'Kanit'),
                ),
              ),
              Container(
                child: Icon(Icons.more_horiz),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Text(
                '2 Task',
                style: TextStyle(
                    color: Colors.blueGrey, fontSize: 15, fontFamily: 'Kanit'),
              )
            ],
          )
        ]),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ToDoList(oModuleCard: widget.oModelCard)),
        );
      },
    );
  }
}
