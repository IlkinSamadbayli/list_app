import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/model/list_model.dart';
import 'package:provider_test/style.dart';
import 'package:sizer/sizer.dart';

import '../provider/list_provider.dart';
import 'list_item.dart';

class RemovedList extends StatefulWidget {
  const RemovedList({super.key});

  @override
  State<RemovedList> createState() => _RemovedListState();
}

class _RemovedListState extends State<RemovedList> {
  @override
  Widget build(BuildContext context) {
    ListProvider listProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Removed List"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 5.h),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemCount: listProvider.removedLists.length,
                itemBuilder: (context, index) {
                  // ListModel list = listProvider.removedLists[index];
                  ListModel item = listProvider.removedLists[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: CustomColor.primaryColor,
                    ),
                    width: 40,
                    height: 10.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {},
                              backgroundColor: CustomColor.errorColor,
                              foregroundColor: CustomColor.textColor,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: ListItem(
                            item: item,
                            index: index,
                            listProvider: listProvider),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
