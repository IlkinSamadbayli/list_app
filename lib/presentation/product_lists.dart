import 'package:flutter/material.dart';
import 'package:provider_test/model/product_data.dart';
import 'package:provider_test/presentation/list_item.dart';
import 'package:sizer/sizer.dart';

class ProductLists extends StatelessWidget {
  const ProductLists({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: ProductData.items.length,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        width: 40,
        height: 8.h,
        child: ListItem(item: ProductData.items[index]),
      ),
    );
  }
}
