import 'package:flutter/material.dart';
import 'package:meticulo/page/search.dart';
import 'package:meticulo/provider/imdb_provider.dart';
import 'package:meticulo/provider/result_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider<ResultProvider>(
          create: (_) => ImdbProvider(),
          builder: (context, _) {
            return const SearchPage();
          }),
    );
  }
}
