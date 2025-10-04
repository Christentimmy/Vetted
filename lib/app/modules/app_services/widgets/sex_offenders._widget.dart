import 'package:Vetted/app/data/models/sex_offender_model.dart';
import 'package:Vetted/app/modules/app_services/controller/offenders_map_controller.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class BuildOffenderCard extends StatelessWidget {
  final OffendersMapController controller;
  final OffenderModel offender;

  const BuildOffenderCard({
    super.key,
    required this.controller,
    required this.offender,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedPositioned(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        bottom: controller.cardOffset.value,
        left: 0,
        right: 0,
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            controller.cardOffset.value -= details.delta.dy;
            if (controller.cardOffset.value < 0) {
              controller.cardOffset.value = 0;
            }
          },
          onVerticalDragEnd: (details) {
            if (controller.cardOffset.value > controller.dismissThreshold) {
              controller.sexOffender.value = null;
              controller.cardOffset.value = 0;
            } else {
              controller.cardOffset.value = 0;
            }
          },
          child: buildCardContent(),
        ),
      );
    });
  }

  Container buildCardContent() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              buildImageCard(),
              const SizedBox(width: 16),
              buildNameAndAddress(),
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: Get.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Charges",
                  style: GoogleFonts.fredoka(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.primaryColor,
                  ),
                ),
                Text(
                  offender.sexOffenderCharges,
                  style: GoogleFonts.fredoka(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Aliases",
                  style: GoogleFonts.fredoka(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.primaryColor,
                  ),
                ),
                Text(
                  offender.sexOffenderAliases,
                  style: GoogleFonts.fredoka(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildNameAndAddress() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            offender.sexOffenderName,
            style: GoogleFonts.fredoka(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            offender.sexOffenderAddressLine1.isEmpty
                ? offender.sexOffenderAddressLine2
                : offender.sexOffenderAddressLine1,
            style: GoogleFonts.fredoka(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  InkWell buildImageCard() {
    return InkWell(
      onTap: displayImageFullScreen,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: offender.sexOffenderImageUrl,
          height: Get.height * 0.085,
          width: Get.width * 0.22,
          fit: BoxFit.cover,
          placeholder: (context, url) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: Get.height * 0.085,
                width: Get.width * 0.22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> displayImageFullScreen() {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: offender.sexOffenderImageUrl,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
