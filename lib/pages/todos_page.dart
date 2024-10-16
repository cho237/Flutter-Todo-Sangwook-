import 'package:flutter/material.dart';
import 'package:todo/widgets/create_todo.dart';
import 'package:todo/widgets/search_and_filter_todos.dart';
import 'package:todo/widgets/show_todos.dart';
import 'package:todo/widgets/todo_header.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 40.0,
              ),
              child: Column(
                children: [
                  TodoHeader(),
                  CreateTodo(),
                  SizedBox(
                    height: 20.0,
                  ),
                  SearchAndFilterTodos(),
                  ShowTodos(),
                ],
              )),
        ),
      ),
    );
  }
}
