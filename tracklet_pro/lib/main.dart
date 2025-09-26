import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/core/constants/theme/theme_constants.dart';
import 'package:tracklet_pro/core/routes/app_router.dart';
import 'package:tracklet_pro/multi_provider/app_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('Flutter Error: ${details.exception}');
    debugPrint(details.stack?.toString() ?? 'No stack trace');
  };

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
        initialRoute: '/',
        onGenerateRoute: AppRouter.generateRoute,
        builder: (context, child) {
          return child!;
        },
      ),
    );
  }
}
