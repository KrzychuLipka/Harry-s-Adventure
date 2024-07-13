import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:harrys_adventure/game_template.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setLandscape();
  final gameTemplate = GameTemplate();
  runApp(GameWidget(game: gameTemplate));
}
