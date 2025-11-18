import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  DateTime? _dob;
  String? _location; // sẽ lưu địa chỉ hiển thị
  double? _lat, _lng; // lưu lat/lng để reverse geocoding

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  // Load dữ liệu từ SharedPreferences nếu có
  Future<void> loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _nameController.text = prefs.getString("name") ?? "";
      String? dobString = prefs.getString("dob");
      if (dobString != null) _dob = DateTime.tryParse(dobString);

      _lat = prefs.getDouble("lat");
      _lng = prefs.getDouble("lng");
      _location = prefs.getString("location"); // địa chỉ hiển thị
    });
  }

  // Lưu dữ liệu
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", _nameController.text);
    if (_dob != null) {
      await prefs.setString("dob", _dob!.toIso8601String());
    }
    if (_lat != null && _lng != null) {
      await prefs.setDouble("lat", _lat!);
      await prefs.setDouble("lng", _lng!);
    }
    if (_location != null) {
      await prefs.setString("location", _location!);
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Đã lưu dữ liệu thành công!")));
  }

  // Lấy location + reverse geocoding
  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check GPS
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Vui lòng bật GPS để lấy vị trí")));
      return;
    }

    // Check quyền
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    // Lấy vị trí
    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _lat = pos.latitude;
    _lng = pos.longitude;

    // Reverse geocoding
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(_lat!, _lng!);

      if (placemarks.isNotEmpty) {
        _location = formatPlacemark(placemarks.first);
      } else {
        _location = "Lat: ${_lat}, Lng: ${_lng}";
      }
    } catch (e) {
      _location = "Lat: ${_lat}, Lng: ${_lng}";
    }

    setState(() {});
  }

  // Chọn ngày sinh
  Future<void> pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        _dob = date;
      });
    }
  }

  String formatPlacemark(Placemark place) {
    List<String> parts = [];

    if (place.name != null && place.name!.isNotEmpty) parts.add(place.name!);
    if (place.subThoroughfare != null && place.subThoroughfare!.isNotEmpty)
      parts.add(place.subThoroughfare!);
    if (place.thoroughfare != null && place.thoroughfare!.isNotEmpty)
      parts.add(place.thoroughfare!);
    if (place.subLocality != null && place.subLocality!.isNotEmpty)
      parts.add(place.subLocality!);
    if (place.locality != null && place.locality!.isNotEmpty)
      parts.add(place.locality!);
    if (place.subAdministrativeArea != null &&
        place.subAdministrativeArea!.isNotEmpty)
      parts.add(place.subAdministrativeArea!);
    if (place.administrativeArea != null &&
        place.administrativeArea!.isNotEmpty)
      parts.add(place.administrativeArea!);
    if (place.postalCode != null && place.postalCode!.isNotEmpty)
      parts.add(place.postalCode!);
    if (place.country != null && place.country!.isNotEmpty)
      parts.add(place.country!);

    return parts.join(", ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Information")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tên
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Tên",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Ngày sinh
            GestureDetector(
              onTap: pickDate,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _dob == null
                      ? "Chọn ngày sinh"
                      : "${_dob!.day}/${_dob!.month}/${_dob!.year}",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Location
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    _location ?? "Chưa lấy vị trí",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: getLocation,
                  child: Text("Get Location"),
                ),
              ],
            ),

            Spacer(),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveData,
                child: Text("Lưu lại"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
