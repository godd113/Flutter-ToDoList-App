import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:todo/databases/todo_list_db.dart';
import 'package:todo/databases/users_db.dart';
import 'package:todo/models/modelTextToDo.dart';
import 'package:todo/models/modelToDoCard.dart';
import 'package:todo/modules/module_center.dart';
import 'package:todo/pages/card_manager.dart';
import '../modules/module_colors.dart';
import '../widgets/card_todo.dart';
import '../models/modelUser.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});
  final double addBtnSize = 30;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late ToDoListDatabase _db;
  late UserDatabase _userdb;
  late List<ModelToDoCard> listToDoCard;
  late ModelUser oUser =
      ModelUser(userID: 0, userName: "", email: "", uuid: "");

  @override
  void initState() {
    // TODO: implement initState
    _db = ToDoListDatabase.instance;
    _userdb = UserDatabase.instance;
    getDBToDoList();
    //_db.create(ModuleCenter.listCards[0].oModelCard);
    super.initState();
  }

  Future<void> getDBToDoList() async {
    ModuleCenter.listCards = [];
    List<ModelTextToDo> listItem = [];
    listToDoCard = await _db.selectDataFromTable();
    List<ModelUser> listUser =
        await _userdb.selectDataFromTableByUUID("userUUID");
    if (listUser.isNotEmpty) {
      oUser = listUser[0];
    }
    int i = 0;
    setState(() {
      //-- Default the first one
      if (listToDoCard.length == 0 && oUser.uuid == "") {
        addNewList(ModelToDoCard(
            todoCardID: int.parse(ModuleCenter.genIDByDatetimeNow()),
            todoCardName: "ToDo",
            todoCardTaskNum: "0",
            iconID: 1,
            color: ModuleColors.defualtColorCard,
            listToDo: []));
        oUser.userID = 1;
        oUser.uuid = "userUUID";
        _userdb.create(oUser);
      } else {
        for (var element in listToDoCard) {
          ModuleCenter.listCards.add(CardToDo(
            oModelCard: element,
            parentAction: _cardAction,
          ));
          i += 1;
        }
        ModuleCenter.listCards.sort((a, b) =>
            b.oModelCard.todoCardID.compareTo(a.oModelCard.todoCardID));
      }
    });
  }

  Future<void> _cardAction(CardToDo oCard) async {
    int index = ModuleCenter.listCards.indexWhere((element) =>
        element.oModelCard.todoCardID == oCard.oModelCard.todoCardID);
    _db.delete(oCard.oModelCard.todoCardID);
    setState(() {
      ModuleCenter.listCards.removeAt(index);
    });
  }

  Future<String> clickSetting() async {
    print('click setting');
    return 'click';
  }

  Future<void> addNewList(ModelToDoCard oModelCard) async {
    ModuleCenter.listCards.add(CardToDo(
      oModelCard: oModelCard,
      parentAction: _cardAction,
    ));
    ModuleCenter.listCards.sort(
        (a, b) => b.oModelCard.todoCardID.compareTo(a.oModelCard.todoCardID));
    _db.create(oModelCard);
  }

  @override
  Widget build(BuildContext context) {
    final double screenDeviceSize = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('To Do List'),
          backgroundColor: ModuleColors.themeColor,
          automaticallyImplyLeading: false, // This will remove the back button
          leading: GestureDetector(
            child: const Icon(Icons.settings),
            onTap: () {
              Future<String> ret = clickSetting();
              print(ret);
            },
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
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
        ));
  }
}
