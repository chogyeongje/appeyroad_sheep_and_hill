import 'dart:ui' as ui;

import 'package:appeyroad_sheep_and_hill/utils.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class SheepController {
  final String imagePath;
  final num width;

  static final List<TripleOffset> dots = [];

  final totalFrame = 8;
  final curFrame = 0;

  final imgWidth = 360;
  final imgHeight = 300;

  final double sheepWidth = 180;
  final double sheepHeight = 150;

  var sheepWidthHalf;
  var x, y, speed;

  final List<Offset> point = [];

  final fps = 24;
  final fpsTime = 1000 / 24;

  ui.Image image;
  bool isImageloaded = false;
  final List<Sheep> items = [];
  int cur = 0;

  SheepController(this.imagePath, this.width) {
    init();
  }

  Future init() async {
    image = await Flame.images.load(imagePath);
    isImageloaded = true;
  }

  void addSheep() {
    items.add(Sheep(image, width));
  }

  addOffset(TripleOffset offset){
    dots.add(offset);
  }

  resetOffset() {
    dots.clear();
  }
}