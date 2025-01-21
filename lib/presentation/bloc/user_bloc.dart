import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datingapp_restapi/data/models/user_model.dart';
import 'package:flutter_datingapp_restapi/data/repositories/user_repository.dart';

// Events
abstract class UserEvent {}

class FetchUsers extends UserEvent {}

class LoadMoreUsers extends UserEvent {}

class SearchUsers extends UserEvent {
  final String query;
  SearchUsers(this.query);
}

// States
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<Results> users;
  final bool hasReachedMax;

  UserLoaded(this.users, this.hasReachedMax);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;
  int currentPage = 1;
  bool isLoading = false;
  String currentQuery = '';
  List<Results> allUsers = [];

  UserBloc(this.repository) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<LoadMoreUsers>(_onLoadMoreUsers);
    on<SearchUsers>(_onSearchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final users = await repository.getUsers(1);
      allUsers = users.results ?? [];
      emit(UserLoaded(allUsers, false));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onLoadMoreUsers(LoadMoreUsers event,
      Emitter<UserState> emit) async {
    if (state is UserLoaded && !isLoading && currentQuery.isEmpty) {
      final currentState = state as UserLoaded;
      isLoading = true;
      try {
        currentPage++;
        final moreUsers = await repository.getUsers(currentPage);
        allUsers = [...currentState.users, ...moreUsers.results ?? []];
        emit(UserLoaded(
          allUsers,
          moreUsers.results?.isEmpty ?? true,
        ));
      } catch (e) {
        emit(UserError(e.toString()));
      } finally {
        isLoading = false;
      }
    }
  }

  Future<void> _onSearchUsers(SearchUsers event,
      Emitter<UserState> emit) async {
    currentQuery = event.query.toLowerCase();

    if (currentQuery.isEmpty) {
      emit(UserLoaded(allUsers, false));
      return;
    }

    final filteredUsers = allUsers.where((user) {
      final firstName = user.name?.first?.toLowerCase() ?? '';
      final lastName = user.name?.last?.toLowerCase() ?? '';
      final city = user.location?.city?.toLowerCase() ?? '';
      final country = user.location?.country?.toLowerCase() ?? '';

      return firstName.contains(currentQuery) ||
          lastName.contains(currentQuery) ||
          city.contains(currentQuery) ||
          country.contains(currentQuery);
    }).toList();

    emit(UserLoaded(filteredUsers, true));
  }
}