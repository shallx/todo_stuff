import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_stuffasia/controllers/category_controller.dart';
import 'package:todo_stuffasia/controllers/todos_controller.dart';
import 'package:todo_stuffasia/models/todo.dart';
import 'package:todo_stuffasia/provider/todos.dart';
import 'package:todo_stuffasia/widget/todo_form_widget.dart';

class AddTodoDialogWidget extends StatefulWidget {
  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String category = '';

  @override
  void initState() {
    CategoryController catc = Get.find();
    category = catc.categories[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Todo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              TodoFormWidget(
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (description) =>
                    setState(() => this.description = description),
                onSavedTodo: addTodo,
                onCategorySelect: (cat) {
                  print('Category!!!!!!!!!!');
                  print(cat);
                  setState(() => this.category = cat);
                },
              ),
            ],
          ),
        ),
      );

  void addTodo() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        // createdTime: DateTime.now(),
        category: category,
      );

      final TodosController c = Get.find();
      // c.todos.add(todo);
      c.addTodo(todo);

      Navigator.of(context).pop();
    }
  }
}
