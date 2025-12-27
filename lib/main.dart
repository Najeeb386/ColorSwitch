import 'package:colorswitch/Mygame.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    )
  );
}
class HomePage extends StatelessWidget {
  
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: MyGame(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(onPressed: () {}, icon: Icon( Icons.pause, color: Colors.white,)),
          )
        ],
      )
    );
  }
}