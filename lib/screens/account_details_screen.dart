import 'package:flutter/material.dart';

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> cities = [
      'New York',
      'Los Angeles',
      'Chicago',
      'Houston',
    ];
    String selectedCity = 'New York';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // 👈 Go back to where it came from
          },
        ),
        title: const Text(
          'Account',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            // Username
            _textInputField(label: 'Anonymous'),

            const SizedBox(height: 12),

            // Email
            _textInputField(label: 'Your email'),

            const SizedBox(height: 12),

            // Phone Number
            _textInputField(label: 'Phone number'),

            const SizedBox(height: 12),

            // Location Dropdown
            _dropdownField(cities, selectedCity),

            const SizedBox(height: 12),

            // Date of Birth (placeholder)
            _textInputField(label: '02/05/1996'),

            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Save logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Delete Account
            TextButton(
              onPressed: () {
                // Delete account logic
              },
              child: const Text(
                'Delete account',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textInputField({required String label}) {
    return TextField(
      readOnly: true, // for now since it's a placeholder design
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
      ),
    );
  }

  Widget _dropdownField(List<String> items, String selectedItem) {
    return DropdownButtonFormField<String>(
      value: selectedItem,
      items:
          items
              .map((city) => DropdownMenuItem(value: city, child: Text(city)))
              .toList(),
      onChanged: (value) {},
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
      ),
    );
  }
}
