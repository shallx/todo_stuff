import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_stuffasia/controllers/todos_controller.dart';
import 'package:todo_stuffasia/provider/todos.dart';
import 'package:todo_stuffasia/widget/todo_widget.dart';

class TodoListWidget extends StatefulWidget {
  @override
  _TodoListWidgetState createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<TodosProvider>(context);
    final TodosController c = Get.put(TodosController());
    final todos = c.todos;

    return Obx(
      () => todos.isEmpty
          ? Center(
              child: Text(
                'No todos.',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(16),
              separatorBuilder: (context, index) => Container(height: 8),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];

                return TodoWidget(todo: todo, index: index);
              },
            ),
    );
  }
}
