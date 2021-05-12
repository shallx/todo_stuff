import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CategoryController extends GetxController {
  var categories = [].obs;

  GetStorage box = GetStorage();

  @override
  void onInit() {
    var cats = box.read('categories');
    if (cats.isEmpty || cats == null) {
      cats.add('Important');
    }
    categories(cats);
    // ever(categories, (_) => {box.write('categories', categories)});
    super.onInit();
  }

  void addCat(String category) {
    categories.add(category);
    box.write('categories', categories);
  }

  void removeCatAt(int index) {
    categories.removeAt(index);
    box.write('categories', categories);
  }

  void clearAllCats() {
    box.write('categories', []);
  }
}