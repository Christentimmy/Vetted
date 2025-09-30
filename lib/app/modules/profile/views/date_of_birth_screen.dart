import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:Vetted/app/widgets/staggered_column_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // For formatting month

class DateOfBirthScreen extends StatefulWidget {
  final VoidCallback? whatNext;
  const DateOfBirthScreen({super.key, this.whatNext});

  @override
  State<DateOfBirthScreen> createState() => _DateOfBirthScreenState();
}

class _DateOfBirthScreenState extends State<DateOfBirthScreen> {
  DateTime _selectedDate = DateTime.now();
  final userController = Get.find<UserController>();

  void _onDaySelected(int day) {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, day);
    });
  }

  void _changeMonth(int offset) {
    setState(() {
      _selectedDate = DateTime(
        _selectedDate.year,
        _selectedDate.month + offset,
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    int year = _selectedDate.year;
    int month = _selectedDate.month;
    int daysInMonth = DateTime(year, month + 1, 0).day;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: StaggeredColumnAnimation(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Image.asset('assets/images/birthday_popup.png', height: 80),
              const SizedBox(height: 20),
              const Text(
                "When were you born?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Birthday",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () => _changeMonth(-1),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        helpText: 'Select Your Birthday',
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData(
                              colorScheme: ColorScheme.light(
                                primary: AppColors.primaryColor,
                                onPrimary: Colors.white,
                                onSurface: Colors.black,
                              ),
                              dialogTheme: DialogThemeData(
                                backgroundColor: Colors.white,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (pickedDate != null) {
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "${DateFormat.MMMM().format(_selectedDate)} ${_selectedDate.year}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () => _changeMonth(1),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              // Calendar Grid
              GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: List.generate(daysInMonth, (index) {
                  final day = index + 1;
                  final isSelected = _selectedDate.day == day;

                  return GestureDetector(
                    onTap: () => _onDaySelected(day),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? AppColors.primaryColor
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$day',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: Get.height * 0.1),
              CustomButton(
                ontap: () async {
                  HapticFeedback.lightImpact();
                  if (userController.isloading.value) return;
                  await userController.updateDob(
                    dateOfBirth: _selectedDate,
                    whatNext: widget.whatNext,
                  );
                },
                isLoading: userController.isloading,
                loaderColor: Colors.white,
                child: Text(
                  'Continue',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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
