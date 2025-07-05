import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:confetti/confetti.dart';
import 'statistic_recycle.dart';

void main() {
  runApp(const MaterialApp(home: RecycleCheckerPage()));
}

class RecycleCheckerPage extends StatefulWidget {
  const RecycleCheckerPage({Key? key}) : super(key: key);

  @override
  _RecycleCheckerPageState createState() => _RecycleCheckerPageState();
}

class _RecycleCheckerPageState extends State<RecycleCheckerPage> {
  final List<Map<String, dynamic>> items = [
    {'name': 'Botol Plastik', 'isRecyclable': true, 'points': 10},
    {'name': 'Kantong Kresek', 'isRecyclable': false, 'points': 0},
    {'name': 'Kardus', 'isRecyclable': true, 'points': 10},
    {'name': 'Sedotan Plastik', 'isRecyclable': false, 'points': 0},
    {'name': 'Kaca', 'isRecyclable': true, 'points': 10},
    {'name': 'Styrofoam', 'isRecyclable': false, 'points': 0},
  ];

  final int maxItems = 10;
  int totalPoints = 0;
  Map<String, int> itemQuantities = {};
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    _loadData();
    for (var item in items) {
      itemQuantities[item['name']] = 0;
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalPoints', totalPoints);
    await prefs.setStringList(
      'itemQuantities',
      itemQuantities.entries.map((e) => '${e.key}:${e.value}').toList(),
    );
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      totalPoints = prefs.getInt('totalPoints') ?? 0;

      List<String>? savedQuantities = prefs.getStringList('itemQuantities');
      if (savedQuantities != null) {
        for (var entry in savedQuantities) {
          var parts = entry.split(':');
          var itemName = parts[0];
          var itemQuantity = int.tryParse(parts[1]) ?? 0;
          itemQuantities[itemName] = itemQuantity;
        }
      }
    });
  }

  void _incrementItem(Map<String, dynamic> item) {
    final itemName = item['name'];
    final itemPoints = item['points'] as int;

    setState(() {
      itemQuantities[itemName] = (itemQuantities[itemName] ?? 0) + 1;
      totalPoints += itemPoints;
      _saveData();

      if (itemPoints > 0 && totalPoints % 20 == 0) {
        _confettiController.play();
      }
    });
  }

  void _decrementItem(Map<String, dynamic> item) {
    final itemName = item['name'];
    final itemPoints = item['points'] as int;

    setState(() {
      if ((itemQuantities[itemName] ?? 0) > 0) {
        itemQuantities[itemName] = (itemQuantities[itemName] ?? 0) - 1;
        totalPoints -= itemPoints;
        _saveData();
      }
    });
  }

  void _resetData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      totalPoints = 0;
      for (var key in itemQuantities.keys) {
        itemQuantities[key] = 0;
      }
    });

    await prefs.setInt('totalPoints', totalPoints);
    await prefs.setStringList('itemQuantities', []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cek Daur Ulang'),
        backgroundColor: Colors.green.shade700,
      ),
      backgroundColor: Colors.green.shade50,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih jenis sampah:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final itemName = item['name'];
                  final quantity = itemQuantities[itemName] ?? 0;

                  return Card(
                    child: ListTile(
                      title: Text(itemName),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                            onPressed:
                                quantity > 0
                                    ? () => _decrementItem(item)
                                    : null,
                          ),
                          Text('$quantity'),
                          IconButton(
                            icon: const Icon(
                              Icons.add_circle,
                              color: Colors.green,
                            ),
                            onPressed: () => _incrementItem(item),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => StatisticsPage(
                            itemQuantities: itemQuantities,
                            maxItems: maxItems,
                          ),
                    ),
                  );
                },
                child: const Text("Lihat Statistik"),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      floatingActionButton: ConfettiWidget(
        confettiController: _confettiController,
        blastDirectionality: BlastDirectionality.explosive,
        shouldLoop: false,
        colors: const [Colors.green, Colors.blue, Colors.orange],
      ),
    );
  }
}
