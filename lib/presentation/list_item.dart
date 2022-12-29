// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:provider_test/provider/task_provider.dart';
import 'package:provider_test/style/custom_color.dart';

class ListItem extends StatefulWidget {
  final Map item;
  final TaskProvider taskProvider;
  final CollectionReference taskLists;
  final String docId;
  const ListItem({
    Key? key,
    required this.item,
    required this.taskProvider,
    required this.taskLists,
    required this.docId,
  }) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    if (taskProvider.documentList.isEmpty) {
      isChecked = false;
      setState(() {});
    }
    return CheckboxListTile(
      activeColor: CustomColor.errorColor,
      value: isChecked,
      onChanged: (value) {
        setState(() {});
        isChecked = value!;
        taskProvider.getCheckedValue(isChecked: isChecked, docId: widget.docId);
      },
      title: Column(
        children: [
          const SizedBox(height: 14),
          Text(
            "${widget.item['title']}",
            style: TextStyle(
              fontSize: 24,
              color: CustomColor.versionColorWhite,
              fontWeight: FontWeight.bold,
              decoration:
                  isChecked ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          Text(
            widget.item['description'],
            style: TextStyle(
              color: CustomColor.versionColorWhite.withOpacity(.6),
              fontStyle: FontStyle.italic,
              decoration:
                  isChecked ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
