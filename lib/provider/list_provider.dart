import 'package:flutter/material.dart';

import '../model/list_model.dart';

class ListProvider extends ChangeNotifier {
  List<ListModel> taskLists = [];
  List<ListModel> removedLists = [];
  late ListModel item;
  late final int index;
  // Map<int index, bool false> isChecked = ;

  void addItem(ListModel item) {
    taskLists.add(item);
    notifyListeners();
  }

  void returnItem(ListModel item) {
    removedLists.remove(item);
    taskLists.add(item);
    notifyListeners();
  }

  void returnList() {
    removedLists.removeWhere((element) {
      if (element.isChecked == true) {
        // removedLists.remove(element);
        taskLists.add(element);
      }
      return element.isChecked = true;
    });
    for (var el in taskLists) {
      el.isChecked = false;
    }
    notifyListeners();
  }

  void get removeList {
    taskLists.removeWhere((task) {
      if (task.isChecked == true) {
        removedLists.add(task);
      }
      return task.isChecked == true;
    });
    for (var element in removedLists) {
      element.isChecked = false;
    }
    notifyListeners();
  }

  void removeItem(ListModel item) {
    taskLists.remove(item);
    removedLists.add(item);
    notifyListeners();
  }

  void deleteItem(ListModel item) {
    removedLists.remove(item);
    notifyListeners();
  }

  void get emptyTrash {
    removedLists.removeWhere((element) {
      return element.isChecked == true;
    });
    notifyListeners();
  }
}
