import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubits/cubits.dart';
import 'package:todo/widgets/todo_item.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosCubit>().state.filteredTodos;

    return MultiBlocListener(
      listeners: [
        BlocListener<TodoListCubit, TodoListState>(
          listener: (context, state) {
            context.read<FilteredTodosCubit>().setFilteredTodos(
                  context.read<TodoFilterCubit>().state.filter,
                  state.todos,
                  context.read<TodoSearchCubit>().state.searchTerm,
                );
          },
        ),
        BlocListener<TodoFilterCubit, TodoFilterState>(
          listener: (context, state) {
            context.read<FilteredTodosCubit>().setFilteredTodos(
                  state.filter,
                  context.read<TodoListCubit>().state.todos,
                  context.read<TodoSearchCubit>().state.searchTerm,
                );
          },
        ),
        BlocListener<TodoSearchCubit, TodoSearchState>(
          listener: (context, state) {
            context.read<FilteredTodosCubit>().setFilteredTodos(
                  context.read<TodoFilterCubit>().state.filter,
                  context.read<TodoListCubit>().state.todos,
                  state.searchTerm,
                );
          },
        )
      ],
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: todos.length,
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.grey,
          );
        },
        itemBuilder: (context, index) {
          return Dismissible(
              onDismissed: (_) {
                context.read<TodoListCubit>().removeTodo(todos[index]);
              },
              confirmDismiss: (_) {
                return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Are you sure?"),
                      content:
                          const Text("You are about to delete a todo item?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Yes'),
                        )
                      ],
                    );
                  },
                );
              },
              background: showBackground(0),
              secondaryBackground: showBackground(1),
              key: ValueKey(todos[index].id),
              child: TodoItem(todo: todos[index]));
        },
      ),
    );
  }
}

Widget showBackground(int direction) {
  return Container(
    margin: const EdgeInsets.all(4.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    color: Colors.red,
    alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
    child: Icon(
      Icons.delete,
      size: 30.0,
      color: Colors.white,
    ),
  );
}
