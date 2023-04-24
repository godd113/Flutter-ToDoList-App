import 'package:flutter/material.dart';
import 'package:todo/modules/module_center.dart';
import 'package:todo/widgets/card_todo.dart';
import 'package:todo/widgets/tableview_row.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListViewManager extends StatefulWidget {
  const ListViewManager({super.key});

  @override
  State<ListViewManager> createState() => _ListViewManagerState();
}

class _ListViewManagerState extends State<ListViewManager> {
  CardToDo oCard = ModuleCenter.listCards[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: oCard.oModelCard.listToDo.length,
          itemBuilder: (context, index) {
            return Dismissible(
              direction: DismissDirection.endToStart,
              key: Key(oCard.oModelCard.listToDo[index].textToDoID.toString()),
              child: Slidable(
                // Specify a key if the Slidable is dismissible.
                key: const ValueKey(0),
                // The end action pane is the one at the right or the bottom side.
                endActionPane: ActionPane(
                  extentRatio: 0.16,
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        setState(() {
                          oCard.oModelCard.listToDo.removeAt(index);
                        });
                        print("delete object");
                      },
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      //label: '',
                    ),
                  ],
                ),
                // The child of the Slidable is what the user sees when the
                // component is not dragged.
                child: TableViewRowManager(
                  oTextToDo: oCard.oModelCard.listToDo[index],
                ),
              ),
            );
          }),
    );
  }
}
