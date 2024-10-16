import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo/models/todo_model.dart';

part 'filter_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilterTodosState> {
  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;
  final TodoListCubit todoListCubit;

  late final StreamSubscription _todoSearchCubitSub;
  late final StreamSubscription _todoFilterCubitSub;
  late final StreamSubscription _todoListCubitSub;

  FilteredTodosCubit({
    required this.todoFilterCubit,
    required this.todoSearchCubit,
    required this.todoListCubit,
  }) : super(FilterTodosState.initial()) {
    _todoFilterCubitSub =
        todoFilterCubit.stream.listen((TodoFilterState todoFilterState) {
      setFilteredTodos();
    });

    todoSearchCubit.stream.listen((TodoSearchState todoSearchState) {
      setFilteredTodos();
    });

    todoListCubit.stream.listen((TodoListState todoListState) {
      setFilteredTodos();
    });
  }

  void setFilteredTodos() {
    List<Todo> _filteredTodos;

    switch (todoFilterCubit.state.filter) {
      case Filter.active:
        _filteredTodos = todoListCubit.state.todos
            .where((Todo todo) => !todo.completed)
            .toList();
        break;
      case Filter.completed:
        _filteredTodos = todoListCubit.state.todos
            .where((Todo todo) => todo.completed)
            .toList();
      case Filter.all:
      default:
        _filteredTodos = todoListCubit.state.todos;
        break;
    }

    if (todoSearchCubit.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) => todo.desc
              .toLowerCase()
              .contains(todoSearchCubit.state.searchTerm))
          .toList();
    }

    emit(state.copyWith(filteredTodos: _filteredTodos));
  }

  @override
  Future<void> close() {
    _todoFilterCubitSub.cancel();
    _todoSearchCubitSub.cancel();
    _todoListCubitSub.cancel();
    return super.close();
  }
}
