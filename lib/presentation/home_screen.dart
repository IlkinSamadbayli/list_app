import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/model/list_model.dart';
import 'package:provider_test/presentation/removed_screen.dart';
import 'package:provider_test/style/custom_color.dart';
import 'package:provider_test/style/border_style.dart';
import 'package:sizer/sizer.dart';

import '../provider/list_provider.dart';
import 'list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    ListProvider appProvider = Provider.of(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Start a new Routine"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Consumer<ListProvider>(
              builder: (context, value, child) => GestureDetector(
                onTap: () => Get.to(() => const RemovedScreen()),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.centerLeft,
                  children: [
                    const Icon(Icons.outbox),
                    if (value.removedLists.isNotEmpty)
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
                            value.removedLists.length.toString(),
                            style: const TextStyle(
                                // fontSize: 17,
                                ),
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
            SizedBox(height: 5.h),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: appProvider.taskLists.length,
                  itemBuilder: (context, index) {
                    ListProvider listProvider = Provider.of(context);
                    ListModel item = listProvider.taskLists[index];
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
                                  listProvider.removeItem(item);
                                },
                                backgroundColor: CustomColor.errorColor,
                                foregroundColor: CustomColor.versionColorWhite,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                
                          child: ListItem(
                            item: item,
                            index: index,
                            listProvider: listProvider,
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
                  Consumer<ListProvider>(
                    builder: (context, value, child) => FloatingActionButton(
                      heroTag: "btn1",
                      onPressed: () {
                        value.removeList;
                      },
                      tooltip: 'Delete',
                      child: const Icon(Icons.delete_rounded),
                    ),
                  ),
                  const SizedBox(width: 16),
                  FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: () {
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

  void get triggerBottomSheet {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 4, color: CustomColor.borderColor),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24))),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
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
                Consumer<ListProvider>(
                  builder: (context, value, child) {
                    return ElevatedButton(
                      style: AppBorder.kButtonStyle,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          value.addItem(ListModel(
                              title: titleController.text,
                              description: descriptionController.text));
                          titleController.clear();
                          descriptionController.clear();
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                action: SnackBarAction(
                                  label: "Undo",
                                  onPressed: () => Get.back(),
                                ),
                                content: const Text("Error"),
                                dismissDirection: DismissDirection.up,
                                backgroundColor: CustomColor.errorColor),
                          );
                        }
                      },
                      child: const Text("Add"),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
