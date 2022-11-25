import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  void get increment {
    _counter++;
    notifyListeners();
  }

  void get decreacement {
    _counter--;
    notifyListeners();
  }


  void get reset{
    _counter = 0;
    notifyListeners();
  }
}
