import 'dart:math';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trellocards/card_information_page.dart';
import 'package:trellocards/model/cardModel.dart';
import 'package:trellocards/service/database_service.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int myCards = 0;

  void addCard() => myCards++;

  void deleteCards() => myCards--;

  @override
  void initState() {
    getLists();
    super.initState();
  }

  void getLists() async {
    childres[0] = await getCardList(0);
    setState(() {
      childres[0];
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> cards = ["ToDo", "Completed"];
  List<List<CardModel>> childres = [
    [],
    [],
    //["ToDo 1", "ToDo 2"],
    //["Done 1", "Done 2"],
  ];

  String teknikUzman;
  String tahminiSure;
  String gerceklesenSure;
  String isinAciklamasi;
  String notlar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Trello"),
      ),
      body: _buildBody(),
    );
  }

  TextEditingController _cardTextController = TextEditingController();
  TextEditingController _taskTextController = TextEditingController();

  _showAddCard() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Add Card",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Card Title"),
                    controller: _cardTextController,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _addCard(_cardTextController.text.trim());
                    },
                    child: Text("Add Card"),
                  ),
                )
              ],
            ),
          );
        });
  }

  _addCard(String text) {
    cards.add(text);
    childres.add([]);
    _cardTextController.text = "";
    setState(() {});
  }

  _showAddCardTask(int index) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Add Card task",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Task Title"),
                    controller: _taskTextController,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      //_addCardTask(index, _taskTextController.text.trim();
                    },
                    child: Text("Add Task"),
                  ),
                )
              ],
            ),
          );
        });
  }

  // _addCardTask(int index, String text) {
  //   childres[index].add(text);
  //   _taskTextController.text = "";
  //   setState(() {});
  // }

  _handleReOrder(int oldIndex, int newIndex, int index) {
    var oldValue = childres[index][oldIndex];
    childres[index][oldIndex] = childres[index][newIndex];
    childres[index][newIndex] = oldValue;
    setState(() {});
  }

  _buildBody() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: cards.length + 1,
      itemBuilder: (context, index) {
        if (index == cards.length)
          return _buildAddCardWidget(context);
        else
          return _buildCard(context, index);
      },
    );
  }

  Widget _buildAddCardWidget(context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            _showAddCard();
          },
          child: Container(
            width: 300.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    offset: Offset(0, 0),
                    color: Color.fromRGBO(127, 140, 141, 0.5),
                    spreadRadius: 2)
              ],
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.add,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text("Add Card"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddCardTaskWidget(context, index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        onTap: () {
          _showAddCardTask(index);
        },
        child: Row(
          children: <Widget>[
            Icon(
              Icons.add,
            ),
            SizedBox(
              width: 16.0,
            ),
            Text("Add Card Task"),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, int index) {
    // return Container(
    //         width: 300.0,
    //   child: ,
    // );
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            width: 300.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    offset: Offset(0, 0),
                    color: Color.fromRGBO(127, 140, 141, 0.5),
                    spreadRadius: 1)
              ],
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            margin: const EdgeInsets.all(16.0),
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      cards[index],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: DragAndDropList<CardModel>(
                        childres[index],
                        itemBuilder: (BuildContext context, item) {
                          return _buildCardTask(index, childres[index].indexOf(item));
                        },
                        onDragFinish: (oldIndex, newIndex) {
                          _handleReOrder(oldIndex, newIndex, index);
                        },
                        canBeDraggedTo: (one, two) => true,
                        dragElevation: 8.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: FlatButton(
                    //padding: EdgeInsets.all(15),
                    color: Colors.red,
                    onPressed: () => showCustomDialog(index, "add", 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        Text(
                          "Add Card",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: DragTarget<dynamic>(
              onWillAccept: (data) {
                print(data);
                return true;
              },
              onLeave: (data) {},
              onAccept: (data) {
                if (data['from'] == index) {
                  return;
                }
                childres[data['from']].remove(data['string']);
                childres[index].add(data['string']);
                print(data);
                setState(() {});
              },
              builder: (context, accept, reject) {
                print("--- > $accept");
                print(reject);
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  showCustomDialog(int index, String which, int id) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(which == "add" ? "Add A New Card" : "Update Card"),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
                itemCount: 4,
                itemBuilder: (context, index) {
                  return TextFormField(
                    onChanged: (entered) {
                      index == 0
                          ? teknikUzman = entered
                          : index == 1
                              ? gerceklesenSure = entered
                              : index == 2
                                  ? isinAciklamasi = entered
                                  : notlar = entered;
                    },
                    decoration: InputDecoration(
                      hintText: index == 0
                          ? "Teknik Uzman"
                          : index == 1
                              ? "Gerçekleşen Süre"
                              : index == 2
                                  ? "İşin Açıklaması"
                                  : "Notlar",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xff3daecc))),
                    ),
                  );
                },
              ),
            ),
            actions: [
              RaisedButton(
                child: Text(
                  "İptal",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                color: Colors.red,
                onPressed: () => Navigator.pop(context),
              ),
              RaisedButton(
                child: Text(
                  "Kaydet",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    saveInformation(index, which, id);
                    setState(() {
                      getLists();
                    });
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  void saveInformation(int index, String which, int id) async {
    var rng = Random();
    var tahminiSure = rng.nextInt(10) + 1;

    if (teknikUzman == null || isinAciklamasi == null || tahminiSure == null || notlar == null) {
      _snackbar("Please fill all!", Colors.red);
    } else {
      final instance = Provider.of<DatabaseService>(context, listen: false);
      CardModel cardModel = CardModel(
        teknikUzman: teknikUzman,
        taskId: index,
        tahminiSure: tahminiSure.toString(),
        gerceklesenSure: gerceklesenSure,
        isinAciklamasi: isinAciklamasi,
        notlar: notlar,
      );
      await instance.open();
      if (which == "add")
        await instance.addCard(cardModel);
      else
        await instance.updateCard(id, cardModel);
    }
  }

  Future<List<CardModel>> getCardList(int index) async {
    final instance = Provider.of<DatabaseService>(context, listen: false);
    await instance.open();
    List<CardModel> result = await instance.getCardList(index);
    return result;
  }

  Widget _snackbar(String message, Color color) {
    return Flushbar(
      message: message,
      flushbarPosition: FlushbarPosition.BOTTOM,
      backgroundColor: color,
      icon: Icon(
        color == Colors.red ? Icons.close : Icons.done,
        size: 28.0,
        color: Colors.white,
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
      duration: Duration(seconds: 5),
    )..show(_scaffoldKey.currentState.context);
  }

  deleteCard(int index) async {
    final instance = Provider.of<DatabaseService>(context, listen: false);
    await instance.open();
    print(index);
    bool result = await instance.deleteCard(index);
    if (result)
      _snackbar("Card deleted", Colors.lightGreen);
    else
      _snackbar("The card could not be deleted!", Colors.red);
  }

  Container _buildCardTask(int index, int innerIndex) {
    return Container(
      width: 300.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Draggable<dynamic>(
        feedback: Material(
          elevation: 5.0,
          child: Container(
            width: 284.0,
            padding: const EdgeInsets.all(16.0),
            color: Colors.redAccent,
            child: Text(childres[index][innerIndex].notlar),
          ),
        ),
        childWhenDragging: Container(),
        child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                      CardInformationPage(index: (childres[index][innerIndex].id - 1)))),
          child: Container(
            height: 50,
            color: Colors.greenAccent,
            child: ListTile(
              title: Text(childres[index][innerIndex].notlar),
              trailing: Container(
                width: 50,
                child: Row(children: [
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          deleteCard(childres[index][innerIndex].id);
                          childres[0].removeAt(innerIndex);
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.update),
                      onPressed: () {
                        showCustomDialog(childres[index][innerIndex].taskId, "update",
                            childres[index][innerIndex].id);
                      },
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
        data: {"from": index, "string": childres[index][innerIndex]},
      ),
    );
  }
}
