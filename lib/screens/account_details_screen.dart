import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/modules/post/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountDetailsScreen extends StatelessWidget {
  AccountDetailsScreen({super.key});

  final userController = Get.find<UserController>();

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
        title: Text(
          'Account',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            // Username
            CustomTextField(
              controller: TextEditingController(),
              hintText: 'Anonymous',
            ),
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
