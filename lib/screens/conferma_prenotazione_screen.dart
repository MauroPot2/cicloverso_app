import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConfermaPrenotazioneScreen extends StatelessWidget {
  final int slotId;
  final String data;
  final String ora;

  const ConfermaPrenotazioneScreen({
    super.key,
    required this.slotId,
    required this.data,
    required this.ora,
  });

  Future<void> prenotaSlot(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://cicloverso.duckdns.org/api/prenota_slot'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'slot_id': slotId}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Prenotazione confermata')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Errore nella prenotazione')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Conferma Prenotazione")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Vuoi prenotare lo slot del $data alle $ora?',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => prenotaSlot(context),
              child: const Text("Conferma Prenotazione"),
            ),
          ],
        ),
      ),
    );
  }
}
