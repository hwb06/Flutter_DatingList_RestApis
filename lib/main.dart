import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datingapp_restapi/core/api/api_client.dart';
import 'package:flutter_datingapp_restapi/data/repositories/user_repository.dart';
import 'package:flutter_datingapp_restapi/presentation/bloc/user_bloc.dart';
import 'package:flutter_datingapp_restapi/presentation/screens/dating_splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiClient apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(UserRepository(apiClient)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dating List',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.grey[100],
        ),
        home: SplashScreen(),
      ),
    );
  }
}