import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter_game/sprites/harry.dart';
import 'package:flutter_game/sprites/level1_layer1.dart';
import 'package:flutter_game/sprites/level1_layer2.dart';
import 'package:flutter_game/sprites/mutant.dart';

class GameTemplate extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  @override
  Color backgroundColor() => const Color(0xFFFFFFFF);

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    add(Level1Layer1(
      sprite: await loadSprite('l1.png'),
    ));
    add(Harry(
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
      depthSprite: await loadSprite('hdeath.png'),
    ));
    add(Mutant(
      spriteDown1: await loadSprite('md1.png'),
      spriteDown2: await loadSprite('md2.png'),
      spriteDown3: await loadSprite('md3.png'),
      spriteUp1: await loadSprite('mu1.png'),
      spriteUp2: await loadSprite('mu2.png'),
      spriteUp3: await loadSprite('mu3.png'),
    ));
    add(Level1Layer2(
      sprite1: await loadSprite('l1s1.png'),
      sprite2: await loadSprite('l1s2.png'),
      sprite3: await loadSprite('l1s3.png'),
      sprite4: await loadSprite('l1s4.png'),
    ));
  }
}
