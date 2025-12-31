import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class StarComponent extends PositionComponent{
  
 late Sprite _StarSprite;
 StarComponent({
    required super.position,
 }): super(
    size: Vector2(28,28),
    anchor: Anchor.center,
  );
 @override  
  FutureOr<void> onLoad() async {
    await super.onLoad();
    _StarSprite = await Sprite.load('star.png');
    add(CircleHitbox(radius: size.x / 2));
    // TODO: implement onLoad
     }
     @override
     render(Canvas canvas) {
      super.render(canvas);
      _StarSprite.render(canvas,position: size / 2,size: size,anchor: Anchor.center);
     }
}