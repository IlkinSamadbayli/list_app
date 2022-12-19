import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/provider/list_provider.dart';
import 'package:provider_test/style/custom_color.dart';
import 'package:sizer/sizer.dart';


class RemovedScreen extends StatefulWidget {
  const RemovedScreen({super.key});

  @override
  State<RemovedScreen> createState() => _RemovedScreenState();
}

class _RemovedScreenState extends State<RemovedScreen> {
  @override
  Widget build(BuildContext context) {
    ListProvider removedProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_circle_left_outlined),
        ),
        title: const Text("Removed List"),
        centerTitle: true,
        actions: [
          GestureDetector(
              onTap: () {
                // removedProvider.returnList;
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Icons.recycling_outlined),
              ))
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 2.h),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemCount: removedProvider.removedLists.length,
                itemBuilder: (context, index) {
                  // ListModel item = removedProvider.removedLists[index];
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
                        endActionPane:
                            ActionPane(motion: const ScrollMotion(), children: [
                          SlidableAction(
                            onPressed: (context) {
                              // removedProvider.returnItem(item);
                            },
                            backgroundColor: CustomColor.mainColor,
                            foregroundColor: CustomColor.versionColorWhite,
                            icon: Icons.redo_rounded,
                            label: 'Bring it back',
                          ),
                        ]),
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                // removedProvider.deleteItem(item);
                              },
                              backgroundColor: CustomColor.errorColor,
                              foregroundColor: CustomColor.versionColorWhite,
                              icon: Icons.delete_forever,
                              label: 'Delete',
                            ),
                          ],
                        ), child: const Text("remove test"),
                        // child: ListItem(
                        //   item: item,
                        //   index: index,
                        //   listProvider: removedProvider,
                        // ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Consumer<ListProvider>(
                  builder: (context, value, child) => FloatingActionButton(
                    heroTag: "btn3",
                    onPressed: () {
                      // value.emptyTrash;
                    },
                    tooltip: 'Delete',
                    child: const Icon(Icons.delete),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
