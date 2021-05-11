import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_stuffasia/controllers/todos_controller.dart';
import 'package:todo_stuffasia/models/todo.dart';
import 'package:todo_stuffasia/screens/home/edit_todo_page.dart';
import 'package:todo_stuffasia/provider/todos.dart';
import 'package:todo_stuffasia/utils.dart';

class TodoWidget extends StatefulWidget {
  final Todo todo;
  final int index;

  const TodoWidget({
    @required this.todo,
    @required this.index,
    Key key,
  }) : super(key: key);

  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  TodosController c = Get.find();
  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          key: Key(widget.todo.id),
          actions: [
            IconSlideAction(
              color: Colors.green,
              onTap: () => editTodo(context, widget.todo),
              caption: 'Edit',
              icon: Icons.edit,
            )
          ],
          secondaryActions: [
            IconSlideAction(
              color: Colors.red,
              caption: 'Delete',
              onTap: () => deleteTodo(context, widget.todo),
              icon: Icons.delete,
            )
          ],
          child: buildTodo(context),
        ),
      );

  Widget buildTodo(BuildContext context) => GestureDetector(
        onTap: () => editTodo(context, widget.todo),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                value: widget.todo.isDone,
                onChanged: (_) {
                  // final provider =
                  //     Provider.of<TodosProvider>(context, listen: false);
                  // final isDone = provider.toggleTodoStatus(todo);
                  final isDone = c.markComplete(widget.todo.id);
                  
                  setState(() {
                    widget.todo.isDone = isDone;
                  });
                  Utils.showSnackBar(
                    context, 'Task Updated!',
                    // isDone ? 'Task completed' : 'Task marked incomplete',
                  );
                },
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.todo.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    if (widget.todo.description.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          widget.todo.description,
                          style: TextStyle(fontSize: 20, height: 1.5),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void deleteTodo(BuildContext context, Todo todo) {
    TodosController c = Get.find();
    c.removeTodo(widget.index);
    Utils.showSnackBar(context, 'Deleted the task');
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoPage(todo: todo),
        ),
      );
}
