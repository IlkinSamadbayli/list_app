// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:provider_test/app_provider.dart';
import 'package:provider_test/model/list_model.dart';

class ListItem extends StatelessWidget {
  final ListModel item;
  ListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Consumer<AppProvider>(
        builder: (context, appProvider, child) => Checkbox(
            value: appProvider.isChecked,
            onChanged: (value) {
              appProvider.checked;
            }),
      ),
      title: Text(
        item.name,
        style: TextStyle(
          decoration:
              isChecked ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: Text(
        item.description,
        style: TextStyle(
          decoration:
              isChecked ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
    );
  }
}
