import 'package:colorswitch/circle_rotator.dart';
import 'package:colorswitch/colorSwitcher.dart';
import 'package:colorswitch/ground.dart';
import 'package:colorswitch/player.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MyGame extends FlameGame with TapCallbacks, HasCollisionDetection{
  late Player Myplayer;
  final List<Color> GameColors;

  MyGame({this.GameColors = const[
    Colors.redAccent,
   
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.yellowAccent,


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
    _initializeGame();
    Myplayer = Player(
      position: Vector2(0, 400),
    );
    world.add(Myplayer);
 
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
  void _initializeGame() {
    // Initialize game components here
    world.add(Ground(position: Vector2(0, 400)));
   world.add(Myplayer=Player(position: Vector2(0, 250)));
   camera.moveTo(Vector2(0, 0));
  _generategamecomponents();
  }
  void _generategamecomponents() {
    world.add(Colorswitcher(
      position: Vector2(0, 200),
      radius: 15,
    ));
   
    world.add(Circle_rotator(
      position: Vector2(0, 0),
      size: Vector2(150, 150),
    ));
     world.add(Colorswitcher(
      position: Vector2(0, -120),
      radius: 15,
    ));
    world.add(Circle_rotator(
      position: Vector2(0, -250),
      size: Vector2(120, 120),
    )); 
  }

  void gameOver()
  {
    for(var element in world.children)
    {
      element.removeFromParent();
     
    }
     _initializeGame();
  }
}
