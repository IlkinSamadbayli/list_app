import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/list_provider.dart';
import 'package:provider_test/model/list_model.dart';
import 'package:provider_test/presentation/list_item.dart';
import 'package:provider_test/style.dart';
import 'package:sizer/sizer.dart';

class TaskLists extends StatelessWidget {
  const TaskLists({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ListProvider appProvider = Provider.of(context);
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: appProvider.taskLists.length,
      itemBuilder: (context, index) {
        ListModel item = appProvider.taskLists[index];
        ListProvider listProvider = Provider.of(context);

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColor.mainColor,
          ),
          width: 40,
          height: 8.h,
          child: ListItem(item: item, index: index, listProvider: listProvider),
        );
      },
    );
  }
}
