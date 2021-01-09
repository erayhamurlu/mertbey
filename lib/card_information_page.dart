import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trellocards/service/database_service.dart';

import 'model/cardModel.dart';

// ignore: must_be_immutable
class CardInformationPage extends StatefulWidget {
  int index;

  CardInformationPage({this.index});
  @override
  _CardInformationPageState createState() => _CardInformationPageState();
}

class _CardInformationPageState extends State<CardInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card Information"),
        centerTitle: true,
        backgroundColor: Color(0xff3497b1),
      ),
      body: FutureBuilder<CardModel>(
        future: getCardInformation(),
        builder: (context, result) {
          return result.hasData
              ? Container(
                  height: double.infinity,
                  color: Color(0xff3daecc).withOpacity(0.6),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xff3497b1),
                          radius: 40,
                          child: Text(
                            result.data.teknikUzman.substring(0, 1).toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(result.data.teknikUzman,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tahmini S.: " + result.data.tahminiSure,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text("Gerçekleşen S.: " + result.data.gerceklesenSure,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Açıklama",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ))),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Text(result.data.isinAciklamasi,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              )),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20.0,
                                spreadRadius: 1.0,
                                offset: Offset(
                                  10.0,
                                  10.0,
                                ),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 10),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Notlar",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ))),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Text(result.data.notlar,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              )),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20.0,
                                spreadRadius: 1.0,
                                offset: Offset(
                                  10.0,
                                  10.0,
                                ),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<CardModel> getCardInformation() async {
    final instance = Provider.of<DatabaseService>(context, listen: false);
    await instance.open();
    CardModel model = await instance.getIdCard(widget.index);
    debugPrint("modell " + model.toString());
    debugPrint("indexx" + widget.index.toString());
    return model;
  }
}
