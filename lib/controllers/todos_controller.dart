import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_stuffasia/models/todo.dart';

class TodosController extends GetxController {
  var todos = [].obs;
  GetStorage getStorage = GetStorage();
  List storedTodos;
  int i = 1;

  @override
  void onInit() {
    storedTodos = getStorage.read<List>('todos');

    if (storedTodos != null) {
      todos = storedTodos.map((e) => Todo.fromJson(e)).toList().obs;
    }
    ever(todos, (_) {
      GetStorage().write('todos', todos.toList());
    });
    getStorage.write('count', i);
    super.onInit();
  }

  void removeTodo(int index) {
    todos.removeAt(index);
  }

  bool markComplete(String id) {
    for (int i = 0; i < todos.length; i++) {
      if (todos[i].id == id) {
        return todos[i].toggleIsDone();
      }
    }
    return false;
  }

  void updateTodo(Todo todo) {
    for (int i = 0; i < todos.length; i++) {
      if (todos[i].id == todo.id) {
        print("Found which one to change-------");
        print(todo.description);
        todos[i] = todo;
      }
    }
  }

  void printStorageData() {
    List storedTodos = GetStorage().read<List>('todos');
    print("Stored Todos!!!!!!!!!!!!!!!!");
    var x = getStorage.read('count');
    print(x);
    getStorage.write('count', x + 1);
    print(storedTodos);
  }
}
