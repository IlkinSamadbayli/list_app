import 'package:flutter/material.dart';

import 'model/list_model.dart';

class ListProvider extends ChangeNotifier {
  List<ListModel> taskLists = [];
  List<ListModel> removedLists = [];
  late int index;

  void addItem(ListModel item) {
    taskLists.add(item);
    notifyListeners();
  }

  // void removeItem(){
  //   taskLists.removeWhere((element) {
  //     if(element.isChecked==true)
  //     return element.isChecked==true;
  //   })
  // }


}
