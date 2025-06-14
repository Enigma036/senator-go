import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:senatorgo/geo/geofinder.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:latlong2/latlong.dart';
import 'package:senatorgo/data/database.dart';
import 'package:senatorgo/i18n/strings.g.dart';

// Page that displays a collection of senators on a map
class SenatorCollectionPage extends StatefulWidget {
  const SenatorCollectionPage({super.key});

  @override
  State<SenatorCollectionPage> createState() => _SenatorCollectionPageState();
}

class _SenatorCollectionPageState extends State<SenatorCollectionPage> {
  // Geofinder instance for geographic operations
  final Geofinder geoFinder = Geofinder();
  // All polygons loaded from geo data
  List<Polygon> allPolygons = [];
  // Polygons filtered by selected filter
  List<Polygon> filteredPolygons = [];
  // Database instance for senator records
  final db = SenatorDatabase();
  // Number of senators in the collection
  int counter = 0;

  // Currently selected filter
  late String selectedFilter;
  // List of available filters
  late List<String> filters;

  // Controller for the map
  final mapController = MapController();

  @override
  void initState() {
    super.initState();
    db.loadData();
    counter = db.senators.length;
    _loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize filters based on localization
    selectedFilter = context.t.filters.all;
    filters = [
      context.t.filters.all,
      context.t.filters.prague,
      context.t.filters.brno,
      context.t.filters.ostrava
    ];
  }

  // Loads all polygons for the map
  Future<void> _loadData() async {
    final List<Polygon> tempPolygons = await geoFinder.loadSenatorsCollection(
        "assets/json/districts.json", "assets/json/senators.json");

    setState(() {
      allPolygons = tempPolygons;
      filteredPolygons = tempPolygons;
    });
  }

  // Filters polygons based on the selected filter and zooms the map
  Future<void> _filterPolygons() async {
    if (selectedFilter == context.t.filters.all) {
      _zoomToAll();
      filteredPolygons = await geoFinder.loadSenatorsCollection(
          "assets/json/districts.json", "assets/json/senators.json");
    } else if (selectedFilter == context.t.filters.prague) {
      _zoomToPrague();
      filteredPolygons = await geoFinder.loadSenatorsCollection(
          "assets/json/prague.json", "assets/json/senators.json");
    } else if (selectedFilter == context.t.filters.brno) {
      _zoomToBrno();
      filteredPolygons = await geoFinder.loadSenatorsCollection(
          "assets/json/brno.json", "assets/json/senators.json");
    } else if (selectedFilter == context.t.filters.ostrava) {
      _zoomToOstrava();
      filteredPolygons = await geoFinder.loadSenatorsCollection(
          "assets/json/ostrava.json", "assets/json/senators.json");
    }
  }

  // Zooms the map to show all districts
  void _zoomToAll() {
    mapController.move(
      LatLng(49.8, 15.5),
      6.8,
    );
    mapController.rotate(0);
  }

  // Zooms the map to Prague
  void _zoomToPrague() {
    mapController.move(
      LatLng(50.1, 14.47),
      10.2,
    );
    mapController.rotate(0);
  }

  // Zooms the map to Brno
  void _zoomToBrno() {
    mapController.move(
      LatLng(49.21, 16.62),
      11.0,
    );
    mapController.rotate(0);
  }

  // Zooms the map to Ostrava
  void _zoomToOstrava() {
    mapController.move(
      LatLng(49.85, 18.238),
      10.5,
    );
    mapController.rotate(0);
  }

  // Handles filter selection and updates the map
  void _onFilterSelected(String value) {
    setState(() {
      selectedFilter = value;
      _filterPolygons();
    });
  }

  // Handles tap on the map: shows senator info or district info
  void _handleTap(LatLng latLng) {
    final props = geoFinder
        .getLocationProperties(Point(latLng.latitude, latLng.longitude));
    if (props != null) {
      final senator = geoFinder.findSenator(props);
      if (db.containsRecord(senator?["district"], senator?["mandate"])) {
        // If senator is in the collection, navigate to static senator page
        context.push("/senator_static", extra: senator);
      } else {
        // Otherwise, show a dialog with district info
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("${context.t.onTapMap.district} ${props['OBVOD']}"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(context.t.senatorCollection)),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  // The map widget with polygons
                  FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      initialCenter: LatLng(49.8, 15.5),
                      initialZoom: 6.8,
                      backgroundColor: Colors.white,
                      onTap: (tapPos, latLng) => _handleTap(latLng),
                    ),
                    children: [
                      PolygonLayer(polygons: filteredPolygons),
                    ],
                  ),
                  // Overlay with senator count and filter chips
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 2.h),
                      padding: EdgeInsets.all(1.h),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(75, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Shows the number of senators in the collection
                          Text(
                            "${context.t.numberOfSenators}: $counter/81",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          // Filter chips for selecting region
                          Wrap(
                            spacing: 3.w,
                            children: filters.map((filter) {
                              return ChoiceChip(
                                label: Text(filter),
                                selected: selectedFilter == filter,
                                onSelected: (_) => _onFilterSelected(filter),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
