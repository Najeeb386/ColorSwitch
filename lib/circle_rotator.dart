import 'dart:async';
import 'dart:math' as math;

import 'package:colorswitch/Mygame.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class Circle_rotator extends PositionComponent with HasGameReference<MyGame>{
Circle_rotator({this.rotationSpeed = 2,required super.position, required super.size,  this.thickness = 8.0,}) 
  : assert(size.x == size.y),
super(
 
  anchor: Anchor.center,
);
final double rotationSpeed;
final double thickness;
@override
  FutureOr<void> onLoad() {
    for (int i = 0; i < game.GameColors.length; i++) {
      final startAngle = (i / game.GameColors.length) * 3.14 * 2;
      final sweepAngle = (1 / game.GameColors.length) * 3.14 * 2;
      add(CircleArc(
        color: game.GameColors[i],
        StartAngle: startAngle,
        sweepAngle: sweepAngle,
      ));
    }

    add(RotateEffect.to(math.pi * 2,
     EffectController(speed: rotationSpeed,
     infinite: true
     )));

    return super.onLoad();
  }
@override
void render(Canvas canvas) {
  // Colored arcs are drawn by CircleArc components
}
}
class CircleArc extends PositionComponent with ParentIsA<Circle_rotator>{
  final Color color;
  final double StartAngle;
  final double sweepAngle;
  CircleArc({
    required this.color,
    required this.StartAngle,
    required this.sweepAngle
    });
@override
void onMount()
{
  size= parent.size;
  position=parent.size / 2;
  _addHitbox();
  anchor = Anchor.center;
  super.onMount();
}


  void _addHitbox() {
    final center = size / 2;
    const precision = 8;
    final segment = sweepAngle / (precision-1);
    final radius = size.x / 2;
    List<Vector2> vertices = [];
    for (int i = 0; i < precision; i++) {
      final thisSegmentStart = StartAngle + segment *i;
      vertices.add(center + Vector2(math.cos(thisSegmentStart), math.sin(thisSegmentStart))*radius);
    }
    for (int i = precision-1; i >=0; i--) {
      final thisSegmentStart =StartAngle + segment *i;
      vertices.add(center + Vector2(math.cos(thisSegmentStart), math.sin(thisSegmentStart))*(radius - parent.thickness));
    }
  add(PolygonHitbox(
      vertices,
      collisionType: CollisionType.passive,
  )
  );
  }
@override
render(Canvas canvas) {
  canvas.drawArc(size.toRect().deflate(parent.thickness / 2), StartAngle, sweepAngle, false, Paint()..color = color..style=PaintingStyle.stroke..strokeWidth=parent.thickness);
}
}