import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubits/cubits.dart';
import '../models/todo_model.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({super.key, required this.todo});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            bool _error = false;
            _textController.text = widget.todo.desc;

            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text('Edit Todo'),
                  content: TextField(
                    controller: _textController,
                    autofocus: true,
                    decoration: InputDecoration(
                      errorText: _error ? "Value cannot be empty" : null,
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text('CANCEL'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: const Text('EDIT'),
                      onPressed: () {
                        setState(() {
                          _error = _textController.text.isEmpty ? true : false;
                        });
                        if (!_error) {
                          context
                              .read<TodoListCubit>()
                              .editTodo(widget.todo.id, _textController.text);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
          context.read<TodoListCubit>().toggleTodo(widget.todo.id);
        },
      ),
      title: Text(widget.todo.desc),
    );
  }
}
