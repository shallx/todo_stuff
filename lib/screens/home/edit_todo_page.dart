import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_stuffasia/controllers/todos_controller.dart';
import 'package:todo_stuffasia/models/todo.dart';
import 'package:todo_stuffasia/provider/todos.dart';
import 'package:todo_stuffasia/widget/todo_form_widget.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage({Key key, @required this.todo}) : super(key: key);

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();

  String title;
  String description;

  @override
  void initState() {
    super.initState();

    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              final provider =
                  Provider.of<TodosProvider>(context, listen: false);
              provider.removeTodo(widget.todo);

              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: TodoFormWidget(
            title: title,
            description: description,
            onChangedTitle: (title) => setState(() {
              //TODO : Try to find how to omit setState
              widget.todo.title = title;
              return this.title = title;
            }),
            onChangedDescription: (description) => setState(() {
              widget.todo.description = description;
              return this.description = description;
            }),
            onSavedTodo: saveTodo,
            onCategorySelect: (category) => setState(() => {
              widget.todo.category = category
            }),
          ),
        ),
      ),
    );
  }

  void saveTodo() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      // provider.updateTodo(widget.todo, title, description);

      //TODO : Implement Edit Controller
      final TodosController c = Get.find();
      c.updateTodo(widget.todo);
      Navigator.of(context).pop();
    }
  }
}
