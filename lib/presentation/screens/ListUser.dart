import 'dart:async';

import 'package:clean_arc/cubit/Listuser/ListUser_cubit.dart';
import 'package:clean_arc/cubit/UserDetails/Userdetails_cubit.dart';
import 'package:clean_arc/cubit/UserDetails/Userdetails_state.dart';
import 'package:clean_arc/data/models/ListUser_model.dart';
import 'package:clean_arc/presentation/screens/userdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListUser extends StatelessWidget {
  ListUser({super.key});

  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          final UserBloc = BlocProvider.of<ListUserCubit>(context);
          if (UserBloc.page <= UserBloc.lastPage) {
            UserBloc.loadUserList();
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<ListUserCubit>(context).loadUserList();

    return Scaffold(
      body: _UsersList(),
    );
  }

  Widget _UsersList() {
    return BlocListener<UserDetailsCubit, UserDetailsState>(
      listener: (context, state) async {
        if (state is UserDetailsLoaded) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => UserDetailScreen(user: state.users))));
        }
      },
      child: BlocBuilder<ListUserCubit, UserListState>(builder: (ctx, state) {
        if (state is UserListLoading && state.isFirstFetch) {
          return _loadingIndicator();
        }

        List<ListUserData> users = [];
        bool isLoading = false;

        if (state is UserListLoading) {
          users = state.oldUsers.data;
          isLoading = true;
        } else if (state is UserListLoaded) {
          users = state.users.data;
        }

        return ListView.builder(
            controller: scrollController,
            itemBuilder: (context, index) {
              if (index < users.length) {
                return _users(users[index], context);
              } else {
                Timer(const Duration(microseconds: 30), () {
                  scrollController
                      .jumpTo(scrollController.position.maxScrollExtent);
                });
                return _loadingIndicator();
              }
            },
            itemCount: users.length + (isLoading ? 1 : 0));
      }),
    );
  }

  Widget _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _users(ListUserData userlist, BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<UserDetailsCubit>(context)
            .userdetails(userlist.userID.toString());
      },
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: <Widget>[
              Hero(
                tag: userlist.avatar,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userlist.avatar),
                  radius: 40,
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${userlist.first_name} ${userlist.last_name}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SFPro-BB'),
                  ),
                  SizedBox(height: 5),
                  Text(
                    userlist.email,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontFamily: 'SFPro-BSemiBold'),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'User ID: ${userlist.userID}',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontFamily: 'SFPro-BSemiBold'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
