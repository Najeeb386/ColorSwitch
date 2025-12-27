import 'dart:math' as math;
import 'dart:ui';

import 'package:colorswitch/Mygame.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Colorswitcher extends PositionComponent with HasGameReference<MyGame>, CollisionCallbacks{
  Colorswitcher({
    this.radius = 10,
    required super.position,
    
  }):super(
    anchor: Anchor.center,
    size: Vector2.all(radius *2),
  );
  final double radius;
  @override
  void render(Canvas canvas) {
    for(int i=0;i<game.GameColors.length;i++)
    {
      final startAngle = (i / game.GameColors.length) * 3.14 * 2;
      final sweepAngle = (1 / game.GameColors.length) * 3.14 * 2;
      canvas.drawArc(
        size.toRect(),
        startAngle,
        sweepAngle,
        true,
        Paint()..color = game.GameColors[i],
      );
    }
  }

  @override
  void onLoad() {
    super.onLoad();
    add(CircleHitbox(
      position: size / 2,
      radius: radius,
      anchor: anchor,
      collisionType: CollisionType.passive
    ));
  }
}