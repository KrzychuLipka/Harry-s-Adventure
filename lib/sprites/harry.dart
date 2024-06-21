import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game/game_template.dart';
import 'package:flutter_game/model/vertical_direction.dart';

class Harry extends SpriteComponent
    with HasGameRef<GameTemplate>, CollisionCallbacks {
  final spriteVelocity = 700;
  double screenPosition = 0;
  double timeSinceLastUpdate = 0;
  int rightClickCounter = 0;
  int leftClickCounter = 0;
  int downClickCounter = 0;
  int upClickCounter = 0;
  bool isCollision = false;
  Sprite spriteRight1;
  Sprite spriteRight2;
  Sprite spriteRight3;
  Sprite spriteLeft1;
  Sprite spriteLeft2;
  Sprite spriteLeft3;
  Sprite spriteDown1;
  Sprite spriteDown2;
  Sprite spriteDown3;
  Sprite spriteUp1;
  Sprite spriteUp2;
  Sprite spriteUp3;
  MovementDirection _activeDirection = MovementDirection.none;
  MovementDirection _prevDirection = MovementDirection.none;

  Harry({
    required this.spriteRight1,
    required this.spriteRight2,
    required this.spriteRight3,
    required this.spriteLeft1,
    required this.spriteLeft2,
    required this.spriteLeft3,
    required this.spriteDown1,
    required this.spriteDown2,
    required this.spriteDown3,
    required this.spriteUp1,
    required this.spriteUp2,
    required this.spriteUp3,
  }) {
    sprite = spriteRight2;
    size = Vector2(72, 142);
    anchor = Anchor.center;
    position = Vector2(100, 400);
    add(RectangleHitbox());
    add(KeyboardListenerComponent(keyDown: {
      LogicalKeyboardKey.arrowLeft: (kePressed) {
        _activeDirection = MovementDirection.left;
        return true;
      },
      LogicalKeyboardKey.arrowRight: (keyPressed) {
        _activeDirection = MovementDirection.right;
        return true;
      },
      LogicalKeyboardKey.arrowDown: (keyPressed) {
        _activeDirection = MovementDirection.down;
        return true;
      },
      LogicalKeyboardKey.arrowUp: (keyPressed) {
        _activeDirection = MovementDirection.up;
        return true;
      }
    }));
  }

  @override
  void update(double dt) {
    super.update(dt);
    timeSinceLastUpdate += dt;
    if (timeSinceLastUpdate < 0.15) return;
    switch (_activeDirection) {
      case MovementDirection.left:
        _handleLeftClick(dt);
        break;
      case MovementDirection.right:
        _handleRightClick(dt);
        break;
      case MovementDirection.down:
        _handleDownClick(dt);
        break;
      case MovementDirection.up:
        _handleUpClick(dt);
        break;
      default:
        _resetSprite();
        break;
    }
    _prevDirection = _activeDirection;
    _activeDirection = MovementDirection.none;
    timeSinceLastUpdate = 0;
  }

  void _handleLeftClick(
    double dt,
  ) {
    screenPosition = position.x - spriteVelocity * dt;
    if (screenPosition > 0) {
      position.x = screenPosition;
      switch (++leftClickCounter) {
        case 1:
          sprite = spriteLeft1;
          break;
        case 2:
        case 4:
          sprite = spriteLeft2;
          break;
        case 3:
          sprite = spriteLeft3;
          break;
      }
      if (leftClickCounter == 4) {
        leftClickCounter = 0;
      }
    } else {
      position.x = gameRef.size.x;
    }
  }

  void _handleRightClick(
    double dt,
  ) {
    screenPosition = position.x + spriteVelocity * dt;
    if (screenPosition < gameRef.size.x) {
      position.x = screenPosition;
      switch (++rightClickCounter) {
        case 1:
          sprite = spriteRight1;
          break;
        case 2:
        case 4:
          sprite = spriteRight2;
          break;
        case 3:
          sprite = spriteRight3;
          break;
      }
      if (rightClickCounter == 4) {
        rightClickCounter = 0;
      }
    } else {
      position.x = 0;
    }
  }

  void _handleDownClick(
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
        case 4:
          sprite = spriteDown2;
          break;
        case 3:
          sprite = spriteDown3;
          break;
      }
      if (downClickCounter == 4) {
        downClickCounter = 0;
      }
    } else {
      position.y = 0;
    }
  }

  void _handleUpClick(
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
        case 4:
          sprite = spriteUp2;
          break;
        case 3:
          sprite = spriteUp3;
          break;
      }
      if (upClickCounter == 4) {
        upClickCounter = 0;
      }
    } else {
      position.y = gameRef.size.y;
    }
  }

  void _resetSprite() {
    switch (_prevDirection) {
      case MovementDirection.right:
        sprite = spriteRight2;
        break;
      case MovementDirection.left:
        sprite = spriteLeft2;
        break;
      case MovementDirection.down:
        sprite = spriteDown2;
        break;
      case MovementDirection.up:
        sprite = spriteUp2;
        break;
      default:
        break;
    }
  }
}
