import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RelationshipStatusScreen extends StatefulWidget {
  final VoidCallback? whatNext;
  const RelationshipStatusScreen({super.key, this.whatNext});

  @override
  State<RelationshipStatusScreen> createState() =>
      _RelationshipStatusScreenState();
}

class _RelationshipStatusScreenState extends State<RelationshipStatusScreen> {
  final userController = Get.find<UserController>();
  String? _selectedStatus;

  final List<String> _statuses = [
    "Single",
    "In a relationship",
    "Married",
    "Engaged",
    "Separated",
    "Divorced",
    "Widowed",
  ];

  void _onSelect(String status) {
    setState(() {
      _selectedStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Text(
                "What is your relationship status?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: _statuses.length,
                  itemBuilder: (context, index) {
                    final status = _statuses[index];
                    final isSelected = _selectedStatus == status;

                    return GestureDetector(
                      onTap: () => _onSelect(status),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? Colors.grey.shade300
                                  : const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                isSelected
                                    ? Colors.black87
                                    : Colors.transparent,
                          ),
                        ),
                        child: Text(
                          status,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              CustomButton(
                ontap: () async {
                  if (_selectedStatus == null) return;
                  await userController.updateRelationStatus(
                    relationStatus: _selectedStatus!,
                    whatNext: widget.whatNext,
                  );
                },
                text: "Single",
                isLoading: userController.isloading,
                loaderColor: Colors.white,
                child: Text(
                  'Continue',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
