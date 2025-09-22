import 'package:flutter/material.dart';

class CourtResourceScreen extends StatelessWidget {
  final String title;
  const CourtResourceScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final resources = [
      "Alabama Judiciary (Official Website)",
      "Alabama Courts Case Search",
      "Alabama Inmate Search",
      "Alabama Sex Offender Registry",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: resources.length,
        itemBuilder: (context, index) {
          final resource = resources[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: OutlinedButton(
              onPressed: () {
                // Later you can add URL launch or deeper navigation here
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Tapped: $resource")));
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.centerLeft, // 👈 text stays left
              ),
              child: Text(
                resource,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black, // 👈 force text black
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
