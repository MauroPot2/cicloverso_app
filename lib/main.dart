import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'screens/home_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('it_IT', null);
  runApp(const CicloVersoApp());
}

class CicloVersoApp extends StatelessWidget {
  const CicloVersoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CicloVerso',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const HomeNavigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Benvenuto in CicloVerso')),
      body: const Center(child: Text('Iniziamo la tua esperienza 🚴‍♂️')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.pedal_bike),
      ),
    );
  }
}
