import 'package:controller/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/config/dependencies.dart'; // Import the getit.dart file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: defaultProvider,
      child: const MyApp(),
    ),
  );
}
