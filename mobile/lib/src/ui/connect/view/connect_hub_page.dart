import 'package:controller/src/UI/connect_from_qr/view/connect_qr_code.dart';
import 'package:controller/src/UI/mouse/view/mouse_page.dart';
import 'package:controller/src/ui/connect/view/devices_scanner.dart';
import 'package:controller/src/ui/core/ui/support_button.dart';
import 'package:controller/src/ui/connect/view/enter_hub_ip_tile.dart';
import 'package:controller/src/ui/connect/viewmodel/connect_hub_viewmodel.dart';
import 'package:controller/src/ui/core/ui/app_info_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../utils/launch_site.dart';

class ConnectHUBPage extends StatefulWidget {
  const ConnectHUBPage({
    super.key,
    this.viewmodel,
  });

  final ConnectHUBViewmodel? viewmodel;

  @override
  State<ConnectHUBPage> createState() => _ConnectHUBPageState();
}

class _ConnectHUBPageState extends State<ConnectHUBPage> {
  late final ConnectHUBViewmodel viewmodel;
  @override
  void initState() {
    viewmodel = widget.viewmodel ??
        ConnectHUBViewmodel(
          connectRepository: context.read(),
        );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    viewmodel.addListener(_listener);
    viewmodel.startScan();
    super.initState();
  }

  @override
  void dispose() {
    viewmodel.removeListener(_listener);
    viewmodel.stopScan();
    super.dispose();
  }

  void _listener() {
    if (viewmodel.isConnected) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MousePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppInfoButton(),
        title: const Text('Connect'),
        centerTitle: true,
        actions: const [
          SupportButtonComponent(),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Connection Options',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      DevicesScanner(viewmodel: viewmodel),
                      const Divider(),
                      EnterHubIPTile(viewmodel: viewmodel),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.qr_code_scanner),
                        title: const Text('Connect via QR Code'),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ConnectFromQrCodePage(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Spacer(),
              // const BannerAdWidget(),
              // const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
