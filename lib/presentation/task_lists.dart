import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../provider/list_provider.dart';
import '../style/custom_color.dart';
import 'list_item.dart';

class TaskLists extends StatelessWidget {
  const TaskLists({super.key});

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListProvider>(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: StreamBuilder(
          stream: listProvider.taskCollection.snapshots(),
          builder: (context, snapshot) {
            // final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
            //     snapshot.data!.docs;
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> item = snapshot.data!.docs[index].data();
                ListProvider listProvider = Provider.of(context);
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
                            onPressed: (context) {
                              // listProvider.removeItem(item);
                            },
                            backgroundColor: CustomColor.errorColor,
                            foregroundColor: CustomColor.versionColorWhite,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: ListItem(
                        taskLists: listProvider.taskCollection,
                        item: item,
                        index: index,
                        listProvider: listProvider,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
