import 'package:flutter/material.dart';
import 'package:project_architecture/core/injection/injection.dart';
import 'package:project_architecture/features/app/data/data_source/remote_constants.dart';
import 'package:project_architecture/features/app/domain/entities/post.dart';
import 'package:project_architecture/features/app/domain/repositories/api_repo.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(getIt<ApiRepo>()),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage(this.apiRepo, {super.key});

  final ApiRepo apiRepo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () async {
            final response = await apiRepo.get(
                endpoint: postOneEndpoint, responseModal: const Post());
            if (response != null) {
              print(response.body);
            }
          },
          child: const Text("data"),
        ),
      ),
    );
  }
}
