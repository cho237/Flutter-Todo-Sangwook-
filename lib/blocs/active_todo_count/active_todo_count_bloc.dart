import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/blocs/todo_list/todo_list_bloc.dart';
import 'package:todo/models/todo_model.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

class ActiveTodoCountBloc
    extends Bloc<ActiveTodoCountEvent, ActiveTodoCountState> {
  final TodoListBloc todoListBloc;
  late final StreamSubscription _todoListSubscription;
  final int initialActiveTodoCount;

  ActiveTodoCountBloc(
      {required this.todoListBloc, required this.initialActiveTodoCount})
      : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {
    _todoListSubscription =
        todoListBloc.stream.listen((TodoListState todoListState) {
      print("TodoListState: $state");

      final int currentActiveCount = todoListState.todos
          .where((Todo todo) => !todo.completed)
          .toList()
          .length;
      add(CalculateActiveTodoCountEvent(activeTodoCount: currentActiveCount));
    });

    on<CalculateActiveTodoCountEvent>((event, emit) {
      emit(state.copyWith(activeTodoCount: event.activeTodoCount));
    });
  }

  @override
  Future<void> close() {
    _todoListSubscription.cancel();
    return super.close();
  }
}
