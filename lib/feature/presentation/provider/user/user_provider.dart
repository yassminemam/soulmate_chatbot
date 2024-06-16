import 'package:flutter/foundation.dart';
import '../../../data/model/character.dart';
import '../../../data/model/user.dart';
class UserChangeNotifier with ChangeNotifier, DiagnosticableTreeMixin {
  final User _user = User();

  User get user => _user;

  void setUserName({required String? name}) {
    _user.name = name;
    notifyListeners();
  }
  void setUserAge({required String? age}) {
    _user.age = age;
    notifyListeners();
  }
  void setBotType({required CharacterType botType}) {
    _user.selectedBotChar = Character(type: botType);
    notifyListeners();
  }
  void setUserInterests({required List<String> interests}) {
    _user.interests = interests;
    notifyListeners();
  }
  void setBotName({required String botName}) {
    _user.selectedBotChar?.name = botName;
    notifyListeners();
  }
  void setBotAge({required String botAge}) {
    _user.selectedBotChar?.age = botAge;
    notifyListeners();
  }
}