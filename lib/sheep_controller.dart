import 'dart:ui' as ui;

import 'package:appeyroad_sheep_and_hill/sheep.dart';
import 'package:appeyroad_sheep_and_hill/utils.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class SheepController {
  final String imagePath;
  final num height;
  final num width;

  final totalFrame = 8;
  final curFrame = 0;

  final imgWidth = 360;
  final imgHeight = 300;

  final double sheepWidth = 180;
  final double sheepHeight = 150;

  var sheepWidthHalf;
  var x, y, speed;

  final List<TripleOffset> _dots = [];

  final fps = 24;
  final fpsTime = 1000 / 24;

  ui.Image image;
  bool isImageloaded = false;
  final List<Sheep> items = [];
  int cur = 0;

  SheepController(this.imagePath, this.height, this.width){
    init();
  }

  List<Widget> getSheeps() {
    if (this.isImageloaded) {
      cur += 1;
      if (cur > 200) {
        cur = 0;
        this.addSheep();
      }

      var item;
      for (int i = items.length - 1; i >= 0; i--) {
        item = items[i];
        if (item.x < -item.width) {
          items.removeAt(i);
        }
      }
    }
    return items;
  }

  Future init() async {
    image = await Flame.images.load(imagePath);
    isImageloaded = true;
  }

  void addSheep() {
    items.add(Sheep(image, height, width, _dots));
  }

  addOffset(TripleOffset offset){
    _dots.add(offset);
  }

  resetOffset() {
    _dots.clear();
  }
}