import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  List documentList = [];
  CollectionReference taskCollection =
      FirebaseFirestore.instance.collection('tasks');
  late Map item;

  void getCheckedValue({required bool isChecked, required String docId}) {
    if (isChecked) {
      documentList.add(docId);
    } else {
      documentList.remove(docId);
    }
    notifyListeners();
  }

  void get clearDoclist {
    documentList.clear();
    notifyListeners();
  }
}
