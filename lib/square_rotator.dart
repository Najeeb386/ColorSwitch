import 'dart:async';
import 'dart:math' as math;

import 'package:colorswitch/Mygame.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class SquareRotator extends PositionComponent with HasGameReference<MyGame> {
  SquareRotator({
    this.rotationSpeed = 3,
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
    // Divide square into 4 colored sides
    for (int i = 0; i < game.GameColors.length; i++) {
      final sideIndex = i % 4;
      add(SquareSide(
        color: game.GameColors[i],
        sideIndex: sideIndex,
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
    // Colored sides are drawn by SquareSide components
  }
}

class SquareSide extends PositionComponent with ParentIsA<SquareRotator> {
  final Color color;
  final int sideIndex; // 0: top, 1: right, 2: bottom, 3: left

  SquareSide({
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

    List<Vector2> vertices = [];

    // Create a square outline with thickness
    final outerRect = Rect.fromCenter(
      center: Offset(halfSize, halfSize),
      width: size.x,
      height: size.x,
    );

    final innerRect = Rect.fromCenter(
      center: Offset(halfSize, halfSize),
      width: size.x - thickness * 2,
      height: size.x - thickness * 2,
    );

    // Create polygon vertices for the side
    switch (sideIndex) {
      case 0: // Top
        vertices = [
          Vector2(outerRect.left, outerRect.top),
          Vector2(outerRect.right, outerRect.top),
          Vector2(innerRect.right, innerRect.top),
          Vector2(innerRect.left, innerRect.top),
        ];
        break;
      case 1: // Right
        vertices = [
          Vector2(outerRect.right, outerRect.top),
          Vector2(outerRect.right, outerRect.bottom),
          Vector2(innerRect.right, innerRect.bottom),
          Vector2(innerRect.right, innerRect.top),
        ];
        break;
      case 2: // Bottom
        vertices = [
          Vector2(outerRect.left, outerRect.bottom),
          Vector2(outerRect.right, outerRect.bottom),
          Vector2(innerRect.right, innerRect.bottom),
          Vector2(innerRect.left, innerRect.bottom),
        ];
        break;
      case 3: // Left
        vertices = [
          Vector2(outerRect.left, outerRect.top),
          Vector2(outerRect.left, outerRect.bottom),
          Vector2(innerRect.left, innerRect.bottom),
          Vector2(innerRect.left, innerRect.top),
        ];
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
    final thickness = parent.thickness;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    final outerRect = Rect.fromCenter(
      center: Offset(halfSize, halfSize),
      width: size.x,
      height: size.x,
    );

    // Draw only the specific side
    switch (sideIndex) {
      case 0: // Top
        canvas.drawLine(
          Offset(outerRect.left, outerRect.top),
          Offset(outerRect.right, outerRect.top),
          paint,
        );
        break;
      case 1: // Right
        canvas.drawLine(
          Offset(outerRect.right, outerRect.top),
          Offset(outerRect.right, outerRect.bottom),
          paint,
        );
        break;
      case 2: // Bottom
        canvas.drawLine(
          Offset(outerRect.left, outerRect.bottom),
          Offset(outerRect.right, outerRect.bottom),
          paint,
        );
        break;
      case 3: // Left
        canvas.drawLine(
          Offset(outerRect.left, outerRect.top),
          Offset(outerRect.left, outerRect.bottom),
          paint,
        );
        break;
    }
  }
}
