import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripee_interview/presentation/pages/schedules_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  // inicializa dados de locale para pt_BR
  await initializeDateFormatting('pt_BR');

  // define default locale (opcional, mas útil)
  Intl.defaultLocale = 'pt_BR';

  runApp(const ProviderScope(
    child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tripee Interview',
      home: const SchedulesPage(),
    );
  }
}