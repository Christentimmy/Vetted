import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/modules/post/widgets/custom_textfield.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAlertsScreen extends StatefulWidget {
  const MyAlertsScreen({super.key});

  @override
  State<MyAlertsScreen> createState() => _MyAlertsScreenState();
}

class _MyAlertsScreenState extends State<MyAlertsScreen> {
  final userController = Get.find<UserController>();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userController.alertList.isEmpty) {
        userController.getAlerts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Alerts"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          userController.getAlerts();
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: nameController,
                    hintText: "Search",
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () async {
                    if (nameController.text.isEmpty) return;
                    await userController.createAlert(name: nameController.text);
                    nameController.clear();
                  },
                  child: Container(
                    width: 70,
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Obx(
                      () =>
                          userController.isloading.value
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : Text(
                                "Create",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (userController.isLoadingAlerts.value) {
                return SizedBox(
                  width: double.infinity,
                  height: Get.size.height * 0.5,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                );
              }
              if (userController.alertList.isEmpty) {
                return SizedBox(
                  width: double.infinity,
                  height: Get.size.height * 0.5,
                  child: const Center(child: Text("No alerts found")),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: userController.alertList.length,
                itemBuilder: (context, index) {
                  final alert = userController.alertList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          alert.name.capitalizeFirst ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.black),
                          onPressed:
                              () => userController.deleteAlert(id: alert.id),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
