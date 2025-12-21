import 'package:colorswitch/Mygame.dart';
import 'package:colorswitch/ground.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent with HasGameReference<MyGame> {
  Player({
    required super.position,
    this.playerRadius = 10.0});
  final _velocity = Vector2.zero(); // pixels per second
  final _gravity = 980.0;
  final _jumpSpeed = 350.0;
  final double playerRadius;

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
        position = Vector2(0, groundComponent.position.y - height / 2 );
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle((size / 2).toOffset(), playerRadius,
        Paint()..color = Colors.yellow);
  }

  void jump() {
    _velocity.y = -_jumpSpeed;
  }
}