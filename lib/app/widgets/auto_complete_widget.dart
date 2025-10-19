import 'package:Vetted/app/controller/auto_complete_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

ListTile buildListTile({required String title, required VoidCallback? onTap}) {
  return ListTile(
    onTap: onTap,
    contentPadding: EdgeInsets.symmetric(vertical: 4),
    minTileHeight: 45,
    title: Text(
      title,
      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
    ),
  );
}

class AutoCompleteList extends StatelessWidget {
  final AutoCompleteController autoCompleteController;
  final Function(dynamic item)? onTap;
  const AutoCompleteList({
    super.key,
    this.onTap,
    required this.autoCompleteController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: autoCompleteController.places.length,
        itemBuilder: (context, index) {
          final item = autoCompleteController.places[index];
          return buildListTile(
            title: item["name"],
            onTap: () {
              if (onTap != null) {
                onTap!(item);
              }
            },
          );
        },
      ),
    );
  }
}
