import 'package:flutter/material.dart';
import 'package:todo/models/modelTextToDo.dart';

class TableViewRowManager extends StatefulWidget {
  ModelTextToDo oTextToDo;
  TableViewRowManager({super.key, required this.oTextToDo});

  @override
  State<TableViewRowManager> createState() => _TableViewRowManagerState();
}

class _TableViewRowManagerState extends State<TableViewRowManager> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          height: 40,
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              GestureDetector(
                child: widget.oTextToDo.done == false
                    ? Icon(Icons.check_box_outline_blank)
                    : Icon(Icons.check_box_rounded),
                onTap: () {
                  setState(() {
                    widget.oTextToDo.done = !widget.oTextToDo.done;
                  });
                  print(
                      "tap tap! ==> ${widget.oTextToDo.textToDoID} : ${widget.oTextToDo.textToDoName}");
                },
              ),
              SizedBox(
                width: 10,
              ),
              Text(widget.oTextToDo.textToDoName)
            ],
          ),
        )),
      ],
    );
  }
}
