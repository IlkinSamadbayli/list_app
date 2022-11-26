// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:provider_test/model/product_model.dart';

class ListItem extends StatelessWidget {
  final ProductModel item;
  const ListItem({
    Key? key,
    required this.item,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        onChanged: (value) {},
        value: item.isChecked,
      ),
      title: Text(item.name),
      trailing: Text(item.expression),
    );
  }
}
