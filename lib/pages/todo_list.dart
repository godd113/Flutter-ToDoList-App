import 'package:flutter/material.dart';
import 'package:todo/models/modelIcon.dart';
import 'package:todo/models/modelTextToDo.dart';
import 'package:todo/models/modelToDoCard.dart';
import 'package:todo/modules/module_center.dart';
import 'package:todo/widgets/tableview.dart';
import 'package:todo/widgets/tableview_row.dart';

class ToDoList extends StatefulWidget {
  ModelToDoCard oModuleCard;
  final List<ModelIcon> allIcons = ModuleCenter.listIcons;
  List<TableViewRowManager> list = [];
  ToDoList({super.key, required this.oModuleCard});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    ModelIcon imgIcon = widget.allIcons
        .firstWhere((icon) => icon.iconID == widget.oModuleCard.iconID);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Icon(imgIcon.icon),
        ),
        backgroundColor: widget.oModuleCard.color,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 229, 229, 229)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width - 40,
                          alignment: Alignment.center,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Text(
                                widget.oModuleCard.todoCardName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Kanit'),
                              ))),
                      GestureDetector(
                        child: Icon(Icons.add),
                        onTap: () {
                          ModelTextToDo oText = ModelTextToDo(
                              textToDoID: widget.list.length + 1,
                              textToDoName: "Testttt",
                              done: false);
                          setState(() {
                            widget.list.add(TableViewRowManager(
                              oTextToDo: oText,
                            ));
                          });
                        },
                      ),
                    ],
                  ),
                ],
              )),
          TableViewManager(
            list: widget.list,
          )
        ],
      )),
    );
  }
}
