import 'package:flutter/material.dart';

class WomanPostScreen extends StatefulWidget {
  const WomanPostScreen({super.key});

  @override
  State<WomanPostScreen> createState() => _WomanPostScreenState();
}

class _WomanPostScreenState extends State<WomanPostScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();

  String? _selectedCity;
  bool _isChecked = false;

  final List<String> _cities = [
    "New York",
    "London",
    "Paris",
    "Tokyo",
    "Lagos",
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _ageController.dispose();
    _captionController.dispose();
    super.dispose();
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
              "Post a woman",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // First name
            _buildTextField(_firstNameController, "First name"),

            const SizedBox(height: 12),

            // City dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Text("City"),
                  value: _selectedCity,
                  isExpanded: true,
                  items:
                      _cities.map((city) {
                        return DropdownMenuItem(value: city, child: Text(city));
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 12),

            // His age
            _buildTextField(_ageController, "His age"),

            const SizedBox(height: 12),

            // Caption (optional)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _captionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: "Caption (Optional)",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Checkbox
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (val) {
                    setState(() {
                      _isChecked = val ?? false;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    "All statements are true, no last names.",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Add photo
            GestureDetector(
              onTap: () {
                // Upload image logic here
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

            const SizedBox(height: 20),

            // Preview button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Preview action
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 146, 21, 21),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Preview",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 146, 21, 21),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Post button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Post action
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
