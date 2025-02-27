import 'package:url_launcher/url_launcher.dart';

launchSite() {
  const url = "https://celmouse.com";
  launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  );
}
