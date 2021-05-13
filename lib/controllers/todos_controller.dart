import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_stuffasia/models/todo.dart';

class TodosController extends GetxController {
  // var todos = [].obs;
  RxList<Todo> todos = RxList<Todo>();
  Rx<String> selectedCategory = ''.obs;

  GetStorage box = GetStorage();
  List storedTodos;
  int i = 1;

  @override
  void onInit() {
    storedTodos = box.read('todos');

    if (storedTodos != null) {
      todos(storedTodos.map((e) => Todo.fromJson(e)).toList());
    }

    // ever(todos, (_) {
    //   try {
    //     GetStorage().write('todos', todos.toList());
    //   } catch (e) {
    //     print(e);
    //   }
    // });
    super.onInit();
  }

  void addTodo(Todo todo) {
    todos.add(todo);
    box.write('todos', todos);
  }

  void removeTodo(int index) {
    todos.removeAt(index);
    box.write('todos', todos);
  }

  bool markComplete(String id) {
    for (int i = 0; i < todos.length; i++) {
      if (todos[i].id == id) {
        bool isDone = todos[i].toggleIsDone();
        box.write('todos', todos);
        return isDone;
      }
    }
    return false;
  }

  void updateTodo(Todo todo) {
    for (int i = 0; i < todos.length; i++) {
      if (todos[i].id == todo.id) {
        todos[i] = todo;
      }
    }
    box.write('todos', todos);
  }
}
