import 'package:flutter/material.dart';
import 'package:provider_test/model/list_data.dart';
import 'package:provider_test/presentation/list_item.dart';
import 'package:sizer/sizer.dart';

class TaskLists extends StatelessWidget {
  const TaskLists({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ListData listData = ListData();
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: listData.toDoLists.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          width: 40,
          height: 8.h,
          child: ListItem(item: listData.toDoLists[index]),
        );
      },
    );
  }
}
