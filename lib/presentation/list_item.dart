// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:provider_test/list_provider.dart';
import 'package:provider_test/model/list_model.dart';
import 'package:provider_test/style.dart';

class ListItem extends StatefulWidget {
  final ListModel item;
  final int index;
  final ListProvider listProvider;
  const ListItem({
    Key? key,
    required this.item,
    required this.index,
    required this.listProvider,
  }) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {});
            isChecked = value!;
          }),
      title: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            widget.item.title,
            style: TextStyle(
              color: CustomColor.textColor,
              fontWeight: FontWeight.bold,
              decoration:
                  isChecked ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          Text(
            widget.item.description,
            style: TextStyle(
              color: CustomColor.textColor,
              fontStyle: FontStyle.italic,
              decoration:
                  isChecked ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
        ],
      ),
      trailing: Consumer<ListProvider>(
        builder: (context, value, child) => GestureDetector(
          onTap: () {
            // value.removeItem;
          },
          child: Icon(
            Icons.delete,
            color: CustomColor.errorColor,
          ),
        ),
      ),
    );
  }
}
