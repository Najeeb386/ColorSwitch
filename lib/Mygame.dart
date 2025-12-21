import 'package:colorswitch/circle_rotator.dart';
import 'package:colorswitch/ground.dart';
import 'package:colorswitch/player.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MyGame extends FlameGame with TapCallbacks{
  late Player Myplayer;
  final List<Color> GameColors;

  MyGame({this.GameColors = const[
    Colors.redAccent,
   
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.yellowAccent,
    // Colors.purpleAccent,


  ],
  }) : super(
    camera: CameraComponent.withFixedResolution(
      width: 600,
      height: 1000,
    )
  );
  @override
  Color backgroundColor() => const Color(0xFF222222);
@override
  void onMount() {
    world.add(Ground(position: Vector2(0, 400)));
   world.add(Myplayer=Player(position: Vector2(0, 250)));
 generategamecomponents();
    // debugMode = true;
    super.onMount();
    // Additional setup if needed
  }
  @override
  void onTapDown(TapDownEvent event) {
    // TODO: implement onTapDown
    Myplayer.jump();
    super.onTapDown(event);
  }
  update(double dt) {
    final cameraPositionY = camera.viewfinder.position.y;
    final playerY = Myplayer.position.y;
    if(playerY < cameraPositionY)
    {
camera.viewfinder.position = Vector2(0, playerY);
    }
    // camera.viewfinder.position = Myplayer.position;
    super.update(dt);
   
  }
  void generategamecomponents() {
    world.add(Circle_rotator(
      position: Vector2(0, 0),
      size: Vector2(150, 150),
    ));
  }
}
