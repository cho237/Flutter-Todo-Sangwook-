part of 'todo_list_bloc.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;

  TodoListState({required this.todos});

  factory TodoListState.initial() {
    return TodoListState(
      todos: [
        Todo(id: '1', desc: "clean the rom"),
        Todo(id: '2', desc: "wash dishes"),
        Todo(id: '3', desc: "Do Assignment"),
      ],
    );
  }

  @override
  List<Object> get props => [todos];

  @override
  bool get stringify => true;

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }
}
