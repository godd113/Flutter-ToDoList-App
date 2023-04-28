import 'package:flutter/material.dart';
import 'package:todo/databases/todo_text_db.dart';
import 'package:todo/models/modelTextToDo.dart';

class TableViewRowManager extends StatefulWidget {
  ModelTextToDo oTextToDo;
  Color tintColor = Colors.black;
  TableViewRowManager(
      {super.key, required this.oTextToDo, required this.tintColor});

  @override
  State<TableViewRowManager> createState() => _TableViewRowManagerState();
}

class _TableViewRowManagerState extends State<TableViewRowManager> {
  late ToDoTextDatabase _db;
  @override
  void initState() {
    // TODO: implement initState
    _db = ToDoTextDatabase.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          height: 40,
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            child: Row(
              children: [
                Container(
                  child: widget.oTextToDo.done == false
                      ? SizedBox(
                          height: 30,
                          child: Image.asset(
                            'assets/images/icons/uncheck.png',
                            color: widget.tintColor,
                          ),
                        )
                      : SizedBox(
                          height: 30,
                          child: Image.asset(
                            'assets/images/icons/check-fill.png',
                            color: widget.tintColor,
                          ),
                        ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(widget.oTextToDo.textToDoName)
              ],
            ),
            onTap: () {
              setState(() {
                widget.oTextToDo.done = !widget.oTextToDo.done;
                _db.update(widget.oTextToDo);
              });
              print(
                  "tap tap! ==> ${widget.oTextToDo.textToDoID} : ${widget.oTextToDo.textToDoName}");
            },
          ),
        )),
      ],
    );
  }
}
