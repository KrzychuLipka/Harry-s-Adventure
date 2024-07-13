import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:harrys_adventure/game_template.dart';
import 'package:harrys_adventure/model/vertical_direction.dart';
import 'package:harrys_adventure/sprites/mutant.dart';

class Harry extends SpriteComponent
    with HasGameRef<GameTemplate>, CollisionCallbacks {
  static const String _screamAudioFileName = 'scream.wav';
  static const _spriteVelocity = 700;
  final Sprite _spriteRight1;
  final Sprite _spriteRight2;
  final Sprite _spriteRight3;
  final Sprite _spriteLeft1;
  final Sprite _spriteLeft2;
  final Sprite _spriteLeft3;
  final Sprite _spriteDown1;
  final Sprite _spriteDown2;
  final Sprite _spriteDown3;
  final Sprite _spriteUp1;
  final Sprite _spriteUp2;
  final Sprite _spriteUp3;
  final Sprite _depthSprite;
  MovementDirection _activeDirection = MovementDirection.none;
  MovementDirection _prevDirection = MovementDirection.none;
  double _screenPosition = 0;
  double _timeSinceLastUpdate = 0;
  int _rightClickCounter = 0;
  int _leftClickCounter = 0;
  int _downClickCounter = 0;
  int _upClickCounter = 0;
  bool _isScreamPlaying = false;

  Harry({
    required Sprite spriteRight1,
    required Sprite spriteRight2,
    required Sprite spriteRight3,
    required Sprite spriteLeft1,
    required Sprite spriteLeft2,
    required Sprite spriteLeft3,
    required Sprite spriteDown1,
    required Sprite spriteDown2,
    required Sprite spriteDown3,
    required Sprite spriteUp1,
    required Sprite spriteUp2,
    required Sprite spriteUp3,
    required Sprite depthSprite,
  })  : _depthSprite = depthSprite,
        _spriteUp3 = spriteUp3,
        _spriteUp2 = spriteUp2,
        _spriteUp1 = spriteUp1,
        _spriteDown3 = spriteDown3,
        _spriteDown2 = spriteDown2,
        _spriteDown1 = spriteDown1,
        _spriteLeft3 = spriteLeft3,
        _spriteLeft2 = spriteLeft2,
        _spriteLeft1 = spriteLeft1,
        _spriteRight3 = spriteRight3,
        _spriteRight2 = spriteRight2,
        _spriteRight1 = spriteRight1 {
    sprite = _spriteRight2;
    size = Vector2(72, 142);
    anchor = Anchor.center;
    position = Vector2(300, 100);
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
  FutureOr<void> onLoad() async {
    super.onLoad();
    await FlameAudio.audioCache.load(_screamAudioFileName);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timeSinceLastUpdate += dt;
    if (_timeSinceLastUpdate < 0.15) return;
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
    _timeSinceLastUpdate = 0;
    _isScreamPlaying = false;
  }

  void _handleLeftClick(
    double dt,
  ) {
    _screenPosition = position.x - _spriteVelocity * dt;
    if (_screenPosition > 0) {
      position.x = _screenPosition;
      switch (++_leftClickCounter) {
        case 1:
          sprite = _spriteLeft1;
          break;
        case 2:
        case 4:
          sprite = _spriteLeft2;
          break;
        case 3:
          sprite = _spriteLeft3;
          break;
      }
      if (_leftClickCounter == 4) {
        _leftClickCounter = 0;
      }
    } else {
      position.x = gameRef.size.x;
    }
  }

  void _handleRightClick(
    double dt,
  ) {
    _screenPosition = position.x + _spriteVelocity * dt;
    if (_screenPosition < gameRef.size.x) {
      position.x = _screenPosition;
      switch (++_rightClickCounter) {
        case 1:
          sprite = _spriteRight1;
          break;
        case 2:
        case 4:
          sprite = _spriteRight2;
          break;
        case 3:
          sprite = _spriteRight3;
          break;
      }
      if (_rightClickCounter == 4) {
        _rightClickCounter = 0;
      }
    } else {
      position.x = 0;
    }
  }

  void _handleDownClick(
    double dt,
  ) {
    _screenPosition = position.y + _spriteVelocity * dt;
    if (_screenPosition < gameRef.size.y - 120) {
      position.y = _screenPosition;
      switch (++_downClickCounter) {
        case 1:
          sprite = _spriteDown1;
          break;
        case 2:
        case 4:
          sprite = _spriteDown2;
          break;
        case 3:
          sprite = _spriteDown3;
          break;
      }
      if (_downClickCounter == 4) {
        _downClickCounter = 0;
      }
    }
  }

  void _handleUpClick(
    double dt,
  ) {
    _screenPosition = position.y - _spriteVelocity * dt;
    if (_screenPosition > 50) {
      position.y = _screenPosition;
      switch (++_upClickCounter) {
        case 1:
          sprite = _spriteUp1;
          break;
        case 2:
        case 4:
          sprite = _spriteUp2;
          break;
        case 3:
          sprite = _spriteUp3;
          break;
      }
      if (_upClickCounter == 4) {
        _upClickCounter = 0;
      }
    }
  }

  void _resetSprite() {
    switch (_prevDirection) {
      case MovementDirection.right:
        sprite = _spriteRight2;
        break;
      case MovementDirection.left:
        sprite = _spriteLeft2;
        break;
      case MovementDirection.down:
        sprite = _spriteDown2;
        break;
      case MovementDirection.up:
        sprite = _spriteUp2;
        break;
      default:
        break;
    }
  }

  @override
  void onCollision(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollision(intersectionPoints, other);
    if (other is Mutant) {
      if (!_isScreamPlaying) {
        _isScreamPlaying = true;
        FlameAudio.play(_screamAudioFileName);
      }
      sprite = _depthSprite;
      position.x += 100;
    }
  }
}
