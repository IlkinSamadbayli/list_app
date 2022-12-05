import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/model/list_model.dart';
import 'package:provider_test/presentation/task_lists.dart';
import 'package:provider_test/style.dart';
import 'package:provider_test/style/border_style.dart';
import 'package:sizer/sizer.dart';

import '../list_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final List<ListModel> lists = [];
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late FocusNode titleFocus;
  late FocusNode descriptionFocus;
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Consumer<ListProvider>(
              builder: (context, value, child) => Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.centerLeft,
                children: [
                  const Icon(Icons.delete),
                  if (value.taskLists.isNotEmpty)
                    Positioned(
                      top: 8,
                      right: -3,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomColor.errorColor,
                        ),
                        child: Text(
                          value.taskLists.length.toString(),
                          style: const TextStyle(
                              // fontSize: 17,
                              ),
                        ),
                      ),
                    ),
                ],
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
                child: const TaskLists(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {},
                    tooltip: 'Delete',
                    child: const Icon(Icons.delete),
                  ),
                  const SizedBox(width: 16),
                  FloatingActionButton(
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
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            shrinkWrap: true,
            children: [
              TextField(
                decoration: AppBorder.kBorderDecoration(hintText: "Enter name"),
                controller: titleController,
                focusNode: titleFocus,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration:
                    AppBorder.kBorderDecoration(hintText: "Enter information"),
                controller: descriptionController,
                focusNode: descriptionFocus,
              ),
              const SizedBox(height: 20),
              Consumer<ListProvider>(
                builder: (context, value, child) => ElevatedButton(
                  style: AppBorder.kButtonStyle,
                  onPressed: () {
                    value.addItem(ListModel(
                        title: titleController.text,
                        description: descriptionController.text));
                    print(value.taskLists);
                    titleController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Add"),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
