import 'package:flutter/material.dart';

const String cloudyImage = 'assets/ex4/cloudy.png';
const String sunnyImage = 'assets/ex4/sunny.png';
const String sunnyCloudyImage = 'assets/ex4/sunnyCloudy.png';
const String veryCloudyImage = 'assets/ex4/veryCloudy.png';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF4FC3F7),
          foregroundColor: Colors.white,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 50),
              child: Icon(Icons.menu),
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            WeatherCard(
              city: 'Phnom Penh',
              minTemperature: 10,
              maxTemperature: 30,
              temperature: 12.2,
              image: cloudyImage,
              colors: [Color(0xFFD16CF0), Color(0xFFA875F5)],
            ),
            WeatherCard(
              city: 'Paris',
              minTemperature: 10,
              maxTemperature: 40,
              temperature: 22.2,
              image: sunnyCloudyImage,
              colors: [Color(0xFF00DFBD), Color(0xFF20D6B5)],
            ),
            WeatherCard(
              city: 'Rome',
              minTemperature: 10,
              maxTemperature: 40,
              temperature: 45.2,
              image: sunnyImage,
              colors: [Color(0xFFFF5995), Color(0xFFF83F7C)],
            ),
            WeatherCard(
              city: 'Toulouse',
              minTemperature: 10,
              maxTemperature: 40,
              temperature: 45.2,
              image: veryCloudyImage,
              colors: [Color(0xFFFFAF63), Color(0xFFFFD87B)],
            ),
          ],
        ),
      ),
    ),
  );
}

class WeatherCard extends StatelessWidget {
  final String city;
  final double minTemperature;
  final double maxTemperature;
  final double temperature;
  final String image;
  final List<Color> colors;

  const WeatherCard({
    super.key,
    required this.city,
    required this.minTemperature,
    required this.maxTemperature,
    required this.temperature,
    required this.image,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 18),
      child: PhysicalModel(
        color: colors.first,
        elevation: 5,
        shadowColor: Colors.black38,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [colors.first, colors.last],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -55,
                top: -25,
                bottom: -25,
                child: Container(
                  width: 180,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF).withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 28,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: ClipOval(
                          child: Image.asset(
                            image,
                            width: 44,
                            height: 44,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            city,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Min ${minTemperature.toStringAsFixed(1)}°C',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Max ${maxTemperature.toStringAsFixed(1)}°C',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${temperature.toStringAsFixed(1)}°C',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
