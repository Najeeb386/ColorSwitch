import 'dart:async';
import 'dart:math' as math;

import 'package:colorswitch/Mygame.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class TriangleRotator extends PositionComponent with HasGameReference<MyGame> {
  TriangleRotator({
    this.rotationSpeed = 2.5,
    required super.position,
    required super.size,
    this.thickness = 8.0,
  })  : assert(size!.x == size!.y),
        super(
          anchor: Anchor.center,
        );

  final double rotationSpeed;
  final double thickness;

  @override
  FutureOr<void> onLoad() {
    // Create 3 sides for triangle using GameColors
    for (int i = 0; i < 3; i++) {
      add(TriangleSide(
        color: game.GameColors[i % game.GameColors.length],
        sideIndex: i,
      ));
    }

    add(RotateEffect.to(
      math.pi * 2,
      EffectController(speed: rotationSpeed, infinite: true),
    ));

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    // Colored sides are drawn by TriangleSide components
  }
}

class TriangleSide extends PositionComponent with ParentIsA<TriangleRotator> {
  final Color color;
  final int sideIndex; // 0: top-right, 1: bottom-right, 2: left

  TriangleSide({
    required this.color,
    required this.sideIndex,
  });

  @override
  void onMount() {
    size = parent.size;
    position = parent.size / 2;
    _addHitbox();
    anchor = Anchor.center;
    super.onMount();
  }

  void _addHitbox() {
    final halfSize = size.x / 2;
    final thickness = parent.thickness;
    // Triangle vertices (equilateral)
    final top = Vector2(halfSize, halfSize - halfSize * 0.7);
    final bottomLeft = Vector2(halfSize - halfSize * 0.6, halfSize + halfSize * 0.4);
    final bottomRight = Vector2(halfSize + halfSize * 0.6, halfSize + halfSize * 0.4);

    // Center point for inward offsets
    final center = (top + bottomLeft + bottomRight) / 3;

    List<Vector2> vertices = [];

    // Create a narrow band along the middle portion of each edge to avoid large overlapping hitboxes.
    switch (sideIndex) {
      case 0: // Top-right edge (top -> bottomRight)
        {
          final a = top;
          final b = bottomRight;
          final outer1 = a + (b - a) * 0.1;
          final outer2 = a + (b - a) * 0.9;
          final inner1 = outer1 + (center - outer1) * 0.25;
          final inner2 = outer2 + (center - outer2) * 0.25;
          vertices = [outer1, outer2, inner2, inner1];
        }
        break;
      case 1: // Bottom edge (bottomRight -> bottomLeft)
        {
          final a = bottomRight;
          final b = bottomLeft;
          final outer1 = a + (b - a) * 0.1;
          final outer2 = a + (b - a) * 0.9;
          final inner1 = outer1 + (center - outer1) * 0.25;
          final inner2 = outer2 + (center - outer2) * 0.25;
          vertices = [outer1, outer2, inner2, inner1];
        }
        break;
      case 2: // Left edge (bottomLeft -> top)
        {
          final a = bottomLeft;
          final b = top;
          final outer1 = a + (b - a) * 0.1;
          final outer2 = a + (b - a) * 0.9;
          final inner1 = outer1 + (center - outer1) * 0.25;
          final inner2 = outer2 + (center - outer2) * 0.25;
          vertices = [outer1, outer2, inner2, inner1];
        }
        break;
    }

    add(PolygonHitbox(
      vertices,
      collisionType: CollisionType.passive,
    ));
  }

  @override
  void render(Canvas canvas) {
    final halfSize = size.x / 2;
    final paint = Paint()
      ..color = color
      ..strokeWidth = parent.thickness
      ..strokeCap = StrokeCap.round;

    // Triangle vertices (equilateral)
    final top = Offset(halfSize, halfSize - halfSize * 0.7);
    final bottomLeft = Offset(halfSize - halfSize * 0.6, halfSize + halfSize * 0.4);
    final bottomRight = Offset(halfSize + halfSize * 0.6, halfSize + halfSize * 0.4);

    switch (sideIndex) {
      case 0: // Top-right side
        canvas.drawLine(top, bottomRight, paint);
        break;
      case 1: // Bottom side
        canvas.drawLine(bottomRight, bottomLeft, paint);
        break;
      case 2: // Left side
        canvas.drawLine(bottomLeft, top, paint);
        break;
    }
  }
}
