
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

enum Priority{
  high,
  medium,
  low
}

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category{
  work,
  food,
  leisure,
  travel
}

const categoryIcons = {
  Category.food : Icons.lunch_dining,
  Category.travel : Icons.flight_takeoff,
  Category.leisure : Icons.movie,
  Category.work : Icons.work
};


class Todo{
  late String id;
  late String title;
  late String description;
  //late DateTime date;
  late Priority taskPriority;
  late bool status;
  late Category category;

  Todo({
    required this.title,
    required this.description,
   // required this.date,
    required this.taskPriority,
    required this.category,
    required this.status,
    
  }) : id = uuid.v4();

  Map<String,dynamic> toMap(){
    // DateFormat format = DateFormat('yyyy-MM-dd');
    // String dateString = format.format(date);
    return {
      'id' : id,
      'title' : title,
      'description' : description,
      'priority' : taskPriority.toString().split('.').last,
      'category' : category.toString().split('.').last,
      // 'date' : dateString,
      'status' : status ? 1 : 0,
    };
  }

  Todo.fromMap(Map<String,dynamic> map){
    // String dateString = map['date'];
    // DateFormat format = DateFormat("yyyy-MM-dd");
    // DateTime dateTime = format.parse(dateString);
    id = map['id'];
    title = map['title'];
    description = map['description'];
    status = map['status'] == 1;
    taskPriority = Priority.values.firstWhere((element) => element.toString() == 'Priority.${map['priority']}');
    category = Category.values.firstWhere((element) => element.toString() == 'Category.${map['category']}');
    // date = dateTime;
  }
  
}