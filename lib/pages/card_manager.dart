import 'package:flutter/material.dart';
import 'package:todo/models/modelToDoCard.dart';
import 'package:todo/modules/module_center.dart';
import 'package:todo/modules/module_colors.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo/widgets/picker_icon.dart';

class CardManager extends StatefulWidget {
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  final ValueChanged<ModelToDoCard> parentAction;

  ModelToDoCard? oCard = ModelToDoCard(
      todoCardID: 0,
      todoCardName: "",
      todoCardTaskNum: "0",
      iconID: 0,
      color: Colors.transparent,
      listToDo: []);

  CardManager({super.key, required this.parentAction});

  @override
  State<CardManager> createState() => _CardManagerState();
}

class _CardManagerState extends State<CardManager> {
  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => widget.pickerColor = color);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add New'),
          backgroundColor: ModuleColors.themeColor,
          actions: [
            TextButton(
              onPressed: () {
                if (widget.oCard!.todoCardName.trim() == "" ||
                    widget.oCard!.iconID == 0 ||
                    widget.oCard!.color == Colors.transparent) {
                  _asyncWarningDialog(context);
                  return;
                }
                // Do something when the user taps the "Done" button
                var widget2 = widget.oCard;
                widget.parentAction(widget2!);
                Navigator.of(context).pop();
                print('Doneeee!');
              },
              child: const Text(
                'Done',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Name',
                    style: TextStyle(
                        color: Colors.black, fontSize: 20, fontFamily: 'Kanit'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    width: MediaQuery.of(context).size.width - 40,
                    height: 70,
                    child: Center(
                        child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            transformAlignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                                border: Border.all(
                                    color: Color.fromARGB(255, 216, 216, 216),
                                    style: BorderStyle.solid)),
                            width: MediaQuery.of(context).size.width - 40,
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your category name',
                              ),
                              onChanged: (text) {
                                widget.oCard?.todoCardName = text.toString();
                              },
                            )))),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Color',
                    style: TextStyle(
                        color: Colors.black, fontSize: 20, fontFamily: 'Kanit'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 216, 216, 216),
                            style: BorderStyle.solid)),
                    width: MediaQuery.of(context).size.width - 40,
                    height: 300,
                    child: Center(
                        child: Container(
                      transformAlignment: Alignment.topCenter,
                      width: 200,
                      child: BlockPicker(
                        pickerColor: widget.pickerColor, //default color
                        onColorChanged: (Color color) {
                          //on color picked
                          widget.pickerColor = color;
                          widget.oCard?.color = color;
                        },
                      ),
                    ))),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Icon',
                    style: TextStyle(
                        color: Colors.black, fontSize: 20, fontFamily: 'Kanit'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    width: MediaQuery.of(context).size.width - 40,
                    height: 300,
                    child: Center(
                        child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            transformAlignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                                border: Border.all(
                                    color: Color.fromARGB(255, 216, 216, 216),
                                    style: BorderStyle.solid)),
                            width: MediaQuery.of(context).size.width - 40,
                            child: PickerIcon(
                              parentAction: (value) {
                                widget.oCard?.iconID = value;
                                print('==> ${value}');
                              },
                            )))),
              ],
            ),
          ],
        )));
  }

  Future<void> _asyncWarningDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning!'),
          content:
              const Text('Please complate your category info before add new.'),
          actions: <Widget>[
            MaterialButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
