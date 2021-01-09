import 'package:trellocards/model/cardModel.dart';
import 'package:trellocards/repository/database_repository.dart';
import 'package:trellocards/repository/interface/idatabase.dart';

class DatabaseService extends IDatabase {
  DatabaseRepository databaseRepository = DatabaseRepository();
  @override
  Future<bool> addCard(CardModel model) async {
    try {
      final result = await databaseRepository.addCard(model);
      return result;
    } catch (e) {
      print("ViewModel addCard hata: " + e.toString());
    }

    return null;
  }

  @override
  Future<bool> deleteCard(int id) async {
    try {
      final result = await databaseRepository.deleteCard(id);
      return result;
    } catch (e) {
      print("ViewModel deleteCard hata: " + e.toString());
    }

    return null;
  }

  @override
  Future<List<CardModel>> getCardList(int comingTaskId) async {
    try {
      final result = await databaseRepository.getCardList(comingTaskId);
      return result;
    } catch (e) {
      print("ViewModel getCardList hata: " + e.toString());
    }

    return null;
  }

  @override
  Future<CardModel> getIdCard(int id) async {
    try {
      final result = await databaseRepository.getIdCard(id);
      return result;
    } catch (e) {
      print("ViewModel getIdCard hata: " + e.toString());
    }

    return null;
  }

  @override
  Future open() async {
    try {
      final result = await databaseRepository.open();
      return result;
    } catch (e) {
      print("ViewModel open hata: " + e.toString());
    }

    return null;
  }

  @override
  Future<bool> updateCard(int id, CardModel model) async {
    try {
      final result = await databaseRepository.updateCard(id, model);
      return result;
    } catch (e) {
      print("ViewModel updateCard hata: " + e.toString());
    }

    return null;
  }

  @override
  Future close() async {
    try {
      final result = await databaseRepository.close();
      return result;
    } catch (e) {
      print("ViewModel close hata: " + e.toString());
    }

    return null;
  }
}
