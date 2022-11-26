import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../app_provider.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          SizedBox(height: 5.h),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemCount: 4,
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  width: 40,
                  height: 8.h,
                  child: ListTile(
                    leading: Text(
                      "${index + 1}",
                    ),
                    title: const Text("Name"),
                  ),
                ),
              ),
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
                  Text(
                    '${appProvider.counter}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                          onPressed: () => appProvider.decreacement,
                          tooltip: 'Decreament',
                          child: const Icon(Icons.remove),
                        ),
                        FloatingActionButton(
                          onPressed: () => appProvider.reset,
                          tooltip: 'Reset',
                          child: const Icon(Icons.restore_outlined),
                        ),
                        FloatingActionButton(
                          onPressed: () => appProvider.increment,
                          tooltip: 'Increment',
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
}
