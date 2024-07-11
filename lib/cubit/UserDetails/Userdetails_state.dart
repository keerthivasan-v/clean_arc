import 'package:clean_arc/data/models/ListUser_model.dart';

abstract class UserDetailsState {}

class UserDetailsInitial extends UserDetailsState {}

class UserDetailsLoaded extends UserDetailsState {
  final ListUserData users;
  UserDetailsLoaded(this.users);
}

class UserDetailsLoading extends UserDetailsState {
  UserDetailsLoading();
}

class UserDetailsFailure extends UserDetailsState {
  final String message;

  UserDetailsFailure(this.message);
}
