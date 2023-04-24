import 'package:flutter/material.dart';
import 'package:todo/models/modelIcon.dart';
import 'package:todo/models/modelTextToDo.dart';
import 'package:todo/models/modelToDoCard.dart';
import 'package:todo/modules/module_center.dart';
import 'package:todo/widgets/listview.dart';
import 'package:todo/widgets/tableview.dart';
import 'package:todo/widgets/tableview_row.dart';

class ToDoList extends StatefulWidget {
  ModelToDoCard oModuleCard;
  int indexObject;
  final List<ModelIcon> allIcons = ModuleCenter.listIcons;
  List<TableViewRowManager> list = [];
  ToDoList({super.key, required this.oModuleCard, required this.indexObject});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  TextEditingController? _textFieldController;
  String todoNew = "";
  Future<void> initDataDrawing() async {
    for (var oTextToDo in widget.oModuleCard.listToDo) {
      widget.list.add(TableViewRowManager(oTextToDo: oTextToDo));
    }
  }

  @override
  void initState() {
    super.initState();
    initDataDrawing();
  }

  Future<void> _displayDialogAddNewTodo(BuildContext context) async {
    _textFieldController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Reminder'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  todoNew = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Input your todolist"),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  ModelTextToDo oText = ModelTextToDo(
                      textToDoID: widget.list.length + 1,
                      textToDoName: todoNew,
                      done: false);

                  //widget.oModuleCard.setListToDo(oText);
                  ModuleCenter.listCards[widget.indexObject].oModelCard.listToDo
                      .add(oText);
                  setState(() {
                    widget.list.add(TableViewRowManager(
                      oTextToDo: oText,
                    ));
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

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
                          _displayDialogAddNewTodo(context);
                        },
                      ),
                    ],
                  ),
                ],
              )),
          ListViewManager()
          /*TableViewManager(
            list: widget.list,
          )*/
        ],
      )),
    );
  }
}
