import 'package:flutter/material.dart';

class PollPostScreen extends StatefulWidget {
  const PollPostScreen({super.key});

  @override
  State<PollPostScreen> createState() => _PollPostScreenState();
}

class _PollPostScreenState extends State<PollPostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final List<TextEditingController> _options = [
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _cityController.dispose();
    _contentController.dispose();
    for (var c in _options) {
      c.dispose();
    }
    super.dispose();
  }

  void _addOption() {
    setState(() {
      _options.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Create post",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Post a poll",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // Post Title
            _buildTextField(_titleController, "Post Title"),

            const SizedBox(height: 12),

            // City
            _buildTextField(_cityController, "City"),

            const SizedBox(height: 12),

            // Content
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _contentController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: "What’s on your mind?",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Audio recording button
            OutlinedButton(
              onPressed: () {
                // Placeholder for recording feature
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color.fromARGB(255, 146, 21, 21)),
              ),
              child: const Text(
                "Start audio recording",
                style: TextStyle(color: Color.fromARGB(255, 146, 21, 21)),
              ),
            ),

            const SizedBox(height: 20),

            // Poll Section
            const Text(
              "Poll",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12),

            ..._options.map((controller) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildTextField(controller, "Answer option"),
              );
            }).toList(),

            // Add option button
            GestureDetector(
              onTap: _addOption,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "Add another option",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Add Photo
            const Text(
              "Add photo",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12),

            GestureDetector(
              onTap: () {
                // Placeholder for photo upload
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.add, size: 32, color: Colors.black45),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Post Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Submit poll logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 146, 21, 21),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Post",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hint, border: InputBorder.none),
      ),
    );
  }
}
