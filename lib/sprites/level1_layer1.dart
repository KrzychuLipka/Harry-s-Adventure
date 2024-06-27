import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter_game/game_template.dart';

class Level1Layer1 extends SpriteComponent
    with HasGameRef<GameTemplate>, CollisionCallbacks {
  static const String _mainThemeAudioFileName = 'main_theme.wav';

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    await FlameAudio.audioCache.load(_mainThemeAudioFileName);
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play(_mainThemeAudioFileName);
  }

  Level1Layer1({
    required Sprite sprite,
  }) {
    this.sprite = sprite;
    position = Vector2(0, 0);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    size = Vector2(gameRef.size.x, gameRef.size.y);
  }
}
