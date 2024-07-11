import 'package:clean_arc/cubit/Listuser/ListUser_cubit.dart';
import 'package:clean_arc/cubit/UserDetails/Userdetails_cubit.dart';
import 'package:clean_arc/data/repositories/ListUser_repository.dart';
import 'package:clean_arc/data/repositories/UserDetails_repository.dart';
import 'package:clean_arc/injection_container.dart';
import 'package:clean_arc/presentation/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    
      home: MultiBlocProvider(providers: [
        BlocProvider(create: (_) => UserDetailsCubit(getIt<UserDetailsRepository>())),
        BlocProvider(create: (_) => ListUserCubit(getIt<ListUserRepository>())),
      ], child: const HomePage()),
    );
  }
}
