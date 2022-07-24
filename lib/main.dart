import 'package:flutter/material.dart';
import 'package:ec_test/components/widgets/app_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'pages/my_home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        appBar: AppBarWidget(title: 'Test EC Site'),
        body: MyHomePage()
      )
    );
  }
}
