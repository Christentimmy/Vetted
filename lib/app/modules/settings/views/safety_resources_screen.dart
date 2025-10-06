import 'package:Vetted/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SafetyResourcesScreen extends StatelessWidget {
  const SafetyResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resources = [
      "National Domestic Violence Hotline",
      "Crisis Textline",
      "Noonlight app",
      "Crime Victim Resource Center",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Safety Resources"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children:
              resources.map((resource) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(resource),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async {
                      if (resource == "National Domestic Violence Hotline") {
                        await urlLauncher("https://www.nationaldomesticviolencehotline.org/");
                      }
                      if (resource == "Crisis Textline") {
                        await urlLauncher("https://www.crisistextline.org/");
                      }
                      if (resource == "Noonlight app") {
                        await urlLauncher("https://www.noonlight.com/");
                      }
                      if (resource == "Crime Victim Resource Center") {
                        Get.toNamed(AppRoutes.courtStateResources);
                      }
                    },
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }

  Future<void> urlLauncher(String url) async {
    final Uri uri = Uri.parse(url);

    final Uri encodedUri = Uri(
      scheme: uri.scheme,
      host: uri.host,
      path: uri.path,
      query: uri.query,
    );

    try {
      await launchUrl(encodedUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
