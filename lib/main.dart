import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:senatorgo/pages/senator_collection_page.dart';
import 'package:senatorgo/pages/senator_finder_page.dart';
import 'package:senatorgo/pages/senator_static_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/pages/home_page.dart';
import 'package:senatorgo/i18n/strings.g.dart';

// Entry point of the application
void main() async {
  // Ensures Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Sets the app locale to the device's locale
  LocaleSettings.useDeviceLocale();

  // Initialize Hive storage system
  await Hive.initFlutter();

  // Open a Hive box named "myBox" for data storage
  await Hive.openBox("myBox");

  // Run the app with translation support
  runApp(
    TranslationProvider(
      child: const MyApp(),
    ),
  );
}

// Router configuration for navigation between pages
final router = GoRouter(
  routes: [
    // Home page route
    GoRoute(
      path: "/",
      builder: (context, state) => HomePage(),
    ),
    // Senator finder page route
    GoRoute(
      path: "/senator_finder",
      builder: (context, state) => SenatorFinderPage(),
    ),
    // Static senator detail page route
    GoRoute(
      path: "/senator_static",
      builder: (context, state) {
        final Map<String, dynamic>? senator =
            state.extra as Map<String, dynamic>?;

        return SenatorStaticPage(senator: senator);
      },
    ),
    // Senator collection page route
    GoRoute(
      path: "/senator_collection",
      builder: (context, state) => SenatorCollectionPage(),
    )
  ],
);

// Main app widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Lock the app orientation to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // ResponsiveSizer provides responsive UI based on screen size
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp.router(
          title: "Senator GO",
          debugShowCheckedModeBanner: false,
          routerConfig: router);
    });
  }
}
