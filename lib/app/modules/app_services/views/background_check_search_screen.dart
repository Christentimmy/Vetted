import 'package:Vetted/app/controller/app_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackgroundCheckSearchScreen extends StatefulWidget {
  const BackgroundCheckSearchScreen({super.key});

  @override
  State<BackgroundCheckSearchScreen> createState() =>
      _BackgroundCheckSearchScreenState();
}

class _BackgroundCheckSearchScreenState
    extends State<BackgroundCheckSearchScreen> {
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  final appServiceController = Get.find<AppServiceController>();

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_validateForm);
    _lastNameController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isFormValid =
          _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            const Text(
              "Check out more of her info.",
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildTextField("First Name", _firstNameController),
            _buildTextField("Middle Name (optional)", _middleNameController),
            _buildTextField("Last Name", _lastNameController),
            _buildTextField(
              "Phone number",
              _phoneController,
              keyboardType: TextInputType.phone,
            ),
            _buildTextField("City (optional)", _cityController),
            _buildTextField("State (optional)", _stateController),
            SizedBox(height: Get.size.height * 0.1),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    _isFormValid
                        ? () async {
                          await appServiceController.backgroundCheck(
                            firstName: _firstNameController.text.trim(),
                            lastName: _lastNameController.text.trim(),
                            middleName: _middleNameController.text.trim(),
                            street: _cityController.text.trim(),
                            stateCode: _stateController.text.trim(),
                            city: _cityController.text.trim(),
                            zipCode: _phoneController.text.trim(),
                          );
                          _firstNameController.clear();
                          _middleNameController.clear();
                          _lastNameController.clear();
                          _phoneController.clear();
                          _cityController.clear();
                          _stateController.clear();
                        }
                        : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  disabledBackgroundColor: Colors.red.shade200,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Obx(
                  () =>
                      appServiceController.isloading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            "Start Background Check",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 12,
          ),
        ),
      ),
    );
  }
}
