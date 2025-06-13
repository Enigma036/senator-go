import 'package:flutter/material.dart';
import 'package:senatorgo/i18n/strings.g.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

// Page that displays detailed information about a senator
class SenatorPage extends StatelessWidget {
  // The senator's data passed to the page
  final Map<String, dynamic>? senator;

  const SenatorPage({super.key, this.senator});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5.h,
        ),
        // Senator's photo in a circular avatar
        Center(
          child: CircleAvatar(
            radius: 25.w,
            backgroundColor: Color(0xff003876),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ClipOval(
                child: Image.asset(senator?["photo"]),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        // Senator's name
        Text(
          "${senator?["name"]}",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xff003876),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        // Senator's mandate
        Text(
          "${senator?["mandate"]}",
          style: TextStyle(
            fontSize: 17.sp,
            color: Color(0xff003876),
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        // Parliamentary group label
        Text(
          context.t.parliamentaryGroup,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xff003876),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        // Senator's club or group
        Text(
          "${senator?["club"]}",
          style: TextStyle(
            fontSize: 17.sp,
            color: Color(0xff003876),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        // Button to open the senator's website
        GestureDetector(
          onTap: () async {
            await launchUrl(Uri.parse("${senator?["web"]}"));
          },
          child: Container(
            padding: EdgeInsets.all(1.5.h),
            decoration: BoxDecoration(
              color: Color(0xff003876),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              context.t.buttons.findOutMoreInformation,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
