import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo/databases/todo_list_db.dart';
import 'package:todo/models/modelIcon.dart';
import 'package:todo/models/modelToDoCard.dart';
import 'package:todo/modules/module_center.dart';
import 'package:todo/pages/card_manager.dart';

import '../modules/module_colors.dart';
import '../widgets/card_todo.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});
  final double addBtnSize = 30;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late ToDoListDatabase _db;
  late List<ModelToDoCard> listToDoCard;

  @override
  void initState() {
    // TODO: implement initState
    _db = ToDoListDatabase.instance;
    getDBToDoList();
    //_db.create(ModuleCenter.listCards[0].oModelCard);
    super.initState();
  }

  Future<void> getDBToDoList() async {
    ModuleCenter.listCards = [];
    listToDoCard = await _db.selectDataFromTable();
    int i = 0;
    setState(() {
      for (var element in listToDoCard) {
        ModuleCenter.listCards.add(CardToDo(oModelCard: element));
        i += 1;
      }
      ModuleCenter.listCards.sort(
          (a, b) => b.oModelCard.todoCardID.compareTo(a.oModelCard.todoCardID));
    });

    print("xxx");
  }

  Future<String> click() async {
    print('click setting');
    return 'click';
  }

  Future<void> addNewList(ModelToDoCard oModelCard) async {
    ModuleCenter.listCards.add(CardToDo(oModelCard: oModelCard));
    ModuleCenter.listCards.sort(
        (a, b) => b.oModelCard.todoCardID.compareTo(a.oModelCard.todoCardID));
    _db.create(oModelCard);
  }

  @override
  Widget build(BuildContext context) {
    final double screenDeviceSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do'),
        backgroundColor: ModuleColors.themeColor,
        automaticallyImplyLeading: false, // This will remove the back button
        leading: GestureDetector(
          child: const Icon(Icons.settings),
          onTap: () {
            Future<String> x = click();
            print(x);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: screenDeviceSize / 2,
                    child: Text(
                      'My List',
                      style: TextStyle(
                          color: ModuleColors.themeColor,
                          fontSize: 20,
                          fontFamily: 'Kanit'),
                    )),
                Container(
                  alignment: Alignment.centerRight,
                  width: (screenDeviceSize / 2) - widget.addBtnSize,
                  child: GestureDetector(
                    child: Icon(
                      Icons.add,
                      size: widget.addBtnSize,
                    ),
                    onTap: () {
                      /*setState(() {
                        widget.listCard.add(CardToDo());
                      });*/
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CardManager(
                                  parentAction: (ModelToDoCard oModelCard) {
                                    setState(() {
                                      addNewList(oModelCard);
                                    });
                                  },
                                )),
                      );
                      print('click add');
                    },
                  ),
                ),
              ],
            ),
            Container(
              child: Column(
                children: List<Widget>.from(ModuleCenter.listCards),
              ),
            )
          ],
        ),
      ),
    );
  }
}
