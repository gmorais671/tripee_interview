import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final apiBase = dotenv.env['API_BASE_URL'] ?? 'https://tripee-interview.azurewebsites.net/v1';
    return MaterialApp(
      title: 'Tripee Interview',
      home: Scaffold(
        appBar: AppBar(title: const Text('Tripee Interview')),
        body: Center(child: Text('API_BASE_URL = $apiBase')),
      ),
    );
  }
}