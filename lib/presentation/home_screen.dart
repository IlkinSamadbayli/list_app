import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/presentation/removed_screen.dart';
import 'package:provider_test/style/custom_color.dart';
import 'package:provider_test/style/border_style.dart';
import 'package:sizer/sizer.dart';

import '../provider/task_provider.dart';
import 'list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  final kviewInsets = EdgeInsets.fromWindowPadding(
      WidgetsBinding.instance.window.viewInsets,
      WidgetsBinding.instance.window.devicePixelRatio);
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late FocusNode titleFocus;
  late FocusNode descriptionFocus;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final editKey = GlobalKey<FormState>();

  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    titleFocus = FocusNode();
    descriptionFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    titleFocus.dispose();
    descriptionFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Start a new Routine"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Consumer<TaskProvider>(
              builder: (context, value, child) => GestureDetector(
                onTap: () => Get.to(() => const RemovedScreen()),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.centerLeft,
                  children: [
                    const Icon(Icons.outbox),
                    if (value.documentList.isNotEmpty)
                      Positioned(
                        top: 8,
                        right: 2,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColor.errorColor,
                          ),
                          child: Text(
                            value.documentList.length.toString(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          if (titleFocus.hasFocus) {
            titleFocus.unfocus();
          } else if (descriptionFocus.hasFocus) {
            descriptionFocus.unfocus();
          }
        },
        child: Column(
          children: [
            SizedBox(height: 2.h),
            Expanded(
              child: Consumer<TaskProvider>(
                builder: (context, taskProvider, child) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: StreamBuilder(
                    stream: taskProvider.taskCollection
                        .where("isRemoved", isEqualTo: false)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      late final List<
                              QueryDocumentSnapshot<Map<String, dynamic>>>
                          documents = snapshot.data!.docs;
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
                                  color: CustomColor.versionColorWhite,
                                  strokeWidth: 4),
                            ),
                          ),
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: () async {
                          return Future<void>.delayed(
                              const Duration(seconds: 4));
                        },
                        child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> item = documents[index].data();
                            String docId = documents[index].id;
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
                                          taskProvider.taskCollection
                                              .doc(docId)
                                              .update({"isRemoved": true});
                                        },
                                        backgroundColor: CustomColor.errorColor,
                                        foregroundColor:
                                            CustomColor.versionColorWhite,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: ListItem(
                                    taskLists: taskProvider.taskCollection,
                                    item: item,
                                    taskProvider: taskProvider,
                                    docId: docId,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  taskProvider.documentList.isEmpty
                      ? const SizedBox()
                      : Consumer<TaskProvider>(
                          builder: (context, taskProvider, child) =>
                              FloatingActionButton(
                            heroTag: "btn1",
                            onPressed: () async {
                              loading;
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
                                                  'isRemoved': true,
                                                }),
                                              }
                                          }
                                      })
                                  .whenComplete(() {
                                taskProvider.clearDoclist;
                              });
                              print(
                                  "documentList: ${taskProvider.documentList.length}");
                            },
                            tooltip: 'Delete',
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : const Icon(Icons.delete_rounded),
                          ),
                        ),
                  const SizedBox(width: 16),
                  FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: () async {
                      await Future.delayed(const Duration(seconds: 3));
                      triggerBottomSheet;
                    },
                    tooltip: 'Show',
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void get loading {
    Center(
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

  void get triggerBottomSheet {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 4, color: CustomColor.borderColor),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24))),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding:
              // kviewInsets,
              EdgeInsets.only(
                  top: 50,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: formKey,
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              shrinkWrap: true,
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  validator: (title) {
                    if (title!.isEmpty) {
                      return "The title is empty";
                    }
                    return null;
                  },
                  decoration:
                      AppBorder.kBorderDecoration(hintText: "Enter name"),
                  controller: titleController,
                  focusNode: titleFocus,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  validator: (dec) {
                    if (dec!.isEmpty) {
                      return "The description is empty";
                    }
                    return null;
                  },
                  decoration: AppBorder.kBorderDecoration(
                      hintText: "Enter description"),
                  controller: descriptionController,
                  focusNode: descriptionFocus,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160,
                      child: ElevatedButton(
                          style: AppBorder.kButtonStyle(Colors.red),
                          onPressed: () => Get.back(),
                          child: const Text("Cancel")),
                    ),
                    SizedBox(
                      width: 160,
                      child: Consumer<TaskProvider>(
                        builder: (context, value, child) => ElevatedButton(
                          style: AppBorder.kButtonStyle(Colors.teal),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              value.taskCollection.add({
                                'title': titleController.text,
                                'description': descriptionController.text,
                                'isRemoved': false,
                              });
                              titleController.clear();
                              descriptionController.clear();
                              Get.back();
                            } else {
                              snackbar(false, "Please fill input");
                            }
                          },
                          child: const Text("Add"),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void get triggerLoading async {
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
