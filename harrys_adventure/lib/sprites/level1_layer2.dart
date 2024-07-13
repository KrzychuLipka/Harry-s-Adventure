import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:harrys_adventure/game_template.dart';

class Level1Layer2 extends SpriteComponent
    with HasGameRef<GameTemplate>, CollisionCallbacks {
  final Sprite _sprite1;
  final Sprite _sprite2;
  final Sprite _sprite3;
  final Sprite _sprite4;
  double _timeSinceLastUpdate = 0;

  Level1Layer2({
    required Sprite sprite1,
    required Sprite sprite2,
    required Sprite sprite3,
    required Sprite sprite4,
  })  : _sprite1 = sprite1,
        _sprite2 = sprite2,
        _sprite3 = sprite3,
        _sprite4 = sprite4 {
    sprite = _sprite1;
    position = Vector2(0, 0);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    size = Vector2(gameRef.size.x, gameRef.size.y);
    _timeSinceLastUpdate += dt;
    if (_timeSinceLastUpdate < 1) return;
    if (sprite == _sprite1) {
      sprite = _sprite2;
    } else if (sprite == _sprite2) {
      sprite = _sprite3;
    } else if (sprite == _sprite3) {
      sprite = _sprite4;
    } else if (sprite == _sprite4) {
      sprite = _sprite1;
    }
    _timeSinceLastUpdate = 0;
  }
}
