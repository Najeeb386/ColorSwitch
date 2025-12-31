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
          if(_myGame.isGamePlaying)
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [

                IconButton(onPressed: () {
                  setState(() {
                    _myGame.pauseGame();
                  });
                }, icon: Icon(Icons.pause)),
                ValueListenableBuilder(
                  valueListenable: _myGame.currentscore,
                  builder: (context,int value, child) {
                    return Text(value.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),);
                  }
                )
              ],
            ),
          ),
          if(_myGame.isGamePaused)
          
    Container(
      color: Colors.black45,
      child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Paused", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 48),),
                  SizedBox(
                    height: 140,
                    width: 140,
                    child: IconButton(onPressed: () {
                      setState(() {
                        _myGame.resumeGame();
                      });
                     }, icon: Icon(Icons.play_arrow, color: Colors.white,size: 140,)))
                ],
              ),
            ),
    )
          
       
        ],
      )
    );
  }
}