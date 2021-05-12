import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_stuffasia/controllers/todos_controller.dart';
import 'package:todo_stuffasia/services/auth.dart';
import 'package:todo_stuffasia/widget/add_todo_dialog_widget.dart';
import 'package:todo_stuffasia/widget/completed_list_widget.dart';
import 'package:todo_stuffasia/widget/todo_list_widget.dart';

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

  final tabs = [
    TodoListWidget(),
    CompletedListWidget(),
  ];

  @override
  void initState() {
    dummyList = box.read('todos');
    print(dummyList);
    Get.put(TodosController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(Icons.person),
            label: Text("logout"),
          ),
          TextButton(
            child: Text("Show data"),
            onPressed: () {
              TodosController c = Get.find();
              c.printStorageData();
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 28),
            label: 'Completed',
          ),
        ],
      ),
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
      // body: TodoListWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Wow"),
            ElevatedButton(
              onPressed: () {
                dummyList = box.read('todos');
                var x = box.read('count') ?? 1;
                print(dummyList);
                print(x);
                box.write('count', x + 1);
              },
              child: Text("check"),
            ),
          ],
        ),
      ),
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
