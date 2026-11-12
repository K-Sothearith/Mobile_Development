import 'package:flutter/material.dart';

void main () {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Hobbies',
            style: TextStyle(fontSize: 30),
          ),
          centerTitle: false,
        ),
        body: Container(
          color: Colors.grey,
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HobbyCard(hobbyTitle: 'Travelling', hobbyIcon: Icons.travel_explore, cardBgColor: Colors.green),
                HobbyCard(hobbyTitle: 'Skating', hobbyIcon: Icons.skateboarding, cardBgColor: Colors.blue),
                HobbyCard(hobbyTitle: 'Gaming', hobbyIcon: Icons.games, cardBgColor: Colors.red),
              ],
            ),
          ),
        )
      ),
    )
  );
}

class HobbyCard extends StatelessWidget {
  final String hobbyTitle;
  final IconData hobbyIcon;
  final Color cardBgColor;

  const HobbyCard({super.key, required this.hobbyTitle, required this.hobbyIcon, this.cardBgColor = Colors.blue});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(20)
      ),
      height: 200,
      margin: EdgeInsets.only(bottom: 10),
      child: Center(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30, right: 20),
              child: Icon(hobbyIcon, color: Colors.white, size: 40),
            ),
            Text(
              hobbyTitle,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight(600),
                color: Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }
}