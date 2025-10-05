import 'package:Vetted/app/controller/app_service_controller.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BackgroundCheckSearchResultScreen extends StatefulWidget {
  final String name;
  const BackgroundCheckSearchResultScreen({super.key, required this.name});

  @override
  State<BackgroundCheckSearchResultScreen> createState() =>
      _BackgroundCheckSearchResultScreenState();
}

class _BackgroundCheckSearchResultScreenState
    extends State<BackgroundCheckSearchResultScreen> {
  final appServiceController = Get.find<AppServiceController>();
  int? expandedIndex;

  @override
  void dispose() {
    appServiceController.personsBackground.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Text(
              widget.name,
              style: GoogleFonts.fredoka(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            color: Colors.red.shade700,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                "We found ${appServiceController.backgroundCheckList.length} matches",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: appServiceController.backgroundCheckList.length,
              itemBuilder: (context, index) {
                final person = appServiceController.backgroundCheckList[index];
                final isExpanded = expandedIndex == index;

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(
                      color: AppColors.primaryColor.withValues(alpha: 0.2),
                    ),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          person.name,
                          style: GoogleFonts.fredoka(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          person.address.first,
                          style: GoogleFonts.fredoka(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Icon(
                          isExpanded ? Icons.expand_less : Icons.chevron_right,
                        ),
                        onTap: () {
                          setState(() {
                            expandedIndex = isExpanded ? null : index;
                          });
                        },
                      ),
                      if (isExpanded)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(),
                              const SizedBox(height: 8),
                              _buildDetailRow('Date of Birth', person.dob),
                              _buildDetailRow('Age', person.age.toString()),
                              const SizedBox(height: 12),

                              if (person.address.isNotEmpty) ...[
                                Text(
                                  'Addresses',
                                  style: GoogleFonts.fredoka(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ...person.address.map(
                                  (addr) => Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      top: 2,
                                    ),
                                    child: Text('• $addr'),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],

                              if (person.phoneNumbers.isNotEmpty) ...[
                                Text(
                                  'Phone Numbers',
                                  style: GoogleFonts.fredoka(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ...person.phoneNumbers.map(
                                  (phone) => Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      top: 2,
                                    ),
                                    child: Text('• $phone'),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],

                              if (person.emails.isNotEmpty) ...[
                                Text(
                                  'Emails',
                                  style: GoogleFonts.fredoka(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ...person.emails.map(
                                  (email) => Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      top: 2,
                                    ),
                                    child: Text('• $email'),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],

                              if (person.relatives.isNotEmpty) ...[
                                Text(
                                  'Relatives',
                                  style: GoogleFonts.fredoka(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ...person.relatives.map(
                                  (relative) => Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      top: 2,
                                    ),
                                    child: Text(
                                      '• ${relative.name} (${relative.relativeType})',
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Background Check",
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 1,
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: GoogleFonts.fredoka(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value, style: GoogleFonts.fredoka(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
