import 'package:Vetted/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.12),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Vetted Dating Advice Privacy Policy",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Text(
                      "Date last updated: [October 18, 2025] \n\nVersion: 1.0",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      """ 
This privacy policy ("Privacy Policy") explains how Vetted Dating Advice, LLC, a [Michigan limited liability company] ("Vetted Dating Advice," "our," "we," or "us") processes, collects, uses, and discloses information about you when you access or use [https://vetteddatingadvice.com/] (the “Site”), our mobile applications, Vetted Dating Advice (the “Apps”), and all related websites, software, technologies, data, features, and other products and services provided by us or our affiliates or subsidiaries (collectively, the “Services”).

By registering or using our Site, Apps or Services, you acknowledge and agree that your personal information may be collected, used, processed and disclosed as outlined in this Privacy Policy, and you accept this Privacy Policy in full without limitation. Your use of the Site, Apps and Services is subject to this Privacy Policy as well as our Terms and Conditions at [https://vetteddatingadvice.com/]. If you do not agree with this Privacy Policy, please do not use our Site, Apps or Services.

We may change this Privacy Policy from time to time. If we make changes, we will notify you by revising the date at the top of this policy and, in some cases, we may provide you with additional notice (such as adding a statement to our Site, Apps or Services, or sending you a notification). We encourage you to review this Privacy Policy regularly to stay informed about our information practices and the choices available to you.
""",

                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Information We Collect",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      """
The term "personal information" as used in this Privacy Policy means information that identifies, relates to, describes, is reasonably capable of being associated with, or could reasonably be linked, directly or indirectly, with you. Personal information does not include information that is publicly available, deidentified, or aggregated. We and our vendors may collect personal information from and about users of our Services from the following sources: """,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Personal information collected automatically, including:",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    buildTable(
                      rows: [
                        buildTableHeader(
                          title1: "Category",
                          title2: "Description",
                        ),
                        buildTableText(
                          title1: "App, browser, and device information",
                          title2:
                              "Information about the device, operating system, and browser you’re using; device identifiers and IP addresses.",
                        ),
                        buildTableText(
                          title1: "Product usage and analytics information",
                          title2:
                              "Vetted Dating Advice uses third-party analytics services to gather information about how users interact with the website. This includes pages visited, links clicked, time spent on pages, what you view and click, how you use our Site, Apps and Services, and other usage metrics.",
                        ),
                        buildTableText(
                          title1: "Diagnostic information",
                          title2:
                              "Information about how our Site, Apps and Services are performing when you use them, including service-related diagnostic and performance information, timestamps, crash data, website performance logs, and error messages or reports",
                        ),
                        buildTableText(
                          title1: "Log Files",
                          title2:
                              "Standard web server logs collect data like your IP address, browser type, Internet Service Provider (ISP), date and time stamps of your visits, referring and exit pages, and the clicks you make. ",
                        ),
                        buildTableText(
                          title1: "Cookies and similar technologies",
                          title2:
                              "See Section 4 for additional information on what data is collected using cookies and similar technologies.",
                        ),
                        buildTableText(
                          title1: "Location data",
                          title2:
                              "With your consent, Vetted Dating Advice may collect approximate location information based on your IP address, through our mobile applications, or precise location data to provide location-based features and services.",
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Personal information provided to us, including:",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    buildTable(
                      rows: [
                        buildTableHeader(
                          title1: "Category",
                          title2: "Description",
                        ),
                        buildTableText(
                          title1: "User information",
                          title2:
                              "Name, email address, Apple ID, account identifier, encrypted password, postal address, phone number, photograph, metadata, contacts, referrals, attachments and documentation shared directly with Vetted Dating Advice or through any account registration processes, and other information you provide to us from time to time.",
                        ),
                        buildTableText(
                          title1: "User feedback",
                          title2:
                              "User suggestions, submissions, survey responses, feedback and other ideas or information users provide to us.",
                        ),
                        buildTableText(
                          title1: "User content",
                          title2:
                              "User content, uploads, submissions, information, data, posts, opinions, photographs, messages, referrals, and content of any nature that users submit or otherwise upload to the Site, Apps or Services.",
                        ),
                        buildTableText(
                          title1: "Identity screenings",
                          title2:
                              "Any information we collect related to verifying your identity and sanctions compliance, including but not limited to your name, domicile, government identification numbers, date of birth, and any other information or documentation users provide in connection with verifying their identity and compliance",
                        ),

                        buildTableText(
                          title1: "Preferences",
                          title2:
                              "The settings and preferences users select or modify when using the Site, Apps and Services.",
                        ),
                        buildTableText(
                          title1: "Permissions granted on the Site and in Apps",
                          title2: """
Camera. You may be asked to take a new photo (selfie) using your device’s camera to confirm your identity or for other verification purposes.
Microphone. The app may use your microphone if you choose to record or include audio in your posts or comments.
Contacts. With your permission, the app may access your contact list so you can invite friends to join.
Photos. The Apps may access photos stored on your device when you choose to upload them in posts or comments. This may include related photo details, such as metadata.
Push Notifications. If enabled, the app can send alerts or updates about your account activity and new content. You can manage or disable notifications in your settings at any time.
If you choose not to authorize the above permissions, some of the functionality on the Site or Apps may be affected. 
""",
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Personal information from other sources, including:",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    buildTable(
                      rows: [
                        buildTableHeader(
                          title1: "Category",
                          title2: "Description",
                        ),
                        buildTableText(
                          title1:
                              "Vetted Dating Advice affiliates and subsidiaries ",
                          title2:
                              "We may obtain information about you, such as basic customer information, transaction information and product usage information from our affiliates or subsidiaries as a normal part of operations.",
                        ),
                        buildTableText(
                          title1: "Analytics providers",
                          title2:
                              "Information about your usage and interactions when using the Site and Services (including information prior to account creation, in some cases).",
                        ),
                        buildTableText(
                          title1: "Identity screenings",
                          title2:
                              "Vetted Dating Advice may utilize third-party services to collect and store your name, domicile, government identification numbers, date of birth, and any other information or documentation you provide in connection with verifying your identity and compliance",
                        ),
                        buildTableText(
                          title1: "Marketing and advertising partners",
                          title2:
                              "Information related to advertising and marketing efforts, including in some instances what marketing content you viewed or the actions you take on our Site, Apps or Services.",
                        ),
                        buildTableText(
                          title1: "Third-Party Data ",
                          title2:
                              "To provide the Site, Apps and Services, we may use vendors, partners, integrations, features and other tools that provide Personal Information and public information about you derived from background checks, image searches, phone number lookups, criminal record searches, marriage history, and court searches. ",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.05),
          ],
        ),
      ),
    );
  }

  Table buildTable({required List<TableRow> rows}) {
    return Table(
      columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
      border: TableBorder.all(
        color: Colors.black,
        width: 1,
        borderRadius: BorderRadius.circular(8),
      ),
      children: rows,
    );
  }

  TableRow buildTableText({required String title1, required String title2}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title1,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title2,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  TableRow buildTableHeader({required String title1, required String title2}) {
    return TableRow(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title1,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title2,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
        'Privacy Policy',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }
}
