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
  final double _centerX = 600 / 2;
    final double _screenHeight = 1000;
    final double _fingerHeight = 80;
    final double _playerRadius = 12;
  
  @override
  void onLoad() {
    decorator = PaintDecorator.blur(0.0);
    // Place finger icon at bottom center (not as ground)
    add(FingerIcon(position: Vector2(_centerX, _screenHeight - _fingerHeight / 2)));
    // Place player just above finger icon
    final double playerStartY = _screenHeight - _fingerHeight - _playerRadius * 2;
    add(Myplayer = Player(position: Vector2(_centerX, playerStartY)));
    // Start camera so player is vertically centered
    camera.moveTo(Vector2(_centerX, playerStartY));
    _generategamecomponents();
    super.onLoad();
  }
  @override
  void onTapDown(TapDownEvent event) {
    Myplayer.jump();
    super.onTapDown(event);
  }

// Finger icon as a separate component (top-level)


class FingerIcon extends SpriteComponent {
  FingerIcon({required Vector2 position}) : super(
    position: position,
    size: Vector2(80, 80),
    anchor: Anchor.center,
  );
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('finger.png');
    await super.onLoad();
  }
    {
      camera.viewfinder.position = Vector2(_centerX, playerY);
    }
    super.update(dt);
  }
  void _initializeGame() {
    currentscore.value =0;
    // Initialize game components here
    // Place ground at bottom of screen (y = 1000 - 40 for finger sprite height)
    final double groundY = 960; // 1000 - 40
    add(Ground(position: Vector2(_centerX, groundY)));
    // Place player just above ground (player radius = 12)
    add(Myplayer=Player(position: Vector2(_centerX, groundY - 24)));
    // Start camera at bottom
    camera.moveTo(Vector2(_centerX, groundY));
        add(FingerIcon(position: Vector2(_centerX, _screenHeight - _fingerHeight / 2)));
  }
  void _generategamecomponents() {
    add(Colorswitcher(
      position: Vector2(_centerX, 200),
      radius: 15,
    ));
   
    // // previously: world.add(Circle_rotator(
    // //   position: Vector2(0, 0),
    // //   size: Vector2(150, 150),
    // // ));
    add(StarComponent(position: Vector2(_centerX, 0)));
    
    add(Colorswitcher(
      position: Vector2(_centerX, -180),
      radius: 15,
    ));
    
    // // previously: world.add(Circle_rotator(
    // Finger icon as a separate component (top-level)
    class FingerIcon extends SpriteComponent {
      FingerIcon({required Vector2 position}) : super(
        position: position,
        size: Vector2(80, 80),
        anchor: Anchor.center,
      );
      @override
      Future<void> onLoad() async {
        sprite = await Sprite.load('finger.png');
        await super.onLoad();
      }
    }
    // //   position: Vector2(0, -350),
    // //   size: Vector2(150, 150),
    // // )); 
    add(StarComponent(position: Vector2(_centerX, -350)));
    
    add(Colorswitcher(
      position: Vector2(_centerX, -550),
      radius: 15,
    ));
    
    // Add new shapes
    // // previously: world.add(SquareRotator(
    // //   position: Vector2(0, -700),
    // //   size: Vector2(130, 130),
    // //   rotationSpeed: 1.5,
    // // ));
    add(StarComponent(position: Vector2(_centerX, -700)));
    
    add(Colorswitcher(
      position: Vector2(_centerX, -850),
      radius: 15,
    ));
    
    // // previously: world.add(TriangleRotator(
    // //   position: Vector2(0, -1150),
    // //   size: Vector2(400, 400),
    // //   rotationSpeed: 1.5,
    // // ));
    add(StarComponent(position: Vector2(_centerX, -1150)));
     add(Circle_rotator(
      position: Vector2(_centerX, -1700),
      size: Vector2(190, 190),
    ));
     add(Circle_rotator(
      position: Vector2(_centerX, -1700),
      size: Vector2(170, 170),
    ));
    add(StarComponent(position: Vector2(_centerX, -1700)));
    
    add(Colorswitcher(
      position: Vector2(_centerX, -1500),
      radius: 15,
    ));
    // dual anti clock circle 
    add(Circle_rotator(
      position: Vector2(_centerX, -2000),
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
