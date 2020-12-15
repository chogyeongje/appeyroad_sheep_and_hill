import 'package:appeyroad_sheep_and_hill/hill.dart';
import 'package:appeyroad_sheep_and_hill/sheep_controller.dart';
import 'package:appeyroad_sheep_and_hill/utils.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var sheepController1 = SheepController('sheep.png', 600, Device.width,);
    var sheepController2 = SheepController('sheep.png', 500, Device.width);

    List<Hill> hills = [
      Hill(650, Device.width, Color(0xfffd6bea), 0.2, 12),
      Hill(600, Device.width, Color(0xffff59c2), 0.5, 8, sheepController: sheepController1,),
      Hill(500, Device.width, Color(0xffff4674), 1.4, 6, sheepController: sheepController2),
    ];

    return MaterialApp(
      title: 'Sheep and Hill',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SheepAndHill(hills: hills, sheepControllers: [null, sheepController1, sheepController2],),
    );
  }
}

class SheepAndHill extends StatelessWidget {

  final List<Hill> hills;
  final List<SheepController> sheepControllers;

  const SheepAndHill({Key key, this.hills, this.sheepControllers})
      : assert (hills.length == sheepControllers.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        background(),
        sun(),
        for(int i = 0; i < hills.length; i++) ...[
          onBottom(hills[i]),
          sheepControllers[i] == null ? Container() :
          LoopAnimation(builder:(context, child, value) => onBottom(Stack(children: [
            ...sheepControllers[i].getSheeps()
          ],)), tween: Tween()..begin = 0.0..end = 10,)
        ]]
    );
  }

  Widget onBottom(Widget child) => Positioned.fill(
    child: Align(
      alignment: Alignment.bottomCenter,
      child: child,
    ),
  );

  Widget background() => MirrorAnimation<Color>(
    duration: Duration(seconds: 10),
    tween: ColorTween()..begin = Colors.lightBlueAccent..end = Color(0xFFA4A4A4),
    builder: (context, child, value) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: value,
      );
    },
  );

  Widget sun() => Align(
    alignment: Alignment.topRight,
    child: MirrorAnimation<Color>(
      tween: ColorTween()..begin = Colors.yellow..end = Colors.white,
      builder: (context, child, value) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: value,
          ),
          height: 300,
          width: 300,
          margin: const EdgeInsets.all(100),
        );
      },
      duration: Duration(seconds: 10),
      curve: Curves.easeInOut,
    ),
  );
}
