import 'package:flutter/material.dart';
import 'package:senatorgo/dialogs/location_dialog.dart';
import 'package:senatorgo/geo/geofinder.dart';
import 'package:senatorgo/geo/geolocation.dart';
import 'package:senatorgo/i18n/strings.g.dart';
import 'package:senatorgo/pages/senator_page.dart';
import 'package:senatorgo/data/database.dart';
import 'package:vibration/vibration.dart';

// Page that finds and displays the user's senator based on their location
class SenatorFinderPage extends StatefulWidget {
  const SenatorFinderPage({super.key});

  @override
  State<SenatorFinderPage> createState() => _SenatorFinderPageState();
}

class _SenatorFinderPageState extends State<SenatorFinderPage> {
  // Future to handle senator lookup
  late Future<bool> _senatorFuture;
  // Holds the found senator's data
  Map<String, dynamic>? _senator;
  // Database instance for senator records
  final SenatorDatabase db = SenatorDatabase();
  // Flag to prevent handling the same error multiple times
  bool _alreadyHandled = false;

  @override
  void initState() {
    super.initState();
    db.loadData();
    _senatorFuture = _getSenator();
  }

  // Gets the user's location and finds the corresponding senator
  Future<bool> _getSenator() async {
    final geolocation = Geolocation();
    final location = await geolocation.getPositionFromLocation();
    if (location != null) {
      final geofinder = Geofinder();
      await geofinder.loadData("assets/json/districts.json");
      await geofinder.loadSenators("assets/json/senators.json");
      final properties = geofinder
          .getLocationProperties(Point(location.latitude, location.longitude));
      final senator = geofinder.findSenator(properties);
      if (senator != null) {
        // If senator is not already in the database, add and notify user
        if (!db.containsRecord(senator["district"], senator["mandate"])) {
          db.addSenator(senator["district"], senator["mandate"]);

          // Vibrate the device if possible
          if (await Vibration.hasVibrator()) {
            Vibration.vibrate();
          }

          // Show dialog about new senator found
          if (mounted) {
            showDialog(
                context: context,
                builder: (context) => LocationDialog(
                    title: context.t.locationDialogs.newSenator.title,
                    text: context.t.locationDialogs.newSenator.content));
          }
        }

        // Update the UI with the found senator
        if (mounted) {
          setState(() {
            _senator = senator;
          });
          return true;
        }
      }
    }
    // Return false if no senator found or location unavailable
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(context.t.senator),
        ),
        body: RefreshIndicator(
          color: Color(0xff003876),
          onRefresh: () async {
            setState(() {
              _senatorFuture = _getSenator();
            });
            await _senatorFuture;
          },
          child: FutureBuilder(
              future: _senatorFuture,
              builder: (context, snapshot) {
                // Show loading indicator while waiting
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff003876),
                    ),
                  );
                }

                // If no senator found and not already handled, show error dialog
                if (snapshot.hasData &&
                    snapshot.data == false &&
                    !_alreadyHandled) {
                  _alreadyHandled = true;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return LocationDialog(
                            title: context.t.locationDialogs.position.title,
                            text: context.t.locationDialogs.position.content);
                      },
                    );
                  });

                  return SizedBox();
                }

                // Show the senator page if senator is found
                return SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: SenatorPage(
                      senator: _senator,
                    ));
              }),
        ));
  }
}
