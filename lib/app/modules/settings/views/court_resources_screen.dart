import 'package:Vetted/app/resources/colors.dart';
// import 'package:Vetted/app/utils/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CourtResourcesScreen extends StatelessWidget {
  const CourtResourcesScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('US State Court Resources'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primaryColor,
        elevation: 2,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: StateCourtData.states.length,
        itemBuilder: (context, index) {
          final state = StateCourtData.states[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                child: Text(
                  state.abbreviation,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                state.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                'Tap to access ${state.name} court resources',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              onTap: () async {
                try {
                  await urlLauncher(state.courtWebsite);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Could not launch ${state.name} court website',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class StateInfo {
  final String name;
  final String abbreviation;
  final String courtWebsite;

  const StateInfo({
    required this.name,
    required this.abbreviation,
    required this.courtWebsite,
  });
}

class StateCourtData {
  static const List<StateInfo> states = [
    StateInfo(
      name: 'Alabama',
      abbreviation: 'AL',
      courtWebsite: 'https://www.alacourt.gov/',
    ),
    StateInfo(
      name: 'Alaska',
      abbreviation: 'AK',
      courtWebsite: 'https://www.courts.alaska.gov/',
    ),
    StateInfo(
      name: 'Arizona',
      abbreviation: 'AZ',
      courtWebsite: 'https://www.azcourts.gov/',
    ),
    StateInfo(
      name: 'Arkansas',
      abbreviation: 'AR',
      courtWebsite: 'https://www.arcourts.gov/',
    ),
    StateInfo(
      name: 'California',
      abbreviation: 'CA',
      courtWebsite: 'https://www.courts.ca.gov/',
    ),
    StateInfo(
      name: 'Colorado',
      abbreviation: 'CO',
      courtWebsite: 'https://www.courts.state.co.us/',
    ),
    StateInfo(
      name: 'Connecticut',
      abbreviation: 'CT',
      courtWebsite: 'https://jud.ct.gov/',
    ),
    StateInfo(
      name: 'Delaware',
      abbreviation: 'DE',
      courtWebsite: 'https://courts.delaware.gov/',
    ),
    StateInfo(
      name: 'Florida',
      abbreviation: 'FL',
      courtWebsite: 'https://www.flcourts.gov/',
    ),
    StateInfo(
      name: 'Georgia',
      abbreviation: 'GA',
      courtWebsite: 'https://www.georgiacourts.gov/',
    ),
    StateInfo(
      name: 'Hawaii',
      abbreviation: 'HI',
      courtWebsite: 'https://www.courts.state.hi.us/',
    ),
    StateInfo(
      name: 'Idaho',
      abbreviation: 'ID',
      courtWebsite: 'https://isc.idaho.gov/',
    ),
    StateInfo(
      name: 'Illinois',
      abbreviation: 'IL',
      courtWebsite: 'https://www.illinoiscourts.gov/',
    ),
    StateInfo(
      name: 'Indiana',
      abbreviation: 'IN',
      courtWebsite: 'https://www.in.gov/courts/',
    ),
    StateInfo(
      name: 'Iowa',
      abbreviation: 'IA',
      courtWebsite: 'https://www.iowacourts.gov/',
    ),
    StateInfo(
      name: 'Kansas',
      abbreviation: 'KS',
      courtWebsite: 'https://www.kscourts.org/',
    ),
    StateInfo(
      name: 'Kentucky',
      abbreviation: 'KY',
      courtWebsite: 'https://kycourts.gov/',
    ),
    StateInfo(
      name: 'Louisiana',
      abbreviation: 'LA',
      courtWebsite: 'https://www.lasc.org/',
    ),
    StateInfo(
      name: 'Maine',
      abbreviation: 'ME',
      courtWebsite: 'https://www.courts.maine.gov/',
    ),
    StateInfo(
      name: 'Maryland',
      abbreviation: 'MD',
      courtWebsite: 'https://www.mdcourts.gov/',
    ),
    StateInfo(
      name: 'Massachusetts',
      abbreviation: 'MA',
      courtWebsite: 'https://www.mass.gov/orgs/massachusetts-court-system',
    ),
    StateInfo(
      name: 'Michigan',
      abbreviation: 'MI',
      courtWebsite: 'https://www.courts.michigan.gov/',
    ),
    StateInfo(
      name: 'Minnesota',
      abbreviation: 'MN',
      courtWebsite: 'https://www.mncourts.gov/',
    ),
    StateInfo(
      name: 'Mississippi',
      abbreviation: 'MS',
      courtWebsite: 'https://courts.ms.gov/',
    ),
    StateInfo(
      name: 'Missouri',
      abbreviation: 'MO',
      courtWebsite: 'https://www.courts.mo.gov/',
    ),
    StateInfo(
      name: 'Montana',
      abbreviation: 'MT',
      courtWebsite: 'https://courts.mt.gov/',
    ),
    StateInfo(
      name: 'Nebraska',
      abbreviation: 'NE',
      courtWebsite: 'https://supremecourt.nebraska.gov/',
    ),
    StateInfo(
      name: 'Nevada',
      abbreviation: 'NV',
      courtWebsite: 'https://nvcourts.gov/',
    ),
    StateInfo(
      name: 'New Hampshire',
      abbreviation: 'NH',
      courtWebsite: 'https://www.courts.state.nh.us/',
    ),
    StateInfo(
      name: 'New Jersey',
      abbreviation: 'NJ',
      courtWebsite: 'https://www.njcourts.gov/',
    ),
    StateInfo(
      name: 'New Mexico',
      abbreviation: 'NM',
      courtWebsite: 'https://www.nmcourts.gov/',
    ),
    StateInfo(
      name: 'New York',
      abbreviation: 'NY',
      courtWebsite: 'https://www.nycourts.gov/',
    ),
    StateInfo(
      name: 'North Carolina',
      abbreviation: 'NC',
      courtWebsite: 'https://www.nccourts.gov/',
    ),
    StateInfo(
      name: 'North Dakota',
      abbreviation: 'ND',
      courtWebsite: 'https://www.ndcourts.gov/',
    ),
    StateInfo(
      name: 'Ohio',
      abbreviation: 'OH',
      courtWebsite: 'https://www.supremecourt.ohio.gov/',
    ),
    StateInfo(
      name: 'Oklahoma',
      abbreviation: 'OK',
      courtWebsite: 'https://www.oscn.net/',
    ),
    StateInfo(
      name: 'Oregon',
      abbreviation: 'OR',
      courtWebsite: 'https://www.courts.oregon.gov/',
    ),
    StateInfo(
      name: 'Pennsylvania',
      abbreviation: 'PA',
      courtWebsite: 'https://www.pacourts.us/',
    ),
    StateInfo(
      name: 'Rhode Island',
      abbreviation: 'RI',
      courtWebsite: 'https://www.courts.ri.gov/',
    ),
    StateInfo(
      name: 'South Carolina',
      abbreviation: 'SC',
      courtWebsite: 'https://www.sccourts.org/',
    ),
    StateInfo(
      name: 'South Dakota',
      abbreviation: 'SD',
      courtWebsite: 'https://ujs.sd.gov/',
    ),
    StateInfo(
      name: 'Tennessee',
      abbreviation: 'TN',
      courtWebsite: 'https://www.tncourts.gov/',
    ),
    StateInfo(
      name: 'Texas',
      abbreviation: 'TX',
      courtWebsite: 'https://www.txcourts.gov/',
    ),
    StateInfo(
      name: 'Utah',
      abbreviation: 'UT',
      courtWebsite: 'https://www.utcourts.gov/',
    ),
    StateInfo(
      name: 'Vermont',
      abbreviation: 'VT',
      courtWebsite: 'https://www.vermontjudiciary.org/',
    ),
    StateInfo(
      name: 'Virginia',
      abbreviation: 'VA',
      courtWebsite: 'https://www.vacourts.gov/',
    ),
    StateInfo(
      name: 'Washington',
      abbreviation: 'WA',
      courtWebsite: 'https://www.courts.wa.gov/',
    ),
    StateInfo(
      name: 'West Virginia',
      abbreviation: 'WV',
      courtWebsite: 'https://www.courtswv.gov/',
    ),
    StateInfo(
      name: 'Wisconsin',
      abbreviation: 'WI',
      courtWebsite: 'https://www.wicourts.gov/',
    ),
    StateInfo(
      name: 'Wyoming',
      abbreviation: 'WY',
      courtWebsite: 'https://www.courts.state.wy.us/',
    ),
  ];
}
