/*
  FILE USED ONLY FOR REFERENCE.
  ! DO NOT EDIT OR MODIFY !
*/


// import 'package:controller/src/ui/connect/view/connect_qr_code.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// enum ConnectionType {
//   qr,
//   ble,
//   usb,
//   cable,
//   ip,
// }

// class ConnectionMenuPage extends StatefulWidget {
//   const ConnectionMenuPage({super.key});

//   @override
//   State<ConnectionMenuPage> createState() => _ConnectionMenuPageState();
// }

// class _ConnectionMenuPageState extends State<ConnectionMenuPage> {
//   navigateToQrCode(ConnectionType type) {
//     switch (type) {
//       case ConnectionType.qr:
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) => const ConnectFromQrCodePage(),
//         //   ),
//         // );
//         break;
//       // TODO: Handle this case.
//       case ConnectionType.ble:
//       // TODO: Handle this case.
//       case ConnectionType.usb:
//       // TODO: Handle this case.
//       case ConnectionType.cable:
//       // TODO: Handle this case.
//       case ConnectionType.ip:
//       // TODO: Handle this case.
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//       items = [
//         CardItem(
//           icon: Icons.qr_code_rounded,
//           title: 'QR Code',
//           description: 'Scan for QR Code',
//           color: Colors.greenAccent[700]!,
//           type: ConnectionType.qr,
//           isAvailable: true,
//         ),
//         CardItem(
//           icon: Icons.bluetooth_rounded,
//           title: 'Bluetooth',
//           description: 'Pair with your device',
//           color: Colors.blueAccent,
//           type: ConnectionType.ble,
//         ),
//         CardItem(
//           icon: Icons.usb_rounded,
//           title: 'USB Dongle',
//           description: 'Use the Celmouse USB Dongle',
//           color: Colors.purpleAccent,
//           type: ConnectionType.usb,
//         ),
//         CardItem(
//           icon: Icons.cable_rounded,
//           title: 'USB Cable',
//           description: 'Direct connection via cable',
//           color: Colors.orangeAccent,
//           type: ConnectionType.cable,
//         ),
//         CardItem(
//           icon: Icons.onetwothree_rounded,
//           title: 'IP Address',
//           description: 'Type the IP Address digits',
//           color: Colors.redAccent,
//           type: ConnectionType.ip,
//         )
//       ];
//     });
//   }

//   List<CardItem> items = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Connection Alternatives'),
//         ),
//         body: SafeArea(
//           child: ListView.builder(
//             padding: const EdgeInsets.all(8),
//             itemCount: items.length,
//             itemBuilder: (context, index) {
//               final item = items[index];
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8),
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   color: !item.isAvailable ? Colors.grey : item.color,
//                   child: ListTile(
//                     iconColor: Colors.white,
//                     enabled: item.isAvailable,
//                     onTap: () => navigateToQrCode(item.type),
//                     leading: Icon(
//                       item.icon,
//                       size: 28,
//                       color: Colors.white70,
//                     ),
//                     title: Text(
//                       item.title,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     trailing: Visibility(
//                       visible: !item.isAvailable,
//                       child: const Icon(Icons.not_interested_rounded),
//                     ),
//                     subtitle: Text(
//                       item.description,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.white70,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ));
//   }
// }

// class CardItem {
//   final IconData icon;
//   final String title;
//   final String description;
//   final Color color;
//   final ConnectionType type;
//   final bool isAvailable;

//   CardItem({
//     required this.icon,
//     required this.title,
//     required this.description,
//     required this.color,
//     required this.type,
//     this.isAvailable = kDebugMode,
//   });
// }
