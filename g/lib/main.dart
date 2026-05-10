import 'package:flutter/material.dart';

void main() { runApp(const GardenApp()); }

class GardenApp extends StatelessWidget {
  const GardenApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: '庭シミュレーター', home: const GardenScreen());
  }
}

class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});
  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  final List<Map<String, dynamic>> _stamps = [];
  int _counter = 0;

  void _addStamp(String emoji) {
    setState(() {
      _stamps.add({"id": _counter++, "emoji": emoji, "x": 150.0, "y": 250.0});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("庭シミュレーター"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        Expanded(child: Container(
          color: Colors.lightGreen[50],
          child: Stack(children: _stamps.map((s) {
            return Positioned(
              left: s["x"], top: s["y"],
              child: GestureDetector(
                onPanUpdate: (d) => setState(() {
                  s["x"] += d.delta.dx;
                  s["y"] += d.delta.dy;
                }),
                child: Text(s["emoji"], style: const TextStyle(fontSize: 48)),
              ),
            );
          }).toList()),
        )),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(12),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(onPressed: () => _addStamp("🌻"), child: const Text("🌻 ひまわり")),
            ElevatedButton(onPressed: () => _addStamp("🌷"), child: const Text("🌷 チューリップ")),
          ]),
        ),
      ]),
    );
  }
}
