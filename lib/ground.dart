import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ground extends PositionComponent{
  static const String keyName = 'single_ground_key';
  Ground({required super.position}) 
  : super( size : Vector2(100 , 1),
   anchor: Anchor.center,
   key: ComponentKey.named(keyName)
   );
   late Sprite fingerSprite;
   @override
   Future<void>onLoad() async {
   await super.onLoad();
    fingerSprite = await Sprite.load('finger.png');
   }
   @override
  void render(Canvas canvas) {
    // Render ground
    fingerSprite.render(
      canvas,
      position: Vector2(21,0), // Positioning finger above ground
      size: Vector2(80, 80),
    );   
}

}
