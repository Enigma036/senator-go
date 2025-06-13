import 'package:hive_flutter/hive_flutter.dart';

// This class manages the storage and retrieval of senator data using Hive
class SenatorDatabase {
  // The key used to store/retrieve the senators map in Hive
  final databaseName = "SENATORS";

  // Map to hold senator data, where the key is an int and the value is a String
  Map<int, String> senators = {};

  // Reference to the Hive box named "myBox"
  final _myBox = Hive.box("myBox");

  // Loads senator data from Hive into the senators map
  void loadData() {
    final data = _myBox.get(databaseName);

    if (data != null) {
      // Converts the stored map to Map<int, String>
      senators = Map<int, String>.from((data as Map).map(
        (key, value) => MapEntry(int.parse(key.toString()), value.toString()),
      ));
    }
  }

  // Saves the current senators map to Hive
  void updateData() {
    _myBox.put(databaseName, senators);
  }

  // Adds a new senator record if it doesn't already exist
  void addSenator(int number, String string) {
    if (containsRecord(number, string)) return;
    senators[number] = string;
    updateData();
  }

  // Deletes all senator records
  void deleteAll() {
    senators = {};
    updateData();
  }

  // Checks if a specific senator record exists
  bool containsRecord(int number, String string) {
    return senators[number] == string;
  }
}
