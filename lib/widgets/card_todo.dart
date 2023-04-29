import 'package:flutter/material.dart';
import 'package:todo/databases/todo_list_db.dart';
import 'package:todo/models/modelIcon.dart';
import 'package:todo/models/modelToDoCard.dart';
import 'package:todo/modules/module_center.dart';
import 'package:todo/modules/module_colors.dart';
import 'package:todo/pages/todo_list.dart';
import 'package:todo/widgets/cupertino_actionsheet.dart';

class CardToDo extends StatefulWidget {
  ModelToDoCard oModelCard;
  final List<ModelIcon> allIcons = ModuleCenter.listIcons;
  CardToDo({super.key, required this.oModelCard});

  @override
  State<CardToDo> createState() => _CardToDoState();
}

class _CardToDoState extends State<CardToDo> {
  late ToDoListDatabase _db;
  int index = 0;
  late TCupertinoActionSheet actsheet = TCupertinoActionSheet(
    parentActionShow: _showDetailCard,
    parentActionDelete: _deleteDetailCard,
    parentActionEdit: _editDetailCard,
  );

  Future<void> _showDetailCard(int value) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ToDoList(
              indexObject: index,
              parentAction: (value) {
                setState(() {
                  widget.oModelCard.todoCardTaskNum = value;
                });
              },
              oModuleCard: ModuleCenter.listCards[index].oModelCard)),
    );
  }

  Future<void> _editDetailCard(int value) async {}

  Future<void> _deleteDetailCard(int value) async {
    _db.delete(value);
    setState(() {
      ModuleCenter.listCards.removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    index = ModuleCenter.listCards.indexWhere((element) =>
        element.oModelCard.todoCardID == widget.oModelCard.todoCardID);
    _db = ToDoListDatabase.instance;
    super.initState();
  }

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
              Icon(
                imgIcon.icon,
                color: ModuleColors.fontCardColor,
              ),
              Container(
                padding: const EdgeInsets.only(left: 5),
                width: (screenDeviceWidth - 105),
                child: Text(
                  widget.oModelCard.todoCardName,
                  style: TextStyle(
                      color: ModuleColors.fontCardColor,
                      fontSize: 25,
                      fontFamily: 'Kanit'),
                ),
              ),
              GestureDetector(
                child: Container(
                  child: const Icon(Icons.more_horiz),
                ),
                onTap: () {
                  actsheet.showActionSheet(
                      context,
                      widget.oModelCard.todoCardName,
                      widget.oModelCard.todoCardID);
                },
              )
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              Text(
                '${widget.oModelCard.todoCardTaskNum} Tasks',
                style: TextStyle(
                    color: ModuleColors.fontCardColor,
                    fontSize: 15,
                    fontFamily: 'Kanit'),
              )
            ],
          )
        ]),
      ),
      onTap: () {
        _showDetailCard(widget.oModelCard.todoCardID);
      },
    );
  }
}
