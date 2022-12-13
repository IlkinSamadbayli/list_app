// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:provider_test/model/list_model.dart';
import 'package:provider_test/provider/list_provider.dart';
import 'package:provider_test/style/custom_color.dart';

class ListItem extends StatefulWidget {
  final ListModel item;
  final int index;
  final ListProvider listProvider;
  // final ListProvider listProvider;
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
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Checkbox(
            activeColor: CustomColor.errorColor,
            value: widget.item.isChecked,
            onChanged: (value) {
              setState(() {});
              widget.item.isChecked = value!;
            }),
      ),
      title: Column(
        children: [
          const SizedBox(height: 14),
          Text(
            "${widget.item.title}",
            style: TextStyle(
              fontSize: 24,
              color: CustomColor.versionColorWhite,
              fontWeight: FontWeight.bold,
              decoration:
                  widget.item.isChecked ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          Text(
            widget.item.description,
            style: TextStyle(
              color: CustomColor.versionColorWhite.withOpacity(.6),
              fontStyle: FontStyle.italic,
              decoration:
                  widget.item.isChecked ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
