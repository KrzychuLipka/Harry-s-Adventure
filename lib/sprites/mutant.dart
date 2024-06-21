import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_game/game_template.dart';
import 'package:flutter_game/model/vertical_direction.dart';

class Mutant extends SpriteComponent
    with HasGameRef<GameTemplate>, CollisionCallbacks {
  final spriteVelocity = 500;
  double screenPosition = 0;
  double timeSinceLastUpdate = 0;
  int downClickCounter = 1;
  int upClickCounter = 1;
  bool downPressed = false;
  bool upPressed = false;
  Sprite spriteDown1;
  Sprite spriteDown2;
  Sprite spriteDown3;
  Sprite spriteUp1;
  Sprite spriteUp2;
  Sprite spriteUp3;
  MovementDirection verticalDirection = MovementDirection.down;

  Mutant({
    required this.spriteDown1,
    required this.spriteDown2,
    required this.spriteDown3,
    required this.spriteUp1,
    required this.spriteUp2,
    required this.spriteUp3,
  }) {
    sprite = spriteDown1;
    size = Vector2(64, 137);
    position = Vector2(50, 100);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    timeSinceLastUpdate += dt;
    if (timeSinceLastUpdate < 0.2) return;
    if (verticalDirection == MovementDirection.down) {
      _handleDownMove(dt);
    } else {
      _handleUpMove(dt);
    }
    timeSinceLastUpdate = 0;
  }

  void _handleDownMove(
    double dt,
  ) {
    screenPosition = position.y + spriteVelocity * dt;
    if (screenPosition < gameRef.size.y) {
      position.y = screenPosition;
      switch (++downClickCounter) {
        case 1:
          sprite = spriteDown1;
          break;
        case 2:
          sprite = spriteDown2;
          break;
        case 3:
          sprite = spriteDown3;
          break;
      }
      if (downClickCounter == 3) {
        downClickCounter = 0;
      }
    } else {
      verticalDirection = MovementDirection.up;
      position.x += 100;
    }
  }

  void _handleUpMove(
    double dt,
  ) {
    screenPosition = position.y - spriteVelocity * dt;
    if (screenPosition > 0) {
      position.y = screenPosition;
      switch (++upClickCounter) {
        case 1:
          sprite = spriteUp1;
          break;
        case 2:
          sprite = spriteUp2;
          break;
        case 3:
          sprite = spriteUp3;
          break;
      }
      if (upClickCounter == 3) {
        upClickCounter = 0;
      }
    } else {
      verticalDirection = MovementDirection.down;
      position.x -= 100;
    }
  }
}
