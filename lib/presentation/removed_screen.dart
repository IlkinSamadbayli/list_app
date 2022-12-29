import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/provider/task_provider.dart';
import 'package:provider_test/style/custom_color.dart';
import 'package:sizer/sizer.dart';

import 'list_item.dart';

class RemovedScreen extends StatefulWidget {
  const RemovedScreen({super.key});

  @override
  State<RemovedScreen> createState() => _RemovedScreenState();
}

class _RemovedScreenState extends State<RemovedScreen> {
  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
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
                taskProvider.taskCollection
                    .get()
                    .then((documents) => {
                          for (var document in documents.docs)
                            {
                              if (taskProvider.documentList
                                  .contains(document.id))
                                {
                                  taskProvider.taskCollection
                                      .doc(document.id)
                                      .update({
                                    'isRemoved': false,
                                  }),
                                }
                            }
                        })
                    .whenComplete(() {
                  taskProvider.clearDoclist;
                });
                print("documentList: ${taskProvider.documentList.length}");
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Icons.recycling_outlined),
              ))
        ],
      ),
      body: StreamBuilder(
        stream: taskProvider.taskCollection
            .where('isRemoved', isEqualTo: true)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          late List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
              snapshot.data!.docs;
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return Column(
            children: [
              SizedBox(height: 2.h),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      String docId = documents[index].id;
                      Map<String, dynamic> item = documents[index].data();
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
                            endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      taskProvider.taskCollection
                                          .doc(docId)
                                          .update({'isRemoved': false});
                                    },
                                    backgroundColor: CustomColor.mainColor,
                                    foregroundColor:
                                        CustomColor.versionColorWhite,
                                    icon: Icons.redo_rounded,
                                    label: 'Bring it back',
                                  ),
                                ]),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    taskProvider.taskCollection
                                        .doc(docId)
                                        .delete()
                                        .whenComplete(() => {
                                              Get.snackbar('Snackbar',
                                                  'Deleted Successfully',
                                                  colorText: CustomColor
                                                      .versionColorWhite,
                                                  backgroundColor:
                                                      CustomColor.mainColor,
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  margin:
                                                      const EdgeInsets.all(60),
                                                  duration: const Duration(
                                                      milliseconds: 800))
                                            });
                                  },
                                  backgroundColor: CustomColor.errorColor,
                                  foregroundColor:
                                      CustomColor.versionColorWhite,
                                  icon: Icons.delete_forever,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            // child: const Text("remove test"),
                            child: ListItem(
                              docId: docId,
                              item: item,
                              taskProvider: taskProvider,
                              taskLists: taskProvider.taskCollection,
                            ),
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
                    Consumer<TaskProvider>(
                      builder: (context, value, child) => FloatingActionButton(
                        heroTag: "btn3",
                        onPressed: () {
                          value.taskCollection
                              .get()
                              .then((documents) => {
                                    for (var document in documents.docs)
                                      {
                                        if (taskProvider.documentList
                                            .contains(document.id))
                                          {
                                            value.taskCollection
                                                .doc(document.id)
                                                .delete()
                                          }
                                      }
                                  })
                              .whenComplete(() => {
                                    taskProvider.clearDoclist,
                                    Get.snackbar(
                                        'Snackbar', 'Deleted Successfully',
                                        colorText:
                                            CustomColor.versionColorWhite,
                                        backgroundColor: CustomColor.mainColor,
                                        padding: const EdgeInsets.all(20),
                                        margin: const EdgeInsets.all(60),
                                        duration:
                                            const Duration(milliseconds: 800))
                                  });
                        },
                        tooltip: 'Delete',
                        child: const Icon(Icons.delete),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
