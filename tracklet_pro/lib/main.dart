import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/plant/presentation/bottom_navbar/plant_bottom_navbar.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/employe_screen.dart';
import 'package:tracklet_pro/multi_provider/app_provider.dart';
import 'core/constants/theme/theme_constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TrackletApp());
}

class TrackletApp extends StatelessWidget {
  const TrackletApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.providers,
      child: MaterialApp(
        title: 'Tracklet Pro',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const PlantBottomNavbar(),
        routes: {'/employee': (context) => const EmployeeScreen()},
      ),
    );
  }
}
