import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/model/list_data.dart';
import 'package:provider_test/model/list_model.dart';
import 'package:provider_test/presentation/task_lists.dart';
import 'package:provider_test/style/border_style.dart';
import 'package:sizer/sizer.dart';

import '../app_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ListData listData = ListData();
  late TextEditingController nameController;
  late TextEditingController expressionController;
  @override
  void initState() {
    nameController = TextEditingController();
    expressionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    expressionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          SizedBox(height: 5.h),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const TaskLists(),
            ),
          ),
          Expanded(
            child: Consumer<AppProvider>(
              builder: (context, appProvider, child) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Container(
                    color: Colors.tealAccent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                      child: Text(
                        listData.toDoLists.length.toString(),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // FloatingActionButton(
                        //   onPressed: () => appProvider.decreacement,
                        //   tooltip: 'Decreament',
                        //   child: const Icon(Icons.remove),
                        // ),
                        // FloatingActionButton(
                        //   onPressed: () => appProvider.reset,
                        //   tooltip: 'Reset',
                        //   child: const Icon(Icons.restore_outlined),
                        // ),
                        FloatingActionButton(
                          onPressed: () {
                            triggerBottomSheet;
                          },
                          tooltip: 'Show',
                          child: const Icon(Icons.add),
                        ),
                      ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void get triggerBottomSheet {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(50),
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            shrinkWrap: true,
            children: [
              TextFormField(
                
                decoration: AppBorder.kBorderDecoration(hintText: "Enter name"),
                controller: nameController,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration:
                    AppBorder.kBorderDecoration(hintText: "Enter information"),
                controller: expressionController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: AppBorder.kButtonStyle,
                onPressed: () {
                  listData.toDoLists.add(
                    ListModel(
                      name: nameController.text,
                      expression: expressionController.text,
                    ),
                  );
                  nameController.clear();
                  expressionController.clear();
                  Navigator.pop(context);
                  setState(() {});
                },
                child: const Text("Add"),
              ),
            ],
          ),
        );
      },
    );
  }
}
