import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class OnePhraseProvider with ChangeNotifier{
  String _engpLoad = 'eng';
  String _korpLoad = 'kor';
  String _korprnpLoad = 'korprn';
  String _jappLoad = 'jap';
  String _japprnpLoad = 'japprn';

  String get geteng => _engpLoad;  
  String get getkor => _korpLoad;  
  String get getkorprn => _korprnpLoad;  
  String get getjapp => _jappLoad;  
  String get getjapprn => _japprnpLoad;  


  void seteng(String engphrase) {
    _engpLoad = engphrase ;
    notifyListeners();
  }
  void setkor(String korphrase) {
    _engpLoad = korphrase;
    notifyListeners();
  }
  void setkorprn(String korprnphrase) {
    _engpLoad = korprnphrase;
    notifyListeners();
  }
  void setjap(String japphrase) {
    _engpLoad = japphrase;
    notifyListeners();
  }
  void setjapprn(String japprnphrase) {
    _engpLoad = japprnphrase;
    notifyListeners();
  }
  
}