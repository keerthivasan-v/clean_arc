part of 'ListUser_cubit.dart';

abstract class UserListState {}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {
  final ListUser oldUsers;

  final bool isFirstFetch;

  UserListLoading(this.oldUsers, {this.isFirstFetch = false});
}

class UserListLoaded extends UserListState {
  final ListUser users;

  UserListLoaded(this.users);
}
