import 'package:controller/src/utils/launch_site.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoButton extends StatelessWidget {
  const AppInfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info_outline),
      onPressed: () async {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String version = packageInfo.version;

        if (!context.mounted) return;
        showDialog(
            builder: (context) => AlertDialog(
                  icon: Image.asset(
                    "assets/logo.png",
                    height: 52,
                    width: 52,
                  ),
                  title: const Text("Celmouse"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("© ${DateTime.now().year} Celmouse Ltda."),
                      const SizedBox(height: 4),
                      Text("Version: $version"),
                      const Text("HUB Min Version: 2.1.0"),
                      TextButton(
                        onPressed: () => launchSite(),
                        child: const Text(
                          "Visit Website",
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
            context: context);
      },
    );
  }
}
