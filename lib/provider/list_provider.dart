import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/list_model.dart';

class ListProvider extends ChangeNotifier {
  // final List<QueryDocumentSnapshot<Map<String, dynamic>>> taskLists = [];
  List<ListModel> removedLists = [];
  late final Map<String, dynamic> item;
  late final int index;
  final taskCollection = FirebaseFirestore.instance.collection('tasks');

  // void addItem() {
  //   taskCollection.add(item);
  //   notifyListeners();
  // }

  // void returnItem() {
  //   // removedLists.remove(item);
  //   taskCollection.add(item);
  //   notifyListeners();
  }

  // void get returnList {
  //   removedLists.removeWhere((e) {
  //     if (e.isChecked == true) {
  //       taskLists.add(e);
  //     }
  //     return e.isChecked == true;
  //   });
  //   for (var el in taskLists) {
  //     el.isChecked = false;
  //   }
  //   notifyListeners();
  // }

  // void get emptyTrash {
  //   removedLists.removeWhere((element) {
  //     return element.isChecked == true;
  //   });
  //   notifyListeners();
  // }

  // void get removeList {
  //   taskCollection.removeWhere((task) {
  //     if (task['isChecked'] == true) {
  //       // removedLists.add(task);
  //     }
  //     return task['isChecked'] == true;
  //   });
  //   for (var element in removedLists) {
  //     element.isChecked = false;
  //   }
  //   notifyListeners();
  // }

  // void removeItem() {
  //   taskCollection.remove(item);
  //   // removedLists.add(item);
  //   notifyListeners();
  // }

//   void deleteItem(ListModel item) {
//     removedLists.remove(item);
//     notifyListeners();
//   }
// }
