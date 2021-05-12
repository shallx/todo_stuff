import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/category.dart';

class TodoFormWidget extends StatefulWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onCategorySelect;
  final VoidCallback onSavedTodo;

  const TodoFormWidget({
    Key key,
    this.title = '',
    this.description = '',
    @required this.onChangedTitle,
    @required this.onChangedDescription,
    @required this.onSavedTodo,
    this.onCategorySelect,
  }) : super(key: key);

  @override
  _TodoFormWidgetState createState() => _TodoFormWidgetState();
}

class _TodoFormWidgetState extends State<TodoFormWidget> {
  List list;
  String selectedCategory;

  @override
  void initState() {
    list = CategoryList().list();
    selectedCategory = list[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            SizedBox(height: 8),
            buildDescription(),
            SizedBox(height: 16),
            buildButton(),
            SizedBox(height: 8),
            buildCategory()
          ],
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: widget.title,
        onChanged: widget.onChangedTitle,
        validator: (title) {
          if (title.isEmpty) {
            return 'The title cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Title',
        ),
      );

  Widget buildDescription() => TextFormField(
        maxLines: 3,
        initialValue: widget.description,
        onChanged: widget.onChangedDescription,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Description',
        ),
      );

  Widget buildCategory() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Category"),
          DropdownButton(
            value: selectedCategory,
            onChanged: (value) {
              setState(() {
                selectedCategory = value;
              });
              widget.onCategorySelect(value);
            },
            items: list
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
          ),
        ],
      );

  Widget buildButton() => Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: widget.onSavedTodo,
              child: Text('Save'),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red[400],
              ),
              onPressed: () {
                print("What is wrong with you all!!!!!!!!!!!!!");
                Get.back();
              },
              child: Text('Cancel'),
            ),
          ),
        ],
      );
}
