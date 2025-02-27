import 'package:controller/src/ui/connect/viewmodel/connect_hub_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DevicesScanner extends StatelessWidget {
  const DevicesScanner({
    super.key,
    required this.viewmodel,
  });

  final ConnectHUBViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewmodel,
      builder: (BuildContext context, Widget? child) {
        return Column(
          children: [
            ListTile(
              onLongPress: viewmodel.isScanning
                  ? viewmodel.stopScan
                  : viewmodel.startScan,
              leading: const Icon(Icons.wifi),
              title: const Text('Nearby Devices'),
              subtitle: viewmodel.isScanning ? const Text('Scanning...') : null,
              // enabled: viewmodel.isScanning,
              trailing: viewmodel.isScanning
                  ? Animate(
                      effects: const [
                        FadeEffect(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        ),
                        ScaleEffect(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        ),
                      ],
                      onPlay: (controller) => controller.repeat(),
                      child: const Icon(
                        Icons.circle,
                        color: Colors.blue,
                        size: 12,
                      ),
                    )
                  : null,
            ),
            ...viewmodel.devices.map((device) {
              return ListTile(
                title: Text(device.name),
                trailing: const Icon(
                  Icons.circle,
                  color: Colors.green,
                  size: 12,
                ),
                onTap: () {
                  viewmodel.stopScan();
                  viewmodel.connect(device.ip);
                },
              );
            }),
          ],
        );
      },
    );
  }
}
