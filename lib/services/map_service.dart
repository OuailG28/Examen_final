import 'package:url_launcher/url_launcher.dart';

class MapService {
  static Future<void> openInGoogleMaps({
    required String address,
    required String pharmacyName,
    double? latitude,
    double? longitude,
  }) async {
    String url;

    if (latitude != null && longitude != null) {
      url =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    } else {
      final query = Uri.encodeComponent('$pharmacyName $address');
      url = 'https://www.google.com/maps/search/?api=1&query=$query';
    }

    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Impossible d\'ouvrir Google Maps';
    }
  }
}
