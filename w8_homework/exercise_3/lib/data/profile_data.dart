import 'package:flutter/material.dart';

import '../model/profile_tile_model.dart';

ProfileData bombardinoProfile = ProfileData(
  name: 'Bombardino',
  position: 'Jujutsu Sorcerer',
  avatarUrl: 'assets/Bombardino.png',
  tiles: [
    TileData(icon: Icons.pets, title: 'Species', value: 'Alpha Cat'),
    TileData(icon: Icons.cake, title: 'Date of Birth', value: '29th February 2024'),
    TileData(icon: Icons.email, title: 'Email', value: 'bombardino@leader.kh'),
    TileData(icon: Icons.phone, title: 'Phone Number', value: '+855 1100 0010'),
    TileData(icon: Icons.location_on, title: 'Address', value: 'Phnom Penh'),
  ],
);
