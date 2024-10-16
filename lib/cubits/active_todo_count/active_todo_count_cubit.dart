import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/cubits/todo_list/todo_list_cubit.dart';

import '../../models/todo_model.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  final TodoListCubit todoListCubit;
  late final StreamSubscription _todoListSubscription;
  final int initialActiveTodoCount;

  ActiveTodoCountCubit(
      {required this.initialActiveTodoCount, required this.todoListCubit})
      : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {
    _todoListSubscription =
        todoListCubit.stream.listen((TodoListState todoListState) {
      print("TodoListState: $state");

      final int currentActiveCount = todoListState.todos
          .where((Todo todo) => !todo.completed)
          .toList()
          .length;
      emit(state.copyWith(activeTodoCount: currentActiveCount));
    });
  }

  @override
  Future<void> close() {
    _todoListSubscription.cancel();
    return super.close();
  }
}
