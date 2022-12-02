import 'package:flutter/material.dart';


class AppProvider extends ChangeNotifier {
bool isChecked = false;
  int _counter = 0;
  int get counter => _counter;


void get checked{
  isChecked=!isChecked;
  notifyListeners();
}


  void get increment {
    _counter++;
    notifyListeners();
  }

  void get decreacement {
    _counter--;
    if (_counter == -1) _counter = 0;
    notifyListeners();
  }

  void get reset {
    _counter = 0;
    notifyListeners();
  }
}
