import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ground extends PositionComponent{
  static const String keyName = 'single_ground_key';
  Ground({required super.position}) 
  : super( size : Vector2(100 , 1),
   anchor: Anchor.center,
   key: ComponentKey.named(keyName)
   );
   late Sprite? fingerSprite;
   @override
   Future<void>onLoad() async {
   await super.onLoad();
    try {
      fingerSprite = await Sprite.load('finger.png');
    } catch (e) {
      fingerSprite = null;
    }
   }
   @override
  void render(Canvas canvas) {
    // Render ground
    if (fingerSprite != null) {
      fingerSprite!.render(
        canvas,
        position: Vector2(21,0),
        size: Vector2(80, 80),
      );
    } else {
      // Fallback: draw a simple rectangle
      canvas.drawRect(
        Rect.fromLTWH(-50, -5, 100, 10),
        Paint()..color = Colors.white,
      );
    }
}

}
