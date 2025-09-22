import 'package:Vetted/screens/religion_screen.dart';
import 'package:flutter/material.dart';

class RelationshipStatusScreen extends StatefulWidget {
  const RelationshipStatusScreen({super.key});

  @override
  State<RelationshipStatusScreen> createState() =>
      _RelationshipStatusScreenState();
}

class _RelationshipStatusScreenState extends State<RelationshipStatusScreen> {
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
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed:
                      _selectedStatus != null
                          ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ReligionScreen(),
                              ),
                            );
                          }
                          : null,

                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _selectedStatus != null
                            ? Colors.red.shade700
                            : Colors.red.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
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
