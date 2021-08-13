import 'package:flutter/foundation.dart';

class LanguageLoad with ChangeNotifier{
  String _langSet = 'kor';
  String _currentlangSet = 'eng';

  String get langSet => _langSet;  
  String get currentlangSet => _currentlangSet;  


  void engLoad() {
    _langSet = "eng";
    _currentlangSet = _langSet;
    notifyListeners();
  }
  void korLoad() {
    _langSet = "kor";
    _currentlangSet = _langSet;
     notifyListeners();
  }
  void japLoad() {
    _langSet = "jap";
    _currentlangSet = _langSet;
     notifyListeners();
  }
  void chnLoad() {
    _langSet = "chn";
    _currentlangSet = _langSet;
     notifyListeners();
  }
  void gerLoad() {
    _langSet = "ger";
    _currentlangSet = _langSet;
     notifyListeners();
  }
  void vtnLoad() {
    _langSet = "vtn";
    _currentlangSet = _langSet;
     notifyListeners();
  }
  void currentLoad() {
    _langSet = currentlangSet;
     notifyListeners();
  }
}