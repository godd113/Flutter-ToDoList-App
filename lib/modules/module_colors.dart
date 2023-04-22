import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo/models/modelIcon.dart';

class ModuleColors {
  static Color themeColor = const Color.fromRGBO(
    131,
    33,
    255,
    1.0,
  );
  static List<ModelIcon> listIcons = [
    ModelIcon(iconID: 1, icon: Icons.work),
    ModelIcon(iconID: 2, icon: Icons.cast_for_education),
    ModelIcon(iconID: 3, icon: Icons.umbrella_sharp),
    ModelIcon(iconID: 4, icon: Icons.favorite),
    ModelIcon(iconID: 5, icon: Icons.headphones),
    ModelIcon(iconID: 6, icon: Icons.home),
    ModelIcon(iconID: 7, icon: Icons.car_repair),
    ModelIcon(iconID: 8, icon: Icons.flight),
    ModelIcon(iconID: 9, icon: Icons.ac_unit),
    ModelIcon(iconID: 10, icon: Icons.run_circle),
    ModelIcon(iconID: 11, icon: Icons.book),
    ModelIcon(iconID: 12, icon: Icons.sports_rugby_rounded),
    ModelIcon(iconID: 13, icon: Icons.alarm),
    ModelIcon(iconID: 14, icon: Icons.call),
    ModelIcon(iconID: 15, icon: Icons.snowing),
    ModelIcon(iconID: 16, icon: Icons.music_note),
    ModelIcon(iconID: 17, icon: Icons.sunny),
    // add more icons here if you want
  ];
}
