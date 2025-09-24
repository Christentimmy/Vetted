import 'package:Vetted/app/controller/app_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NumberCheckScreen extends StatefulWidget {
  const NumberCheckScreen({super.key});

  @override
  State<NumberCheckScreen> createState() => _NumberCheckScreenState();
}

class _NumberCheckScreenState extends State<NumberCheckScreen> {
  final appServiceController = Get.find<AppServiceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Number Result"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView.builder(
          itemCount: appServiceController.persons.length,
          itemBuilder: (context, index) {
            final person = appServiceController.persons[index];
            // return _infoRow(person.name, person.phone);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  person.name,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Phone Number",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Wrap(
                  children:
                      person.phones.map((phone) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Chip(
                            label: Text(
                              phone.number,
                              style: GoogleFonts.poppins(fontSize: 10),
                            ),
                          ),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text("Date of Birth: ", style: GoogleFonts.poppins()),
                    Text(
                      person.dateOfBirth,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "Email",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Wrap(
                  children:
                      person.emails.map((email) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Chip(
                            label: Text(
                              email,
                              style: GoogleFonts.poppins(fontSize: 10),
                            ),
                          ),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 8),
                Text(
                  "Dead",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  person.isDead ? "Yes" : "No",
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Address",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  person.currentAddresses.isNotEmpty
                      ? person.currentAddresses[0].address
                      : "",
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "OwnedProperties",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  person.ownedProperties.isNotEmpty
                      ? person.ownedProperties[0].toString()
                      : "",
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Job",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  person.jobTitle ?? "",
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Divider(),
              ],
            );
          },
        ),
      ),
    );
  }

  // Widget _infoRow(String title, String value) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 14),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           title,
  //           style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
  //         ),
  //         const SizedBox(width: 6),
  //         Expanded(child: Text(value, style: const TextStyle(fontSize: 15))),
  //       ],
  //     ),
  //   );
  // }
}
