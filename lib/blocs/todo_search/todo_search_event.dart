// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_search_bloc.dart';

class TodoSearchEvent extends Equatable {
  const TodoSearchEvent();

  @override
  List<Object> get props => [];
}

class SetSearchTerm extends TodoSearchEvent {
  final String newSearchTerm;

  SetSearchTerm({required this.newSearchTerm});

    @override
  List<Object> get props => [newSearchTerm];

  @override
  String toString() => 'SetSearchTerm(newSearchTerm: $newSearchTerm)';
}
