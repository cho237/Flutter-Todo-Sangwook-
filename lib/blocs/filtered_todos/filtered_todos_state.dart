part of 'filtered_todos_bloc.dart';

class FilterTodosState extends Equatable {
  final List<Todo> filteredTodos;

  FilterTodosState({
    required this.filteredTodos,
  });

  factory FilterTodosState.initial() {
    return FilterTodosState(filteredTodos: []);
  }

  @override
  List<Object> get props => [filteredTodos];

  @override
  bool get stringify => true;

  FilterTodosState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilterTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}