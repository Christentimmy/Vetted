import 'package:flutter/material.dart';

class BackgroundEachResultScreen extends StatelessWidget {
  final String personName;

  const BackgroundEachResultScreen({super.key, required this.personName});

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              width: double.infinity,
              color: Colors.red.shade700,
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    personName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Results should be accurate but some records may be out of date",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // PERSONAL INFORMATION
            _buildSectionTitle("PERSONAL INFORMATION"),
            _buildInfoBox([
              _buildInfoRow("NAME", "Faqaar"),
              _buildInfoRow("AGE", "23"),
              _buildInfoRow("IS DECEASED", "NO"),
            ]),

            const SizedBox(height: 12),

            // CONTACT INFORMATION
            _buildSectionTitle("CONTACT INFORMATION"),
            _buildInfoBox([
              _buildInfoRow("Phone Numbers", "(312) 657-9833\n(312) 657-9833"),
              _buildInfoRow("Email Address", "hhgfgjs@gmail.com"),
              _buildInfoRow("Home Address", "1546 MADISON AVENUE, New York"),
            ]),

            const SizedBox(height: 12),

            // RECORDS
            _buildSectionTitle("RECORDS"),
            _buildInfoBox([
              _buildInfoRow("HAS MARRIAGE RECORDS?", "NONE FOUND"),
              _buildInfoRow("HAS DIVORCE RECORDS?", "NONE FOUND"),
              _buildInfoRow("HAS BANKRUPTCY RECORDS?", "NONE FOUND"),
              _buildInfoRow("HAS FORECLOSURE RECORDS?", "NONE FOUND"),
              _buildInfoRow("HAS EVICTION RECORDS?", "NONE FOUND"),
              _buildInfoRow("HAS LIEN RECORDS?", "NONE FOUND"),
              _buildInfoRow("HAS PROPERTY RECORDS?", "NONE FOUND"),
              _buildInfoRow("HAS VEHICLE RECORDS?", "NONE FOUND"),
            ]),

            const SizedBox(height: 12),

            // FAMILY & ASSOCIATES
            _buildSectionTitle("FAMILY & ASSOCIATES"),
            _buildInfoBox([
              _buildInfoRow("RELATIVE #1", "Ackmed Selah\nFamily\n3/04/1998"),
              _buildInfoRow("RELATIVE #2", "Ackmed Selah\nFamily\n3/04/1998"),
              _buildInfoRow("RELATIVE #3", "Ackmed Selah\nFamily\n3/04/1998"),
            ]),

            const SizedBox(height: 24),

            // Bottom Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 123, 16, 16),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Later hook up navigation
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Ask about her on Vetted clicked"),
                      ),
                    );
                  },
                  child: const Text(
                    "Ask about her on Vetted",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// Section Title (bold black)
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  /// Info Box (outlined container)
  Widget _buildInfoBox(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(children: children),
    );
  }

  /// Info Row with red label and white value
  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: const Color(0xFFB26A6A), // reddish background
          padding: const EdgeInsets.all(12),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(12),
          child: Text(
            value,
            style: const TextStyle(color: Colors.black87, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
