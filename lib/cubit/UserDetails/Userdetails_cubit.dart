import 'package:clean_arc/cubit/UserDetails/Userdetails_state.dart';
import 'package:clean_arc/data/repositories/UserDetails_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  final UserDetailsRepository repository;
  UserDetailsCubit(this.repository) : super(UserDetailsInitial());

  void userdetails(String userID) async {
    emit(UserDetailsLoading());
    await repository.fetchUserDetails(userID).then((value) {
      emit(UserDetailsLoaded(value));
    }).catchError((onError) {
      emit(UserDetailsFailure("Data not found"));
    });
  }
}
