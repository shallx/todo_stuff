import 'package:get_storage/get_storage.dart';

class Category {
  String name;
  Category({this.name});
}

class CategoryList {
  GetStorage box;
  CategoryList() {
    box = GetStorage();
  }

  List list() {
    // final box = GetStorage();
    List categories = box.read<List>('categories');
    if (categories != null) {
      return categories;
    } else {
      categories.add("Important");
      return categories;
    }
  }

  add(String category) {
    // final box = GetStorage();
    List categories = box.read<List>('categories');
    if (categories == null) {
      categories = [];
    }
    categories.add(category);
    print(categories);
    box.write('categories', categories);
  }

  removeAt(int index) {
    List categories = box.read<List>('categories');
    categories.removeAt(index);
    box.write('categories', categories);
  }

  clearAll() {
    box.write('categories', []);
  }
}
