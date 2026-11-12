import 'package:flutter/material.dart';

void main () {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Custom buttons',
            style: TextStyle(fontSize: 30),
          ),
          centerTitle: false,
        ),
        body: Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomButton(label: 'Submit', icon: Icons.check),
              CustomButton(label: 'Time', icon: Icons.timer, iconPosition: Position.right, buttonType: Type.secondary),
              CustomButton(label: 'Account', icon: Icons.account_tree, iconPosition: Position.right, buttonType: Type.disabled)
            ],
          ),
        ),
      ),
    )
  );
}

enum Position {left, right}
enum Type {primary, secondary, disabled}

class CustomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Position iconPosition;
  final Type buttonType;

  const CustomButton({super.key, required this.label, required this.icon, this.iconPosition = Position.left, this.buttonType = Type.primary});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: buttonType == Type.primary ? Colors.blue
        : buttonType == Type.secondary ? Colors.green
        : Colors.grey,
        borderRadius: BorderRadius.circular(40)
      ),
      height: 200,
      margin: EdgeInsets.only(bottom: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: iconPosition == Position.left ? 
            [
              Icon(icon, color: Colors.white, size: 40),
              const SizedBox(width: 10),
              Text(label, style: const TextStyle(color: Colors.white, fontSize: 40)),
            ]
          : [
              Text(label, style: const TextStyle(color: Colors.white, fontSize: 40)),
              const SizedBox(width: 10),
              Icon(icon, color: Colors.white, size: 40),
            ],
        ),
      ),
    );
  }
}