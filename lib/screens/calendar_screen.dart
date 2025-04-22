import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';
import 'conferma_prenotazione_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<dynamic> slots = [];
  bool loading = true;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchSlots();
  }

  Future<void> fetchSlots() async {
    try {
      final now = DateTime.now();
      final inTenDays = now.add(const Duration(days: 10));
      final dateFormat = DateFormat('yyyy-MM-dd');
      final data = await ApiService.getSlots(
        start: dateFormat.format(now),
        end: dateFormat.format(inTenDays),
      );
      setState(() {
        slots = data;
        loading = false;
      });
    } catch (e) {
      debugPrint('Errore: $e');
      setState(() {
        loading = false;
      });
    }
  }

  List<DateTime> generateNextDays(int count) {
    final now = DateTime.now();
    return List.generate(count, (i) => now.add(Duration(days: i)));
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredSlots =
        slots
            .where(
              (slot) =>
                  slot['data'] == DateFormat('yyyy-MM-dd').format(selectedDate),
            )
            .toList();

    return Column(
      children: [
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              final day = generateNextDays(10)[index];
              final isSelected =
                  day.day == selectedDate.day &&
                  day.month == selectedDate.month;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDate = day;
                  });
                },
                child: Container(
                  width: 70,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('E', 'it_IT').format(day),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(day.day.toString()),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child:
              filteredSlots.isEmpty
                  ? const Center(
                    child: Text('Nessuno slot disponibile per questo giorno'),
                  )
                  : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredSlots.length,
                    itemBuilder: (context, index) {
                      final slot = filteredSlots[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                            '🕒 ${slot['ora_inizio']} - ${slot['ora_fine']}',
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => ConfermaPrenotazioneScreen(
                                        slotId: slot['id'],
                                        data: slot['data'],
                                        ora: slot['ora_inizio'],
                                      ),
                                ),
                              );
                            },
                            child: const Text("Prenota"),
                          ),
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
