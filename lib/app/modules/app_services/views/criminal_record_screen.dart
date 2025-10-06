import 'package:Vetted/app/data/models/criminal_record_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CriminalRecordScreen extends StatelessWidget {
  final CriminalRecordModel criminal;
  const CriminalRecordScreen({super.key, required this.criminal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: buildAppBar(),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔴 Name tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                criminal.name ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 🖼️ Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                criminal.image ?? "",
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            _infoBox("Offense:", criminal.offense ?? ""),

            const SizedBox(height: 24),
            Text(
              "Offender Attributes",
              style: GoogleFonts.fredoka(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            _infoBox("Date of Birth:", criminal.offenderAttributes?.dob ?? ""),
            _infoBox("Hair:", criminal.offenderAttributes?.hair ?? ""),
            _infoBox("Eye:", criminal.offenderAttributes?.eye ?? ""),
            _infoBox("Height:", criminal.offenderAttributes?.height ?? ""),
            _infoBox("Weight:", criminal.offenderAttributes?.weight ?? ""),
            _infoBox("Race:", criminal.offenderAttributes?.race ?? ""),
            _infoBox("Sex:", criminal.offenderAttributes?.sex ?? ""),
            _infoBox("Skin Tone:", criminal.offenderAttributes?.skinTone ?? ""),
            _infoBox(
              "Military Service:",
              criminal.offenderAttributes?.militaryService ?? "",
            ),
            _infoBox(
              "Scars Marks:",
              criminal.offenderAttributes?.scarsMarks ?? "",
            ),

            const SizedBox(height: 24),
            Text(
              "Case Details",
              style: GoogleFonts.fredoka(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            _infoBox("Case Number:", criminal.caseDetails?.caseNumber ?? ""),
            _infoBox("Raw Category:", criminal.caseDetails?.rawCategory ?? ""),
            _infoBox("Court County:", criminal.caseDetails?.courtCounty ?? ""),
            _infoBox("Fees:", criminal.caseDetails?.fees ?? ""),
            _infoBox("Fines:", criminal.caseDetails?.fines ?? ""),
            _infoBox("Case Date:", criminal.caseDetails?.caseDate ?? ""),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text("Criminal Record"),
      centerTitle: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 1,
    );
  }

  Widget _infoBox(String label, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(width: 6),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}
