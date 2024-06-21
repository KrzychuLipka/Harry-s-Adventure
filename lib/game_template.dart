import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter_game/sprites/harry.dart';
import 'package:flutter_game/sprites/mutant.dart';

class GameTemplate extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  late Harry harry;
  late Mutant mutant;

  @override
  Color backgroundColor() => const Color(0xFFFFFFFF);

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    add(harry = Harry(
      spriteRight1: await loadSprite('hr1.png'),
      spriteRight2: await loadSprite('hr2.png'),
      spriteRight3: await loadSprite('hr3.png'),
      spriteLeft1: await loadSprite('hl1.png'),
      spriteLeft2: await loadSprite('hl2.png'),
      spriteLeft3: await loadSprite('hl3.png'),
      spriteDown1: await loadSprite('hd1.png'),
      spriteDown2: await loadSprite('hd2.png'),
      spriteDown3: await loadSprite('hd3.png'),
      spriteUp1: await loadSprite('hurry_up_1.png'),
      spriteUp2: await loadSprite('hurry_up_2.png'),
      spriteUp3: await loadSprite('hurry_up_3.png'),
    ));
    add(mutant = Mutant(
      spriteDown1: await loadSprite('md1.png'),
      spriteDown2: await loadSprite('md2.png'),
      spriteDown3: await loadSprite('md3.png'),
      spriteUp1: await loadSprite('mu1.png'),
      spriteUp2: await loadSprite('mu2.png'),
      spriteUp3: await loadSprite('mu3.png'),
    ));
  }
}
