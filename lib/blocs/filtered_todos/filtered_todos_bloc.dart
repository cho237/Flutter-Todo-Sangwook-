import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/blocs/blocs.dart';
import 'package:todo/models/todo_model.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilterTodosState> {
  final TodoFilterBloc todoFilterBloc;
  final TodoSearchBloc todoSearchBloc;
  final TodoListBloc todoListBloc;
  final List<Todo> initialTodos;

  late final StreamSubscription _todoSearchBlocSub;
  late final StreamSubscription _todoFilterBlocSub;
  late final StreamSubscription _todoListBlocSub;

  FilteredTodosBloc(
      {required this.todoFilterBloc,
      required this.todoSearchBloc,
      required this.todoListBloc,
      required this.initialTodos})
      : super(FilterTodosState(filteredTodos: initialTodos)) {
    _todoFilterBlocSub =
        todoFilterBloc.stream.listen((TodoFilterState todoFilterState) {
      setFilteredTodos();
    });

    _todoSearchBlocSub =
        todoSearchBloc.stream.listen((TodoSearchState todoSearchState) {
      setFilteredTodos();
    });

    _todoListBlocSub =
        todoListBloc.stream.listen((TodoListState todoListState) {
      setFilteredTodos();
    });

    on<CalculateFilteredTodosEvent>((event, emit) {
      emit(state.copyWith(filteredTodos: event.filteredTodos));
    });
  }

  void setFilteredTodos() {
    List<Todo> _filteredTodos;

    switch (todoFilterBloc.state.filter) {
      case Filter.active:
        _filteredTodos = todoListBloc.state.todos
            .where((Todo todo) => !todo.completed)
            .toList();
        break;
      case Filter.completed:
        _filteredTodos = todoListBloc.state.todos
            .where((Todo todo) => todo.completed)
            .toList();
      case Filter.all:
      default:
        _filteredTodos = todoListBloc.state.todos;
        break;
    }

    if (todoSearchBloc.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) =>
              todo.desc.toLowerCase().contains(todoSearchBloc.state.searchTerm))
          .toList();
    }

    add(CalculateFilteredTodosEvent(filteredTodos: _filteredTodos));
  }

  @override
  Future<void> close() {
    _todoListBlocSub.cancel();
    _todoSearchBlocSub.cancel();
    _todoFilterBlocSub.cancel();
    return super.close();
  }
}
