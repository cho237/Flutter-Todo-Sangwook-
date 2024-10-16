// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_list_bloc.dart';

sealed class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object> get props => [];
}

class AddTodoEvent extends TodoListEvent {
  final String todoDesc;

  AddTodoEvent({required this.todoDesc});
  @override
  List<Object> get props => [todoDesc];

  @override
  String toString() => 'AddTodo(todoDesc: $todoDesc)';
}

class EditTodoEvent extends TodoListEvent {
  final String id;
  final String todoDesc;

  EditTodoEvent({required this.id, required this.todoDesc});

  @override
  List<Object> get props => [id, todoDesc];

  @override
  String toString() => 'EditTodo(id: $id, todoDesc: $todoDesc)';
}

class ToggleTodoEvent extends TodoListEvent {
  final String id;

  ToggleTodoEvent({required this.id});
  @override
  List<Object> get props => [id];

  @override
  String toString() => 'ToggleTodo(id: $id)';
}

class RemoveTodoEvent extends TodoListEvent {
  final Todo todo;

  RemoveTodoEvent({required this.todo});
  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'RemoveTodo(todo: $todo)';
}
