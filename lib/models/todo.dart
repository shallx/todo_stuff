import 'package:flutter/cupertino.dart';
import 'package:todo_stuffasia/utils.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  DateTime createdTime;
  String title;
  String id;
  String description;
  String category;
  bool isDone;

  Todo(
      {@required this.createdTime,
      @required this.title,
      this.description = '',
      this.id,
      this.isDone = false,
      @required this.category});

  static Todo fromJson(Map<String, dynamic> json) => Todo(
        createdTime: Utils.toDateTime(json['createdTime']),
        title: json['title'],
        description: json['description'],
        id: json['id'],
        isDone: json['isDone'],
        category: json['category'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'title': title,
        'description': description,
        'id': id,
        'isDone': isDone,
        'category' : category
      };

  bool toggleIsDone() {
    return isDone = !isDone;
  }
}
