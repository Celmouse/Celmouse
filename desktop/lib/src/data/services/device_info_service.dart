import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:protocol/protocol.dart';

class DeviceInfoService {
  Future<ConnectionInfoProtocolData> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isWindows) {
      final windowsInfo = await deviceInfoPlugin.windowsInfo;
      return ConnectionInfoProtocolData(
        deviceName: windowsInfo.computerName,
        deviceOS: DeviceOS.windows,
        versionNumber: windowsInfo.displayVersion,
      );
    } else if (Platform.isLinux) {
      final linuxInfo = await deviceInfoPlugin.linuxInfo;
      return ConnectionInfoProtocolData(
        deviceName: linuxInfo.name,
        deviceOS: DeviceOS.linux,
        versionNumber: linuxInfo.version ?? 'Unknown',
      );
    } else if (Platform.isMacOS) {
      final macOsInfo = await deviceInfoPlugin.macOsInfo;
      return ConnectionInfoProtocolData(
        deviceName: macOsInfo.model,
        deviceOS: DeviceOS.macos,
        versionNumber: macOsInfo.osRelease,
      );
    } else {
      return ConnectionInfoProtocolData(
        deviceName: 'Unknown',
        deviceOS: DeviceOS.unknown,
        versionNumber: 'Unknown',
      );
    }
  }
}
