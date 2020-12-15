import 'package:appeyroad_sheep_and_hill/hill.dart';
import 'package:appeyroad_sheep_and_hill/utils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  List<Hill> hills = [
    Hill(650, Device.width, Color(0xfffd6bea), 0.2, 12),
    Hill(600, Device.width, Color(0xffff59c2), 0.5, 8),
    Hill(500, Device.width, Color(0xffff4674), 1.4, 6,)
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sheep and Hill',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SheepAndHill(hills: hills,),
    );
  }
}

class SheepAndHill extends StatelessWidget {

  final List<Hill> hills;

  const SheepAndHill({Key key, this.hills}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for(Hill hill in hills) ...[onBottom(hill)]
      ],
    );
  }

  Widget onBottom(Widget child) => Positioned.fill(
    child: Align(
      alignment: Alignment.bottomCenter,
      child: child,
    ),
  );
}
