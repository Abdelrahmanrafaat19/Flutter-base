import 'package:url_launcher/url_launcher.dart';

Future<void> openMap(String lat, String lng) async {
  if(lat.isEmpty || lat.isEmpty) return;
  final Uri googleMapUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");

  if (await canLaunchUrl(googleMapUrl)) {
    await launchUrl(googleMapUrl);
  } else {
    throw "Could not open the map.";
  }
}
