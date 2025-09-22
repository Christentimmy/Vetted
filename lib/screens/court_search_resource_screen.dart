import 'package:flutter/material.dart';
import 'court_resource_screen.dart';

class CourtSearchResourceScreen extends StatefulWidget {
  const CourtSearchResourceScreen({super.key});

  @override
  State<CourtSearchResourceScreen> createState() =>
      _CourtSearchResourceScreenState();
}

class _CourtSearchResourceScreenState extends State<CourtSearchResourceScreen> {
  final List<String> states = [
    "Alabama",
    "Alaska",
    "New York",
    "California",
    "Colorado",
    "Connecticut",
    "Delaware",
    "Florida",
    "Georgia",
    "Los Angeles",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Court Search Resources"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: states.length,
        itemBuilder: (context, index) {
          final state = states[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                side: const BorderSide(color: Colors.black26),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourtResourceScreen(title: state),
                  ),
                );
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  state,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
