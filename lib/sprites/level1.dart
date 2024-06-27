import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_game/game_template.dart';
import 'package:flutter_game/model/vertical_direction.dart';

class Level1 extends SpriteComponent
    with HasGameRef<GameTemplate>, CollisionCallbacks {
  final Sprite _sprite1;
  final Sprite _sprite2;
  final Sprite _sprite3;
  final Sprite _sprite4;

  Level1({
    required Sprite sprite1,
    required Sprite sprite2,
    required Sprite sprite3,
    required Sprite sprite4,
  })  : _sprite1 = sprite1,
        _sprite2 = sprite2,
        _sprite3 = sprite3,
        _sprite4 = sprite4 {
    sprite = _sprite1;
    size = Vector2(64, 137);
    position = Vector2(50, 100);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timeSinceLastUpdate += dt;
    if (_timeSinceLastUpdate < 0.2) return;
    if (_verticalDirection == MovementDirection.down) {
      _handleDownMove(dt);
    } else {
      _handleUpMove(dt);
    }
    _timeSinceLastUpdate = 0;
  }

  void _handleDownMove(
    double dt,
  ) {
    _screenPosition = position.y + _spriteVelocity * dt;
    if (_screenPosition < gameRef.size.y - height) {
      position.y = _screenPosition;
      switch (++_downClickCounter) {
        case 1:
          sprite = _sprite1;
          break;
        case 2:
          sprite = _sprite2;
          break;
        case 3:
          sprite = _sprite3;
          break;
      }
      if (_downClickCounter == 3) {
        _downClickCounter = 0;
      }
    } else {
      _verticalDirection = MovementDirection.up;
    }
  }

  void _handleUpMove(
    double dt,
  ) {
    _screenPosition = position.y - _spriteVelocity * dt;
    if (_screenPosition > 0) {
      position.y = _screenPosition;
      switch (++_upClickCounter) {
        case 1:
          sprite = _sprite4;
          break;
        case 2:
          sprite = _spriteUp2;
          break;
        case 3:
          sprite = _spriteUp3;
          break;
      }
      if (_upClickCounter == 3) {
        _upClickCounter = 0;
      }
    } else {
      _verticalDirection = MovementDirection.down;
    }
  }
}
