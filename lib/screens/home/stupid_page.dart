import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_stuffasia/shared/constant.dart';
import '../../models/category.dart';

class StupidPage extends StatefulWidget {
  StupidPage({Key key}) : super(key: key);

  @override
  _StupidPageState createState() => _StupidPageState();
}

class _StupidPageState extends State<StupidPage> {
  int _count = 1;
  GetStorage box = GetStorage();
  String category;
  String initvalue = 'One';

  @override
  void initState() {
    if (box.read('count') != null) {
      _count = box.read('count');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  print(CategoryList().list());
                },
                child: Text("Get List"),
              ),
              TextField(
                onChanged: (value) {
                  category = value;
                },
                decoration: textInputDecoration,
              ),
              ElevatedButton(
                onPressed: () {
                  CategoryList().add(category);
                  setState(() {
                    category = "";
                  });
                },
                child: Text("Add new"),
              ),
              ElevatedButton(
                onPressed: () {
                  CategoryList().clearAll();
                },
                child: Text("Clear list"),
              ),
              ElevatedButton(
                onPressed: () {
                  CategoryList().removeAt(int.parse(category));
                },
                child: Text("Remove At"),
              ),
              DropdownButton<String>(
                value: initvalue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    initvalue = newValue;
                  });
                },
                items: <String>['One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
