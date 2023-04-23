import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/widgets/tableview_row.dart';

class TableViewManager extends StatefulWidget {
  List<TableViewRowManager> list;
  TableViewManager({super.key, required this.list});

  @override
  State<TableViewManager> createState() => _TableViewManagerState();
}

class _TableViewManagerState extends State<TableViewManager> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: List<Widget>.from(widget.list)),
    );
  }
}
