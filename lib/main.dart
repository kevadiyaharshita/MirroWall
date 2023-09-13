import 'package:flutter/material.dart';
import 'package:mirror_wall/controller/WebController.dart';
import 'package:mirror_wall/utils/MyRoutes.dart';
import 'package:mirror_wall/views/screens/HomePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => WebController()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoutes.home,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        MyRoutes.home: (context) => HomePage(),
      },
    );
  }
}
