import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Custom buttons"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SelectButton(),
            SizedBox(height: 20),
            SelectButton(),
            SizedBox(height: 20),
            SelectButton(),
            SizedBox(height: 20),
            SelectButton(),
            SizedBox(height: 20)
          ],
        )
      ),
    ),
  )
);

class SelectButton extends StatefulWidget{
  const SelectButton({super.key});

  @override
  State<SelectButton> createState() => _SelectButton();
}

class _SelectButton extends State<SelectButton> {
  bool isSelected = false;

  String get text => isSelected ? 'Selected' : 'Not Selected';
  Color get textColor => isSelected ? Colors.white : Colors.black;
  Color get backgroundColor => isSelected ? Colors.blue.shade500 : Colors.blue.shade50;

  void toggleSelect() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: 400,
      height: 100,
      child: ElevatedButton(
          onPressed: toggleSelect,
          style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          )
        ),
    );
  }
}