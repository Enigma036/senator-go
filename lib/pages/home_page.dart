import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:senatorgo/i18n/strings.g.dart';
import 'package:senatorgo/dialogs/location_dialog.dart';
import 'package:senatorgo/geo/geolocation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// The main home page of the app
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Localization helper
    final t = context.t;

    // Checks if GPS/location is enabled on the device
    Future<bool> isGPSEnabled() async {
      final geolocation = Geolocation();
      final isLocationEnabled = await geolocation.determinePosition();
      return isLocationEnabled;
    }

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // App title
        Center(
          child: Text(
            t.appTitle,
            style: TextStyle(
                color: Color(0xff003876),
                fontSize: 30.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        // Button to find your senator using location
        GestureDetector(
          onTap: () async {
            final isLocationEnabled = await isGPSEnabled();
            if (isLocationEnabled) {
              // If location is enabled, navigate to senator finder page
              if (context.mounted) {
                context.push("/senator_finder");
              }
            } else {
              // If location is not enabled, show a dialog
              if (context.mounted) {
                showDialog(
                    context: context,
                    builder: (context) => LocationDialog(
                        title: context.t.locationDialogs.position.title,
                        text: context.t.locationDialogs.position.content));
              }
            }
          },
          child: Container(
            padding: EdgeInsets.all(1.5.h),
            decoration: BoxDecoration(
                color: Color(0xff003876),
                borderRadius: BorderRadius.circular(1.h)),
            child: Text(
              t.buttons.findSenator,
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        // Button to show the collection of senators
        GestureDetector(
          onTap: () {
            if (context.mounted) {
              context.push("/senator_collection");
            }
          },
          child: Container(
            padding: EdgeInsets.all(1.5.h),
            decoration: BoxDecoration(
                color: Color(0xff003876),
                borderRadius: BorderRadius.circular(1.h)),
            child: Text(
              t.buttons.showCollection,
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        // Warning or informational text at the bottom
        Text(t.warning,
            style: TextStyle(color: Color(0xff003876), fontSize: 14.sp)),
      ],
    ));
  }
}
