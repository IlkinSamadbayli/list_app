import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../model/list_model.dart';
import '../provider/list_provider.dart';
import '../style/custom_color.dart';
import 'list_item.dart';

class TaskLists extends StatelessWidget {
  const TaskLists({super.key});

  @override
  Widget build(BuildContext context) {
    ListProvider appProvider = Provider.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
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
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:provider_test/presentation/home_screen.dart';
// import 'package:provider_test/provider/list_provider.dart';
// import 'package:provider_test/model/list_model.dart';
// import 'package:provider_test/style/custom_color.dart';
// import 'package:sizer/sizer.dart';

// import 'list_item.dart';

// class TaskLists extends StatelessWidget {
//   const TaskLists({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
    
//     return ListView.separated(
//       shrinkWrap: true,
//       separatorBuilder: (context, index) => const SizedBox(height: 12),
//       itemCount: appProvider.taskLists.length,
//       itemBuilder: (context, index) {
//         ListProvider listProvider = Provider.of(context);
//         ListModel item = listProvider.taskLists[index];
//         return Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(40),
//             color: CustomColor.primaryColor,
//           ),
//           width: 40,
//           height: 10.h,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(40),
//             child: Slidable(
//               startActionPane: ActionPane(
//                 motion: const ScrollMotion(),
//                 children: [
//                   SlidableAction(
//                     onPressed: (context) {
//                       listProvider.removeItem(item);
//                     },
//                     backgroundColor: CustomColor.errorColor,
//                     foregroundColor: CustomColor.versionColorWhite,
//                     icon: Icons.delete,
//                     label: 'Delete',
//                   ),
//                 ],
//               ),
//               endActionPane:
//                   ActionPane(motion: const ScrollMotion(), children: [
//                 SlidableAction(
//                   onPressed: (context) {},
//                   backgroundColor: CustomColor.mainColor,
//                   foregroundColor: CustomColor.versionColorWhite,
//                   icon: Icons.edit,
//                   label: 'Edit',
//                 ),
//               ]),
//               child: ListItem(
//                 item: item,
//                 index: index,
//                 listProvider: listProvider,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
