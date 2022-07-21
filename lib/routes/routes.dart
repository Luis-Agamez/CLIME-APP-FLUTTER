import 'package:clima_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../screens/loading_screen.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'home': (_) => const HomeScreen(),
  'loading': (_) => const LoadingScreen(),
};
