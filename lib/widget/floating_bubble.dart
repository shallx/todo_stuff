import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_stuffasia/models/category.dart';
import '../screens/categories/categories_screen.dart';

import 'add_todo_dialog_widget.dart';

class FloatBubble extends StatelessWidget {
  final animationController;
  final animation;
  const FloatBubble({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionBubble(
      iconData: Icons.add,
      // Menu items
      items: <Bubble>[
        // Floating action menu item
        Bubble(
          title: "Categories",
          iconColor: Colors.white,
          bubbleColor: Theme.of(context).primaryColor,
          icon: Icons.category_outlined,
          titleStyle: TextStyle(fontSize: 16, color: Colors.white),
          onPress: () {
            Get.to(() => CategoriesScreen());
            animationController.reverse();
          },
        ),
        // Floating action menu item
        Bubble(
          title: "Add Todo",
          iconColor: Colors.white,
          bubbleColor: Theme.of(context).primaryColor,
          icon: Icons.notes_sharp,
          titleStyle: TextStyle(fontSize: 16, color: Colors.white),
          onPress: () {
            showDialog(
              context: context,
              builder: (context) => AddTodoDialogWidget(),
              barrierDismissible: false,
            );
            CategoryList().clearAll();
            animationController.reverse();
          },
        ),
      ],

      // animation controller
      animation: animation,

      onPress: () {
        animationController.isCompleted
            ? animationController.reverse()
            : animationController.forward();
      },

      // Floating Action button Icon color
      iconColor: Colors.white,

      // Flaoting Action button Icon
      backGroundColor: Theme.of(context).primaryColor,
    );
  }
}
