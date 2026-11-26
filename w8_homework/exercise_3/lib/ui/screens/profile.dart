import 'package:flutter/material.dart';

import '../../model/profile_tile_model.dart';
import '../theme/theme.dart';

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key, required this.profile});

  final ProfileData profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary.withAlpha(100),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'CADT student Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 40),
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(profile.avatarUrl),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            profile.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          Text(
            profile.position,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          for (final tile in profile.tiles)
            ProfileTile(icon: tile.icon, title: tile.title, data: tile.value),
        ],
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.data,
  });

  final IconData icon;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          leading: Icon(icon, color: AppColors.primary),
          title: Text(title),
          subtitle: Text(data),
        ),
      ),
    );
  }
}
