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
      home: const HomePage(),
      theme: ThemeData.dark(
         
      ),
    )
  );
}
class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MyGame _myGame;
  @override
  void initState() {
    _myGame = MyGame();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: _myGame,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(onPressed: () {
               if(_myGame.isGamePaused)
               {
                _myGame.resumeGame();
               }
               else
               {
                _myGame.pauseGame();
               }
            }, icon: Icon(_myGame.isGamePaused ? Icons.play_arrow : Icons.pause)),
          )
        ],
      )
    );
  }
}