import 'package:Vetted/app/controller/app_service_controller.dart';
import 'package:Vetted/app/data/models/search_image_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class ReverseImageScreen extends StatefulWidget {
  const ReverseImageScreen({super.key});

  @override
  State<ReverseImageScreen> createState() => _ReverseImageScreenState();
}

class _ReverseImageScreenState extends State<ReverseImageScreen> {
  final appServiceController = Get.find<AppServiceController>();

  @override
  void dispose() {
    appServiceController.images.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Obx(() {
          if (appServiceController.isloadingImage.value) {
            return buildLoader();
          }
          if (appServiceController.images.isEmpty) {
            return const Center(child: Text("No data found"));
          }
          return GridView.builder(
            itemCount: appServiceController.images.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              final image = appServiceController.images[index];
              return _MatchTile(searchImage: image);
            },
          );
        }),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Reverse Image Search"),
      centerTitle: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 1,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  GridView buildLoader() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}

class _MatchTile extends StatelessWidget {
  final SearchImage searchImage;

  const _MatchTile({required this.searchImage});

  Future<void> urlLauncher(String url) async {
    final Uri uri = Uri.parse(url);

    // Encode query parameters to avoid issues with '?' or special characters
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

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Image.network(searchImage.imageUrl ?? ""),
                  );
                },
              );
            },
            child: Image.network(
              searchImage.imageUrl ?? "",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
            ),
          ),
          InkWell(
            onTap: () async {
              await urlLauncher(searchImage.imageUrl ?? "");
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              color: Colors.white,
              child: Text(
                searchImage.source ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
