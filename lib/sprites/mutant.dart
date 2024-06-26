import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_game/game_template.dart';
import 'package:flutter_game/model/vertical_direction.dart';

class Mutant extends SpriteComponent
    with HasGameRef<GameTemplate>, CollisionCallbacks {
  static const _spriteVelocity = 500;
  final Sprite _spriteDown1;
  final Sprite _spriteDown2;
  final Sprite _spriteDown3;
  final Sprite _spriteUp1;
  final Sprite _spriteUp2;
  final Sprite _spriteUp3;
  double _screenPosition = 0;
  double _timeSinceLastUpdate = 0;
  int _downClickCounter = 1;
  int _upClickCounter = 1;
  MovementDirection _verticalDirection = MovementDirection.down;

  Mutant({
    required Sprite spriteDown1,
    required Sprite spriteDown2,
    required Sprite spriteDown3,
    required Sprite spriteUp1,
    required Sprite spriteUp2,
    required Sprite spriteUp3,
  })  : _spriteUp3 = spriteUp3,
        _spriteUp2 = spriteUp2,
        _spriteUp1 = spriteUp1,
        _spriteDown3 = spriteDown3,
        _spriteDown2 = spriteDown2,
        _spriteDown1 = spriteDown1 {
    sprite = _spriteDown1;
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
          sprite = _spriteDown1;
          break;
        case 2:
          sprite = _spriteDown2;
          break;
        case 3:
          sprite = _spriteDown3;
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
          sprite = _spriteUp1;
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
