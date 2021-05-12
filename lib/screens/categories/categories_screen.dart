import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todo_stuffasia/controllers/category_controller.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // List categories;
  String category = "";
  CategoryController c;

  @override
  void initState() {
    // categories = CategoryList().list();
    c = Get.put(CategoryController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: Obx(
        () => Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(16),
              separatorBuilder: (context, index) => Container(height: 8),
              itemCount: c.categories.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    // setState(() {
                    //   CategoryList().removeAt(index);
                    //   categories = CategoryList().list();
                    // });
                    c.removeCatAt(index);
                  },
                  child: Material(
                    elevation: 2,
                    child: ListTile(
                      title: Text(c.categories[index]),
                      trailing: IconButton(
                        icon: Text(
                          "X",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          // setState(() {
                          //   CategoryList().removeAt(index);
                          //   categories = CategoryList().list();
                          // });
                          c.removeCatAt(index);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey[300],
                    blurRadius: 10,
                    spreadRadius: 3,
                    offset: Offset(5, 6)),
                BoxShadow(
                    color: Colors.grey[100],
                    blurRadius: 10,
                    spreadRadius: 3,
                    offset: Offset(-3, 3))
              ]),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        category = value;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(12.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.teal, width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      // CategoryList().add(category);
                      // setState(() {
                      //   category = "";
                      //   categories = CategoryList().list();
                      // });
                      c.addCat(category);
                    },
                    child: Text("Add"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
