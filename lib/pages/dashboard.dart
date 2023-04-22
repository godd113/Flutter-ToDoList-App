import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo/models/modelIcon.dart';
import 'package:todo/models/modelToDoCard.dart';
import 'package:todo/pages/card_manager.dart';

import '../modules/module_colors.dart';
import '../widgets/card_todo.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});
  final double addBtnSize = 30;
  List<CardToDo> listCard = [
    CardToDo(
      oModelCard: ModelToDoCard(
          todoCardID: 0,
          todoCardName: "ToDo",
          todoCardTaskNum: "2 Task",
          iconID: 1,
          color: Colors.orangeAccent),
    )
  ];

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
            print('click setting');
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
                                      widget.listCard.add(
                                          CardToDo(oModelCard: oModelCard));
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
                children: List<Widget>.from(widget.listCard),
              ),
            )
          ],
        ),
      ),
    );
  }
}
