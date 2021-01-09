import 'package:trellocards/model/cardModel.dart';

abstract class IDatabase {
  Future open();
  Future<List<CardModel>> getCardList(int comingTaskId);
  Future<CardModel> getIdCard(int id);
  Future<bool> deleteCard(int id);
  Future<bool> addCard(CardModel model);
  Future<bool> updateCard(int id, CardModel model);
  Future close();
}
