import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qtec_task_app/ui/screen/product_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.deepOrange[400],
        primarySwatch: Colors.blue,
      ),
      home: ProductDetailsScreen(),
    );
  }
}
