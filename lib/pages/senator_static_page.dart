import 'package:flutter/material.dart';
import 'package:senatorgo/pages/senator_page.dart';

// Page that displays static information about a specific senator
class SenatorStaticPage extends StatelessWidget {
  // The senator's data passed to the page
  final Map<String, dynamic>? senator;

  const SenatorStaticPage({super.key, required this.senator});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // App bar title
          title: Text("Senator"),
        ),
        // Displays the senator's detailed information
        body: SenatorPage(
          senator: senator,
        ));
  }
}
