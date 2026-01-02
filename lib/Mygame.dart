import 'dart:async';

import 'package:colorswitch/StarComponent.dart';
import 'package:colorswitch/circle_rotator.dart';
import 'package:colorswitch/circle_rotator_anticlockwise.dart';
import 'package:colorswitch/colorSwitcher.dart';
import 'package:colorswitch/ground.dart';
import 'package:colorswitch/player.dart';
import 'package:colorswitch/square_rotator.dart';
import 'package:colorswitch/triangle_rotator.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';

class MyGame extends FlameGame with TapCallbacks, HasCollisionDetection, HasDecorator, HasTimeScale{
  late Player Myplayer;
  final List<Color> GameColors;
  ValueNotifier<int> currentscore = ValueNotifier<int>(0);
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
  void onLoad() {
    // TODO: implement onLoad
    decorator = PaintDecorator.blur(0.0);
    super.onLoad();
  }
  @override
  Color backgroundColor() => const Color(0xFF222222);
@override
  void onMount() {
    _initializeGame();
    super.onMount();
  }
  @override
  void onTapDown(TapDownEvent event) {
    // TODO: implement onTapDown
    Myplayer.jump();
    super.onTapDown(event);
  }
  @override
  void update(double dt) {
    final cameraPositionY = camera.viewfinder.position.y;
    final playerY = Myplayer.position.y;
    if(playerY < cameraPositionY)
    {
      camera.viewfinder.position = Vector2(0, playerY);
    }
    super.update(dt);
  }
  void _initializeGame() {
    currentscore.value =0;
    // Initialize game components here
    add(Ground(position: Vector2(0, 400)));
   add(Myplayer=Player(position: Vector2(0, 250)));
   camera.moveTo(Vector2(0, 0));
  _generategamecomponents();
  }
  void _generategamecomponents() {
    add(Colorswitcher(
      position: Vector2(0, 200),
      radius: 15,
    ));
   
    // // previously: world.add(Circle_rotator(
    // //   position: Vector2(0, 0),
    // //   size: Vector2(150, 150),
    // // ));
    add(StarComponent(position: Vector2(0, 0)));
    
    add(Colorswitcher(
      position: Vector2(0, -180),
      radius: 15,
    ));
    
    // // previously: world.add(Circle_rotator(
    // //   position: Vector2(0, -350),
    // //   size: Vector2(150, 150),
    // // )); 
    add(StarComponent(position: Vector2(0, -350)));
    
    add(Colorswitcher(
      position: Vector2(0, -550),
      radius: 15,
    ));
    
    // Add new shapes
    // // previously: world.add(SquareRotator(
    // //   position: Vector2(0, -700),
    // //   size: Vector2(130, 130),
    // //   rotationSpeed: 1.5,
    // // ));
    add(StarComponent(position: Vector2(0, -700)));
    
    add(Colorswitcher(
      position: Vector2(0, -850),
      radius: 15,
    ));
    
    // // previously: world.add(TriangleRotator(
    // //   position: Vector2(0, -1150),
    // //   size: Vector2(400, 400),
    // //   rotationSpeed: 1.5,
    // // ));
    add(StarComponent(position: Vector2(0, -1150)));
     add(Circle_rotator(
      position: Vector2(0, -1700),
      size: Vector2(190, 190),
    ));
     add(Circle_rotator(
      position: Vector2(0, -1700),
      size: Vector2(170, 170),
    ));
    add(StarComponent(position: Vector2(0, -1700)));
    
    add(Colorswitcher(
      position: Vector2(0, -1500),
      radius: 15,
    ));
    // dual anti clock circle 
    add(Circle_rotator(
      position: Vector2(0, -2000),
      size: Vector2(170, 170),
    ));
    // add(Circle_rotator_anticlockwise(
    //   position: Vector2(0, -2000),
    //   size: Vector2(190, 190),
    // ));
  }

  void gameOver()
  {
    for (var element in children.toList()) {
      element.removeFromParent();
    }
    _initializeGame();
  }
  bool get isGamePaused=> timeScale == 0.0;
  bool get isGamePlaying=> !isGamePaused;
  void pauseGame()
  {
    decorator = PaintDecorator.blur(30);
    timeScale = 0.0;
    // pauseEngine();
  }
  void resumeGame()
  {
    decorator = PaintDecorator.blur(0);
    timeScale = 1.0;
    // resumeEngine();

  }
  void increaseScore()
  {
currentscore.value +=1;
  }
}
