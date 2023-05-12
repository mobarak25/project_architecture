import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_architecture/core/injection/injection.dart';
import 'package:project_architecture/core/navigator/iflutter_navigator.dart';
import 'package:project_architecture/features/app/data/data_source/remote_constants.dart';
import 'package:project_architecture/features/app/domain/repositories/api_repo.dart';

Future<void> main() async {
  configureDependencies();
  await initGetStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: getIt<IFlutterNavigator>().navigatorKey,
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
            Future<T?> mepost<T, k>() async {
              dynamic data;

              return data;
            }

            Map<String, String> body = {
              'mobile': '01767513948',
              'password': '123456789',
              'device_name': 'IPhone',
            };
            final response = await apiRepo.get(
                endpoint: loginEndpoint, responseModal: const Login());
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

Future<void> initGetStorage() async {
  await GetStorage.init();
}

class Login {
  const Login({this.userId, this.id, this.title, this.body});

  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']);
  }
}
