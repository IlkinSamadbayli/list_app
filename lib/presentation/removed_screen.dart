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
  bool isLoading = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndigatorKey =
      GlobalKey<RefreshIndicatorState>();
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
              onTap: () async {
                await _refreshIndigatorKey.currentState?.show();
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
            return Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(12),
                  color: CustomColor.mainColor,
                  child: CircularProgressIndicator(
                      color: CustomColor.versionColorWhite, strokeWidth: 4),
                ),
              ),
            );
          }
          return Column(
            children: [
              SizedBox(height: 2.h),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      Future<void>.delayed(const Duration(seconds: 2));
                    },
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
                                      print(taskProvider.documentList);
                                      taskProvider.taskCollection
                                          .doc(docId)
                                          .delete()
                                          .whenComplete(() => {
                                                snackbar(true,
                                                    'Deleted Successfully'),
                                                taskProvider.clearDoclist,
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
              ),
              taskProvider.documentList.isEmpty
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(right: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Consumer<TaskProvider>(
                            builder: (context, value, child) =>
                                FloatingActionButton(
                              heroTag: "btn3",
                              onPressed: () {
                                loading;
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
                                          if (taskProvider
                                              .documentList.isNotEmpty)
                                            {
                                              snackbar(
                                                  true, 'Deleted Successfully'),
                                            },
                                          taskProvider.clearDoclist,
                                        });
                              },
                              tooltip: 'Delete',
                              child: isLoading
                                  ? CircularProgressIndicator(
                                      color: CustomColor.versionColorWhite)
                                  : const Icon(Icons.delete),
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

  void get loading async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      isLoading = false;
    });
  }

  void snackbar(bool isSuccess, String message) {
    Get.snackbar('Snackbar', message,
        colorText: CustomColor.versionColorWhite,
        backgroundColor:
            isSuccess ? CustomColor.mainColor : CustomColor.errorColor,
        padding: const EdgeInsets.all(20),
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 5),
        duration: const Duration(milliseconds: 1200));
  }
}
