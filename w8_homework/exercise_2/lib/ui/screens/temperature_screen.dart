import 'package:flutter/material.dart';

class TemperatureScreen extends StatefulWidget {
  const TemperatureScreen({super.key});

  @override
  State<TemperatureScreen> createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  String _celsiusInput = '';

  final InputDecoration inputDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white, width: 1.0),
      borderRadius: BorderRadius.circular(12),
    ),
    hintText: 'Enter a temperature',
    hintStyle: const TextStyle(color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    final celsius = double.tryParse(_celsiusInput);
    final fahrenheit = celsius == null ? null : celsius * 1.8 + 32;
    final String result;
    if (_celsiusInput.isEmpty) {
      result = '0';
    } else if (fahrenheit == null || !fahrenheit.isFinite) {
      result = '—';
    } else {
      result = fahrenheit.toStringAsFixed(2);
    }

    return ListView(
      padding: const EdgeInsets.all(40.0),
      children: [
        const Icon(Icons.thermostat_outlined, size: 120, color: Colors.white),
        const Center(
          child: Text(
            "Converter",
            style: TextStyle(color: Colors.white, fontSize: 45),
          ),
        ),
        const SizedBox(height: 50),
        const Text("Temperature in Celsius:"),
        const SizedBox(height: 10),
        TextField(
          decoration: inputDecoration,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
            signed: true,
          ),
          onChanged: (value) {
            setState(() {
              _celsiusInput = value.trim();
            });
          },
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 30),
        const Text("Temperature in Fahrenheit:"),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(result),
        ),
      ],
    );
  }
}
