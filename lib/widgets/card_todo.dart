import 'package:flutter/material.dart';

class CardToDo extends StatefulWidget {
  const CardToDo({super.key});

  @override
  State<CardToDo> createState() => _CardToDoState();
}

class _CardToDoState extends State<CardToDo> {
  @override
  Widget build(BuildContext context) {
    final double screenDeviceWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(12),
      width: screenDeviceWidth - 30,
      decoration: BoxDecoration(
          color: Colors.orangeAccent, borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Row(
          children: [
            Icon(Icons.today_outlined),
            Container(
              padding: EdgeInsets.only(left: 5),
              width: (screenDeviceWidth - 105),
              child: Text(
                'ToDo',
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
    );
  }
}
