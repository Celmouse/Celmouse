import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportButtonComponent extends StatelessWidget {
  const SupportButtonComponent({super.key});

  @override
  Widget build(BuildContext context) {
    const phone = "https://api.whatsapp.com/send?phone=5533997312898";
    return IconButton(
      onPressed: () {
        launchUrl(
          Uri.parse(phone),
          mode: LaunchMode.externalApplication,
        );
      },
      icon: const Icon(
        Icons.support_agent,
        color: Colors.redAccent,
      ),
    );
  }
}
