import 'package:flutter/material.dart';
import 'background_check_result_done_screen.dart';

class BackgroundCheckSearchResultScreen extends StatelessWidget {
  const BackgroundCheckSearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example data (replace with real search results later)
    final List<Map<String, String>> results = [
      {"name": "Faqaar Saleh", "age": "29", "location": "Broadway, NY"},
      {"name": "Saleh Huch", "age": "43", "location": "Broadway, NY"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Background Check"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          const Center(
            child: Text(
              "Faqaar Saleh",
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            color: Colors.red.shade700,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: const Center(
              child: Text(
                "We found 2 matches",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final person = results[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: const BorderSide(color: Colors.black12),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      "${person['name']} - ${person['age']}",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(person['location'] ?? ""),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => BackgroundCheckResultDoneScreen(
                                personName: person['name']!,
                              ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
