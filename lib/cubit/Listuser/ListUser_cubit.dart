import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_arc/data/models/ListUser_model.dart';
import 'package:clean_arc/data/repositories/ListUser_repository.dart';

part 'ListUser_state.dart';

class ListUserCubit extends Cubit<UserListState> {
  final ListUserRepository repository;

  ListUserCubit(this.repository) : super(UserListInitial());

  int page = 1;
  int lastPage = 1;

  void loadUserList() {
    if (state is UserListLoading) return;

    final currentState = state;

    var olduser = ListUser(currentPage: 1, data: [], lastPage: 1);

    if (currentState is UserListLoaded) {
      olduser = currentState.users;
    }

    emit(UserListLoading(olduser, isFirstFetch: page == 1));

    repository.fetchUser(page).then((value) {
      page += 1;
      lastPage = value.lastPage;

      final users = (state as UserListLoading).oldUsers;
      users.data.addAll(value.data);
      emit(UserListLoaded(users));
    });
  }
}
