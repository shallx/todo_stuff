import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_stuffasia/controllers/category_controller.dart';
import 'package:todo_stuffasia/controllers/todos_controller.dart';
import 'package:todo_stuffasia/models/category.dart';
import 'package:todo_stuffasia/models/todo.dart';
import 'package:todo_stuffasia/services/auth.dart';
import 'package:todo_stuffasia/widget/add_todo_dialog_widget.dart';
import 'package:todo_stuffasia/widget/completed_list_widget.dart';
import 'package:todo_stuffasia/widget/todo_list_widget.dart';
import '../../widget/search_widget.dart';
import '../../widget/drawer.dart';
import '../../widget/floating_bubble.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen({Key key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  AuthService _auth = AuthService();
  AnimationController _animationController;
  Animation<double> _animation;

  String query = '';
  TodosController c;
  CategoryController catc;
  List<Todo> todos;
  String selectedCategory;

  @override
  void initState() {
    c = Get.put(TodosController());
    catc = Get.put(CategoryController());
    selectedCategory = catc.categories[0];
    todos = c.todos;

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
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
      // floatingActionButton: FloatingActionButton(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      //   backgroundColor: Theme.of(context).primaryColor,
      // onPressed: () => showDialog(
      //   context: context,
      //   builder: (context) => AddTodoDialogWidget(),
      //   barrierDismissible: false,
      // ),
      //   child: Icon(Icons.add),
      // ),
      floatingActionButton: FloatBubble(
        animation: _animation,
        animationController: _animationController,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              children: [
                Pills(
                  onPressed: () {
                    todos = c.todos;
                    setState(() => todos = c.todos);
                  },
                  text: 'All',
                ),
                Pills(
                  onPressed: () {
                    todos = c.todos;
                    setState(() => todos =
                        todos.where((todo) => todo.isDone == false).toList());
                  },
                  text: 'Remaining',
                ),
                Pills(
                  onPressed: () {
                    todos = c.todos;
                    setState(() => todos =
                        todos.where((todo) => todo.isDone == true).toList());
                  },
                  text: 'Completed',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Select Category"),
                DropdownButton(
                  value: selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                      todos.where((todo) => todo.category == value).toList();
                    });
                  },
                  items: catc.categories
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                ),
              ],
            ),
            TodoListWidget(localTodos: todos),
          ],
        ),
      ),
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

class Pills extends StatelessWidget {
  final String text;
  final Function onPressed;
  const Pills({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style:
              TextStyle(color: Colors.teal[600], fontWeight: FontWeight.bold),
        ),
        style: OutlinedButton.styleFrom(
          shape: StadiumBorder(),
          backgroundColor: Colors.teal[50],
        ),
      ),
    );
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
