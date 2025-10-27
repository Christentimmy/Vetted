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
                    SizedBox(height: 5),
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
                    SizedBox(height: 5),
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
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(radius: 5, backgroundColor: Colors.black),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            "Third-party services have their own privacy policies that govern how your information is collected, used and shared. See Section 5 for additional information regarding third parties.",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Publicly available information, including:",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    buildTable(
                      rows: [
                        buildTableHeader(
                          title1: "Category",
                          title2: "Description",
                        ),
                        buildTableText(
                          title1: "Background Check Information",
                          title2:
                              "Verification of identity, employment and education history, criminal records, and other information regularly contained in background checks. ",
                        ),
                        buildTableText(
                          title1: "Image Searches",
                          title2:
                              "Where those images appear online, the identifies and information associated with those images, and other information corresponding to images appearing online. ",
                        ),
                        buildTableText(
                          title1: "Phone Number Lookups",
                          title2:
                              "Phone numbers, associated names, contact details, and related publicly available information",
                        ),
                        buildTableText(
                          title1: "Marriage Records",
                          title2:
                              "Publicly available marriage records including names of spouses, divorces, dates, locations, filings, and history. ",
                        ),
                        buildTableText(
                          title1: "Court Searches",
                          title2:
                              "Public court records including filings, claims, parties, case outcomes, and related information. ",
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "How We Use Data",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    buildBullet(
                      text:
                          "To provide, operate, maintain, customize, develop, personalize, expand and improve our Site, Apps, and Services including the features, software and technologies therein.",
                    ),
                    buildBullet(
                      text: "To verify your account and information.",
                    ),
                    buildBullet(
                      text:
                          "To comply with any applicable laws and regulations. ",
                    ),
                    buildBullet(
                      text:
                          "To ensure compliance with our Terms and Conditions (www.vetteddatingadvice.com/terms).",
                    ),
                    buildBullet(
                      text:
                          "To provide customer support and respond to inquiries, surveys and feedback.",
                    ),
                    buildBullet(
                      text:
                          "To promote the safety, security and integrity of the Site, Apps and Services, to investigate suspicious activity, to protect the Site and Services, to debug any issues, and to investigate any violations of law or violations of the rights of Vetted Dating Advice or others.",
                    ),
                    buildBullet(
                      text:
                          "To determine your legal eligibility to use certain products or features.",
                    ),
                    buildBullet(
                      text:
                          "For our legitimate interests including but not limited to personalizing the Site, Apps and Services, engaging in advertising, research and development, and other lawful purposes. ",
                    ),
                    buildBullet(
                      text:
                          "To provide communications, updates, notices or other information related to the Site, Apps and Services.",
                    ),
                    buildBullet(
                      text:
                          "To monitor and analyze trends, usage and activities in connection with the Site, Apps and Services",
                    ),
                    buildBullet(
                      text:
                          "To aggregate and/or de-identify data for research, reports, analytics or other summaries.",
                    ),
                    buildBullet(
                      text:
                          "To enable our vendors and contractors to assist us and provide services.",
                    ),
                    buildBullet(
                      text:
                          "To carry out any other purpose described to you at the time the information was collected, or as you otherwise consent to at the time of collection.",
                    ),
                    SizedBox(height: 20),
                    Text(
                      "How We Share Data",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    buildBullet(
                      text:
                          "To our vendors and third-party service providers, identity and information providers, analytics providers, hosting providers, agents, affiliates, subsidiaries and partners to assist in providing, delivering, maintaining, and improving the Site, Apps and Services",
                    ),
                    buildBullet(
                      text:
                          "To comply with our legal obligations such as compliance requirements, or when compelled by litigation, regulatory proceedings, subpoena, court order or other legal proceeding. ",
                    ),
                    buildBullet(
                      text:
                          "To prevent harm to users, Vetted Dating Advice, the Site, Apps and Services, and to detect fraud, perform audits, and to enforce our agreement and policies, including our Terms and Conditions (www.vetteddatingadvice.com/terms).",
                    ),
                    buildBullet(
                      text:
                          "To protect against, investigate, and stop fraudulent, unauthorized or illegal activity, and to address security risks, software bugs and anything else that could harm Vetted Dating Advice, the Site or Services.",
                    ),
                    buildBullet(
                      text:
                          "We may transfer or share your data to another entity in the event of a merger, acquisition, bankruptcy, dissolution, reorganization, asset or stock sale, or other business change transaction.",
                    ),
                    buildBullet(
                      text:
                          "For legitimate purposes, while maintaining the privacy of the data, including to our lawyers or other professional advisors, or as otherwise needed to protect and manage our legitimate interests. ",
                    ),
                    buildBullet(
                      text:
                          "Consistent with any consent you provide us from time to time. ",
                    ),
                    buildBullet(
                      text:
                          "We may also share aggregate or de-identified information that cannot reasonably be linked to you or used to identify you, but only in accordance with applicable law. ",
                    ),
                    Text(
                      """ 
                      Cookies

Like many other websites, we use cookies and other tracking technologies (such as pixels, APIs, tags, web beacons and other software) (collectively, "Cookies"). Cookies are small files of information that are stored by your web browser software on your computer hard drive, mobile or other devices (e.g., smartphones or tablets). These technologies are used by most website and app providers to let users navigate between pages efficiently, ensure security of the webpage or application, understand how their websites are used, remember user preferences and generally improve the user experience. 
More information on cookies and their use can be found at www.aboutcookies.org or www.allaboutcookies.org. 
You have the right to accept or reject Cookies (except Cookies for necessary purposes). 
You can view Cookies, manage your Cookie settings and withdraw consent at any time directly [by visiting the footer and clicking Cookie Preferences]. 
We use Cookies for the following purposes:
Necessary purposes – Necessary Cookies are required to enable the basic features of this site, such as providing secure log-in or adjusting your consent preferences. These Cookies do not store any personally identifiable data. Necessary Cookies are essential for our Site, Apps and Services to function and therefore cannot be switched off. They are usually only set in response to actions made by you on the Site or Services. These also include Cookies we may rely on for security purposes, such as to prevent unauthorized access. You can set your browser to block or alert you about these Cookies at any time, but that may cause some features of our Site or Services to not work.
Functional purposes - Functional Cookies help perform certain functionalities like sharing the content of the website on social media platforms, collecting feedback, and other third-party features. Functional Cookies enable remembering the choices you make and to tailor our Site and Services to your preferences.
Analytics purposes - Analytical Cookies are used to understand how visitors interact with the Site and Services. These Cookies help provide information on metrics such as the number of visitors, bounce rate, traffic source, and other use and performance information. Analytics Cookies count visits and traffic sources so we can measure and improve the performance of our Services. They help us to know which pages are the most and least popular and see how visitors move around, and may help resolve any errors or issues that occur on the Site or Services.
Performance purposes - Performance Cookies are used to understand and analyze the performance of the Site and Services which helps in delivering a better user experience for the visitors.
Advertisement purposes - Advertisement Cookies are used to provide visitors with customized advertisements based on the pages you visited previously and to analyze the effectiveness of the ad campaigns.
Other purposes – Other Cookies may be utilized from time to time for various other purposes related to Vetted Dating Advice and the Site, Apps and Services. 
We may use Cookies and similar technologies third-party vendors provide to collect additional information. This information enables us to provide the Site, Apps and Services, to monitor and improve the user experience, to enhance and personalize your experience, and to track certain activity. We encourage you to consult the cookie settings and privacy policies of any third-party partners whose cookies may be in use.
The length of time a Cookie will stay on your browsing device depends on whether it is a "persistent" or "session" cookie. Session Cookies will only stay on your device until you close your browser. Persistent Cookies are set to automatically expire after a defined duration (for example, a few days, weeks or months). 
The way we use Cookies may change from time to time to reflect, for example, changes to the Cookies we use or for other operational, legal or regulatory reasons. You should revisit this page and utilize our Cookie preferences feature to keep yourself updated.
If you choose to disable cookies, some features of our Site, Apps or Services may not function properly.

Third-Party Providers

We may integrate technologies or features operated or controlled by other parties into parts of the Site, Apps or Services (“Third-Party Services”). For example, the Site, Apps or Services may include features or links that hyperlink to websites, platforms, and other services not operated or controlled by us. Please note that when you interact with Third-Party Services, including when you leave the Site, Apps or Services, those parties may independently collect, use and share information about you. Your use of Third-Party Services are subject to such third-party’s own terms and privacy policies which govern your use of those services, products or features, which you should review and accept, and if you do not accept such third-party terms or privacy policies you should not use such Third-Party Services.

Data Retention

We retain data as needed to provide our Site and Services, to comply with legal obligations, and to protect our legitimate interests. While retention requirements vary by location and type of data, we maintain internal retention policies on the basis of how information needs to be used. This includes considerations such as when the information was collected or created, whether it is necessary in order to continue offering you our Site, Apps and Services, whether we are required to hold the information to comply with our legal obligations, and other information preservation requirements and considerations. We also keep certain information where necessary to protect the safety, security and integrity of our Site, Apps and Services. Data collected by Third-Party Services are subject to their own data retention policies. Subject to this Section 6, we delete information that is no longer needed, or when you exercise a lawful request for deletion of your data. When deleting data, we may retain limited backup copies for a reasonable period as permitted by law or for legitimate business purposes.

You can delete your account via the Vetted App settings or by contacting us. Uninstalling the Vetted App will not delete your account or previously collected personal information. You can update your information (e.g., name, email) through your account settings or by contacting us. You may also manage app permissions (e.g., camera, microphone, push notifications) via your device settings, but disabling certain permissions may limit app functionality.

Security & Additional Information

We implement and maintain appropriate administrative, physical, and technical security safeguards to help protect data from loss, theft, misuse, unauthorized access, disclosure, alteration, and destruction. Nevertheless, transmission via the internet is not completely secure and we cannot guarantee, ensure or warrant the security of any information or data. You are responsible for all of your activity on the Site, Apps and Services, including but not limited to your account and login information. We accept no liability for any information or data transmitted via the internet. 

We may remove content, terminate and ban offending accounts, and, where appropriate, report users or information to relevant authorities. Our Site, Apps and Services are intended for users 18 and older. We moderate user content through a combination of automated tools and human review, and provide in-app reporting tools for inappropriate behavior or content.

Children’s Privacy

The Site, Apps and Services are not directed to persons under the age of 18, and we do not knowingly request or collect any information about persons under the age of 18. If you are under the age of 18, please do not provide any personal information or data through the Site, Apps or Services. If a user submitting personal information is suspected of being younger than 18 years of age, we will require the relevant user to stop, and will take steps to delete that individual’s information as soon as possible. If you are a parent or guardian of a person under the age of 18, and you become aware they have provided personal information or data to us, please contact us at [support@vetteddatingadvice.com] and you may request to exercise your applicable access, rectification, cancellation, and/or objection rights.

User Privacy Rights
As a user of our Services, you may have certain rights regarding your personal information via state or other laws. We comply with applicable state privacy laws, but some may not be applicable due to our size and scope. Nonetheless, we are committed to transparency and user control, and you may:
Access Your Information: Request details about the personal information we collect, use, or store about you.
Correct or Update: Request corrections or updates to your personal information to ensure its accuracy.
Delete Your Information: Request the deletion of your personal information, subject to certain legal or operational limitations.
Opt-Out of Marketing: Unsubscribe from marketing communications at any time by following the instructions in our emails or contacting us directly.
To exercise these rights, please contact us at [support@vetteddatingadvice.com]. We will respond to your request promptly and in accordance with applicable laws.
California's "Shine the Light" law permits California residents to request certain information regarding our disclosure of personal information to third parties for their own direct marketing purposes. However, we do not disclose personal information to third parties for their own direct marketing purposes. If you are a California resident, you may request information about our compliance with the Shine the Light law by contacting us at [support@vetteddatingadvice.com]. Any such request must include "California Shine the Light Request" in the first line of the description and include your name, street address, city, state, and ZIP code. Please note that we are only required to respond to one request per customer each calendar year.
‍We may transfer personal information to countries other than the country in which the data was originally collected. These countries may not have the same data protection laws as the country in which you initially provided the personal information. When we transfer your personal information to other countries, we will protect that information as described in this Privacy Policy.
Contact us

If you have questions or concerns regarding this Privacy Policy, or if you want to exercise any of the rights mentioned herein, please contact us by email at [support@vetteddatingadvice.com] or by mail to:
ZenBusiness Inc.
221 West Lake Lansing Road Suite 200
East Lansing, MI 48823
                    """,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
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

  Widget buildBullet({required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: CircleAvatar(radius: 3, backgroundColor: Colors.black),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
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
