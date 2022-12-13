import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/model/list_model.dart';
import 'package:provider_test/presentation/preference_service.dart';
import 'package:provider_test/presentation/removed_screen.dart';
import 'package:provider_test/presentation/task_lists.dart';
import 'package:provider_test/style/custom_color.dart';
import 'package:provider_test/style/border_style.dart';
import 'package:sizer/sizer.dart';

import '../provider/list_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final preference = PreferenceService();
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

  void saveSetting(
      {required List<ListModel> taskLists,
      required ListProvider listProvider}) {
    // taskLists.map((e) => e.title = int.parse(titleController.text));
    // taskLists.map((e) => e.description = descriptionController.text);
    // taskLists.map((e) => e.isChecked = e.isChecked);
    ListModel(
        title: int.parse(titleController.text),
        description: descriptionController.text);
    preference.saveSetting(
        tasklist: listProvider.taskLists, item: listProvider.item);
  }

  void populateField(ListProvider listProvider) async {
    ListModel listModel = await preference.getSetting();
    titleController.text = listModel.title.toString();
    descriptionController.text = listModel.description;
  }

  @override
  void initState() {
    final listprovider = Provider.of<ListProvider>(context, listen: false);
    populateField(listprovider);
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
    final listProvider = Provider.of<ListProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: AppBar(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: RawMaterialButton(
              fillColor: Colors.blue,
              onPressed: () => saveSetting(
                    taskLists: listProvider.taskLists,
                    listProvider: listProvider,
                  ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text("Save Settings"),
              )),
        ),
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
            SizedBox(height: 2.h),
            const TaskLists(),
            SizedBox(height: 2.h),
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
                  keyboardType: TextInputType.number,
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
                Consumer<ListProvider>(
                  builder: (context, value, child) {
                    return ElevatedButton(
                      style: AppBorder.kButtonStyle,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          value.addItem(ListModel(
                              title: int.parse(titleController.text),
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
