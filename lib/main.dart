import 'package:flutter/material.dart';
import 'package:qtec_task_app/ui/screen/product_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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


