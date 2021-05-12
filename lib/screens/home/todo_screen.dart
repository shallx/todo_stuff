import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_stuffasia/controllers/todos_controller.dart';
import 'package:todo_stuffasia/models/todo.dart';
import 'package:todo_stuffasia/services/auth.dart';
import 'package:todo_stuffasia/widget/add_todo_dialog_widget.dart';
import 'package:todo_stuffasia/widget/completed_list_widget.dart';
import 'package:todo_stuffasia/widget/todo_list_widget.dart';
import '../../widget/search_widget.dart';
import '../../widget/drawer.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen({Key key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  int selectedIndex = 0;
  AuthService _auth = AuthService();

  GetStorage box = GetStorage();
  List dummyList;
  int _count = 1;
  String query = '';
  TodosController c;
  List<Todo> todos;

  // final tabs = [
  //   TodoListWidget(),
  //   CompletedListWidget(),
  // ];

  @override
  void initState() {
    dummyList = box.read('todos');
    print(dummyList);
    if (box.read('count') != null) {
      _count = box.read('count');
    }

    c = Get.put(TodosController());
    todos = c.todos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildSearch(),
        leading: Align(
            alignment: Alignment(3, 0),
            child: Text(
              "Todo",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            )),
        actions: [
          MoreOptions(
            all: () {
              todos = c.todos;
              setState(() => todos = c.todos);
            },
            completed: () {
              todos = c.todos;
              setState(() =>
                  todos = todos.where((todo) => todo.isDone == true).toList());
            },
            remaining: () {
              todos = c.todos;
              setState(() =>
                  todos = todos.where((todo) => todo.isDone == false).toList());
            },
            logout: () {
              _auth.signOut();
            },
          )
        ],
      ),
      // drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddTodoDialogWidget(),
          barrierDismissible: false,
        ),
        child: Icon(Icons.add),
      ),
      body: TodoListWidget(localTodos: todos),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text("Wow"),
      //       ElevatedButton(
      //         onPressed: () {
      //           print(_count);
      //           _count++;
      //           box.write('count', _count);
      //         },
      //         child: Text("check"),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Task or Description',
        onChanged: searchBook,
      );

  void searchBook(String query) {
    todos = c.todos;

    final ts = todos.where((todo) {
      final title = todo.title.toLowerCase();
      final description = todo.description.toLowerCase();
      final queryLower = query.toLowerCase();
      return title.contains(queryLower) || description.contains(queryLower);
    }).toList();

    setState(() {
      this.query = query;
      this.todos = ts;
    });
  }
}

class MoreOptions extends StatelessWidget {
  final Function all;
  final Function logout;
  final Function remaining;
  final Function completed;
  const MoreOptions({
    Key key,
    this.all,
    this.logout,
    this.remaining,
    this.completed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      onSelected: (value) {
        switch (value) {
          case 'remaining':
            {
              remaining();
            }
            break;
          case 'completed':
            {
              completed();
            }
            break;
          case 'logout':
            {
              logout();
            }
            break;
          default:
            {
              all();
            }
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Text("List all"),
            value: "all",
          ),
          PopupMenuItem(
            child: Text("Filter by Remaining"),
            value: "remaining",
          ),
          PopupMenuItem(
            child: Text("Filter by Completed"),
            value: "completed",
          ),
          PopupMenuItem(
            child: Text("Logout"),
            value: "logout",
          ),
        ];
      },
    );
  }
}

Widget buildText(String text) {
  return Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 24, color: Colors.white),
    ),
  );
}
