import 'dart:async';

import 'package:colorswitch/StarComponent.dart';
import 'package:colorswitch/circle_rotator.dart';
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
    currentscore.value =0;
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
    world.add(StarComponent(position: Vector2(0, 0)));
    
    world.add(Colorswitcher(
      position: Vector2(0, -180),
      radius: 15,
    ));
    
    world.add(Circle_rotator(
      position: Vector2(0, -350),
      size: Vector2(150, 150),
    )); 
    world.add(StarComponent(position: Vector2(0, -350)));
    
    world.add(Colorswitcher(
      position: Vector2(0, -550),
      radius: 15,
    ));
    
    // Add new shapes
    world.add(SquareRotator(
      position: Vector2(0, -700),
      size: Vector2(130, 130),
      rotationSpeed: 1.5,
    ));
    world.add(StarComponent(position: Vector2(0, -700)));
    
    world.add(Colorswitcher(
      position: Vector2(0, -850),
      radius: 15,
    ));
    
    world.add(TriangleRotator(
      position: Vector2(0, -1150),
      size: Vector2(400, 400),
      rotationSpeed: 1.5,
    ));
    world.add(StarComponent(position: Vector2(0, -1150)));
     world.add(Circle_rotator(
      position: Vector2(0, -1500),
      size: Vector2(150, 150),
    ));
     world.add(Circle_rotator(
      position: Vector2(0, -1500),
      size: Vector2(100, 100),
    ));
    world.add(StarComponent(position: Vector2(0, 0)));
    
    world.add(Colorswitcher(
      position: Vector2(0, -180),
      radius: 15,
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
