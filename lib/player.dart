import 'package:colorswitch/Mygame.dart';
import 'package:colorswitch/StarComponent.dart';
import 'package:colorswitch/circle_rotator.dart';
import 'package:colorswitch/colorSwitcher.dart';
import 'package:colorswitch/ground.dart';
import 'package:colorswitch/square_rotator.dart';
import 'package:colorswitch/triangle_rotator.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent with HasGameReference<MyGame>, CollisionCallbacks {
  Player({
    required super.position,
    this.playerRadius = 12.0});
  final _velocity = Vector2.zero(); // pixels per second
  final _gravity = 980.0;
  final _jumpSpeed = 350.0;
  final double playerRadius;
  Color _color = Colors.white;
  @override
  void onMount() {
    size = Vector2.all(playerRadius * 2);
    anchor = Anchor.center;
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += _velocity * dt;
    _velocity.y += _gravity * dt;

    final groundKey = ComponentKey.named(Ground.keyName);
    final groundComponent = game.findByKey(groundKey) as Ground?;
    if (groundComponent != null) {
      if (positionOfAnchor(.bottomCenter).y > groundComponent.position.y) {
        _velocity.setValues(0, 0);
        position = Vector2(position.x, groundComponent.position.y - height / 2 );
      }
    }
  }
@override
void onLoad()  {
   super.onLoad();
  add(CircleHitbox(
    radius: playerRadius,
    anchor: anchor,
    collisionType: CollisionType.active,
  ));
}
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle((size / 2).toOffset(), playerRadius,
        Paint()..color =_color);
  }

  void jump() {
    _velocity.y = -_jumpSpeed;
  }
  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);
    if(other is Colorswitcher) {
      other.removeFromParent();
      _changeColorRandomly();
    }
    else if(other is CircleArc)
    {
  if(this._color != other.color)
  {
    game.gameOver();
  }
    }
    else if(other is SquareSide)
    {
      if(this._color != other.color)
      {
        game.gameOver();
      }
    }
    else if(other is TriangleSide)
    {
      if(this._color != other.color)
      {
        game.gameOver();
      }
    }
    else if(other is StarComponent)
    {
      other.removeFromParent();
      game.increaseScore();
    } 
  }
  
  void _changeColorRandomly() {
   _color =  game.GameColors.random();
  } 
  
  }
