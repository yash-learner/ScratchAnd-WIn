import 'package:flutter/material.dart';
import 'dart:math';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage lucky = AssetImage("images/rupee.png");
  AssetImage unlucky = AssetImage("images/sadFace.png");
  List<String> itemArray;
  int luckyNumber;
  int count = 0;
  int z=4;
  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25, (index) => "empty");
    generateRandomNumber();
  }

  generateRandomNumber() {
    int random = Random().nextInt(25);
    setState(() {
      luckyNumber = random;
    });
  }

  AssetImage getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return lucky;
        break;
      case "unlucky":
        return unlucky;
        break;
      case "empty":
        {
          return circle;
        }
    }
    return circle;
  }

  playGame(int index) {
    if (luckyNumber == index) {
      setState(() {
        if (count < 5) {
          itemArray[index] = "lucky";
          count = count + 1;
          Toast.show("You Won!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
        } 
        else {
          itemArray[index] = "empty"; 
          if(count >= 5)
          Toast.show("Scratch Limit Exceeded!", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
        }
      });
    } 
    else {
      setState(() {
        if (count < 5) {
          itemArray[index] = "unlucky";
          Toast.show( "${z}Chances Left", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
          z=z-1;
          count = count + 1;
        } 
        else {
          itemArray[index] = "empty"; 
          if(count >= 5)
           Toast.show("Scratch Limit Exceeded!", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
        }
      });
    }
  }

  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumber] = "lucky";
    });
  }

  resteGame() {
    setState(() {
      itemArray = List<String>.filled(25, "empty");
      count = 0;
      z=4;
    });
    generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scratch and Win"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: itemArray.length,
              itemBuilder: (context, i) => SizedBox(
                width: 50.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    this.playGame(i);
                  },
                  child: Image(
                    image: this.getImage(i),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                this.showAll();
              },
              color: Colors.pink,
              padding: EdgeInsets.all(20.0),
              child: Text("ShowAll"),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                this.resteGame();
              },
              color: Colors.pink,
              padding: EdgeInsets.all(20.0),
              child: Text("RESETGAME"),
            ),
          ),
          Container(
            color: Colors.black,
            padding: EdgeInsets.all(20.0),
            child: Center(
                child: Text(
              "LearnCodeOnline.in",
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            )),
          ),
        ],
      ),
    );
  }
}
