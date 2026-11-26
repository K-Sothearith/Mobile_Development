import 'package:flutter/material.dart';

List<String> colors = ['red', 'blue', 'green'];

Map<String, Color> textColors = {
  'red': Colors.red,
  'blue': Colors.blue,
  'green': Colors.green,
};

Widget colorText(String name) {
  return Text(name, style: TextStyle(color: textColors[name]));
}

List<Widget> getColors() {
  return colors.map((color) => colorText(color)).toList();
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              const Label('Method 1: Loop in Array', bold: true),
              // TODO
              for (var color in colors) colorText(color),
              Label('Method 2: Map', bold: true),
              // TODO
              ...colors.map(colorText),
              const Label('Method 3: Dedicated Function', bold: true),
              // TODO
              ...getColors(),
            ],
          ),
        ),
      ),
    ),
  );
}

class Label extends StatelessWidget {
  const Label(this.text, {super.key, this.bold = false});

  final bool bold;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: (bold ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}
