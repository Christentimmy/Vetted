import 'package:Vetted/app/controller/auth_controller.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionScreen extends StatelessWidget {
  final bool? justAScreen;
  TermsAndConditionScreen({super.key, this.justAScreen});

  final RxBool isChecked = false.obs;
  final authController = Get.find<AuthController>();

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
                child: Text(
                  """ Vetted Dating Advice Terms of Service
Date last updated: [October 18, 2025]
Version: 1.0

These Terms of Service (this “Agreement”) are a binding legal contract between “you” and Vetted Dating Advice, LLC a [Michigan limited liability company], (“Vetted Dating Advice,” “we,” “us” and “our”). This Agreement governs your access and use of [https://vetteddatingadvice.com/] (the “Site”), our mobile applications, Vetted Dating Advice (the “Apps”), and all related websites, software, technologies, data, features, and other products or services provided by us or our affiliates or subsidiaries (collectively, the “Services”). We provide an online platform for men to support each other and navigate the dating world.

BY USING THE SITE, APPS OR SERVICES, YOU KNOWINGLY, VOLUNTARILY, IRREVOCABLY AND UNCONDITIONALLY WAIVE ANY RIGHT YOU MAY HAVE TO:
A TRIAL BY JURY IN ANY LEGAL PROCEEDING DIRECTLY OR INDIRECTLY ARISING OUT OF OR RELATING TO THE SERVICES OR THIS AGREEMENT; AND
PARTICIPATE AS A PLAINTIFF, CLASS MEMBER OR REPRESENTATIVE IN ANY CLASS ACTION LAWSUIT, CLASS-WIDE ARBITRATION, PRIVATE ATTORNEY-GENERAL ACTION, OR ANY OTHER REPRESENTATIVE PROCEEDING AGAINST US OR OUR AFFILIATES OR SUBSIDIARIES.
See Section (11) for additional information regarding arbitration and class action waiver.

Acceptance of Terms

By accessing or using the Site, Apps or Services in any way, or by expressly accepting this Agreement, you agree that you have read, understand, and accept all terms and conditions contained in this Agreement, including our “Privacy Policy” which is available at [https://vetteddatingadvice.com/] and which is hereby incorporated by reference. This Agreement constitutes a legally binding contract between you and Vetted Dating Advice. You may have to agree to additional terms and conditions to use certain features of the Services as provided from time to time.

We may amend or modify this Agreement and our Privacy Policy at any time by posting the revised version on the Site, Apps and/or Services and/or by providing a copy to you (a “Revised Agreement”). The Revised Agreement shall be effective as of the time it is posted. Your continued use of the Site, Apps or Services after the posting of a Revised Agreement constitutes your acceptance of such Revised Agreement.

If you do not agree with this Agreement or any Revised Agreement, please do not use the Site, Apps or Services. 

Privacy Policy & Cookies
Our Privacy Policy, accessible at [https://vetteddatingadvice.com/], details how Vetted Dating Advice collects, uses, stores, and shares your personal information to deliver our Services. By accessing or using the Site, Apps, or Services, you consent to the practices outlined in the Privacy Policy, which is incorporated into this Agreement. We use cookies and similar technologies (e.g., pixels, web beacons) to enhance your experience, analyze usage, and personalize content. You may manage cookie preferences through your browser settings, though disabling them may affect functionality. For more details, visit www.allaboutcookies.org.
Limited License & Accounts
Subject to the terms of this Agreement, we grant you a limited, personal, non-exclusive, revocable, non-assignable, and non-transferable right and license to use the Site, Apps and Services solely for lawful purposes, in accordance with this Agreement, and in accordance with the Service’s intended use.
We reserve all rights not expressly granted to you by this Agreement. We reserve the right to suspend, terminate or limit this license or your access to the Site, Apps or Services without notice for any reason in our sole discretion. You agree that this license does not give you any ownership of, or intellectual property rights in, the Site, Apps, Services, or any Content therein. 
To access certain features of the Services, you must create an account (“Account”) by providing accurate details, including your [name, relationship status, email address, username, city and state, birth date, and a photo]. You must be at least 18 years old to register. We may reject any registration information at our discretion. You agree to: (i) choose a unique, non-offensive username and email not used by others; (ii) avoid impersonating anyone or infringing others’ rights; (iii) provide truthful, current information; (iv) safeguard your Account credentials; (v) notify us promptly at [vetteddatingadvice@gmail.com] of any unauthorized access; and (vi) refrain from transferring or selling your Account. You are responsible for all activities under your Account, and we may suspend or terminate it if you violate this Agreement or applicable laws.
You are solely responsible for maintaining the confidentiality and security of your Account information. You will remain responsible for all activity emanating from your Account, whether or not such activity was authorized by you. We reserve the right to disallow, cancel, remove, or reassign certain usernames in appropriate circumstances, as determined by us in our sole discretion, and may, with or without prior notice, suspend, terminate, and delete your Account if activities occur on that Account which, in our sole discretion, would or might constitute a violation of these Terms or an infringement or violation of the rights of any third party, or of any applicable laws or regulations.
We may modify or discontinue the Site, Apps or Services at our sole discretion without liability.

Subscriptions
Vetted Dating Advice offers premium features (“Subscription Services”) for a recurring fee (“Subscription Fee”) through the Site, Apps, or third-party platforms like the Apple App Store or Google Play Store (“Third-Party Platforms”). The Subscription Fee, billing cycle, and terms will be displayed during purchase. By subscribing, you authorize us or the Third-Party Platform to charge the Subscription Fee, plus applicable taxes, to your payment method at the start of each Subscription Period. Subscriptions auto-renew until canceled, and all payments are non-refundable, subject to applicable law. You are responsible for fees charged to your Third-Party Platform account.
Subscriptions via Third-Party Platforms are subject to their terms. Payments are processed using your provided payment information. If payment fails (e.g., due to insufficient funds), we may suspend or terminate your access and pursue collection as permitted by law. You release Vetted Dating Advice from liability for unauthorized charges outside our control.
We may modify Subscription Fees or terms, effective at the start of your next Subscription Period. We will notify you of material changes (e.g., price increases) at least 30 days in advance. You may cancel before changes take effect via the Site or Third-Party Platform. Continued use after changes constitutes acceptance.
To cancel, manage your subscription through the relevant platform:
Apple App Store: Go to Settings > Apple ID > Subscriptions, select Vetted Dating Advice, and cancel.
Google Play Store: Open Google Play > Account > Payments & Subscriptions > Subscriptions, select Vetted Dating Advice, and cancel.
Cancellation takes effect at the end of the current Subscription Period. To delete your Account, email [vetteddatingadvice@gmail.com] with your account identifier.


Prohibitions

The above license is conditional upon your strict compliance with this Agreement and any applicable federal, state, international, or local laws and regulations. Additionally, you agree not to:

Post or transmit any material on or through the Site, Apps or Services that is or could be offensive, fraudulent, harmful, unlawful, deceptive, threatening, harassing, disingenuous, libelous, defamatory, obscene, scandalous, vulgar, hateful, discriminatory, inflammatory, pornographic or profane, or any material that could constitute or encourage conduct that would be considered a criminal offense, give rise to civil liability, or otherwise violate any applicable law;
Use any copying, downloading, recording, screenshotting, scraping or any other techniques to aggregate, reproduce, duplicate, copy, repurpose, transmit, distribute, sell, license, modify, publish, create derivative works from, or republish the Site, Apps, Services and Content, in whole or in part;
Commit or engage in, or encourage, induce, solicit or promote, any conduct that would constitute a criminal offense, give rise to civil liability or otherwise violate any law or regulation; 
Impersonate any person or entity or otherwise misrepresent your affiliation with a person or entity, for example, by registering an account in the name of another person or company or sending messages or making comments using the name of another person. You agree to comply with the above conditions and acknowledge and agree that we have the right, in our sole discretion, to terminate your Account or take such other action such as deleting any Content as we see fit if you breach any of the conditions or terms of this Agreement. This may include taking court action and/or reporting offending users to the relevant authorities.
Access or use the Site, Apps or Services if you are: (i) the subject of sanctions administered or enforced by any country or government or otherwise designated on any list of prohibited or restricted parties (including but not limited to the lists maintained by the United Nations Security Council, the U.S. Government (including but not limited to the Office of Foreign Assets Control), the European Union or its Member States, or other applicable government authority), (ii) a citizen or organized or resident in a country or territory that is the subject of country-wide or territory-wide sanctions (including but not limited to Cuba, the Democratic People’s Republic of Korea, the Crimea, Donetsk, and Luhansk regions, Russian Federation, Republic of Belarus, Iran or Syria); or (iii) you are barred from participating under any applicable laws, statutes, ordinances, rules, regulations, judgments, injunctions, orders, decrees or other law. You may not use the Services in violation of U.S. export control laws;
Use a virtual private network (VPN) or other tool to circumvent any geo block or other restrictions that we may have implemented;
Disrupt or initiate any attacks against the Site, Apps, Services, data or users;
Disrupt or initiate any attacks or actions that violate a cloud service, data-center, node or other third-party’s rules or policies;
Violate any contract, intellectual property rights, or any other rights of a third party, including but not limited to Vetted Dating Advice;
Use any automated systems, bots, spiders, or intelligent AI or agent software (or similar technologies) for any purposes inconsistent with this Agreement;
Use the Site, Apps or Services for any political or commercial purposes, including for any unsolicited or unauthorized advertising, promotional messages, spam or any other form of solicitation;
Introduce malware, viruses, trojan horses, worms, logic bombs, drop-dead devices, backdoors, shutdown mechanisms, DDoS attacks, or anything else that could cause harm to the Site, Apps or Services, its uses or related data; or
Interfere with, or attempt to interfere with, the access of any user, host or network, including, without limitation, sending a virus, overloading, flooding, spamming, creating, encouraging or implementing sibyl attacks;
Engage in actions that jeopardize the security of the Site, Apps, Services, computer network, encryption or cryptography, or other security measures; 
Decompile, reverse engineering, or otherwise attempting to obtain the source code or underlying information relating to the Site, Apps or Services.
Access any non-public accounts or data other than your own or those for which you have explicit consent;
Encourage or enable any other individual or entity to do any of the foregoing or otherwise violate this Agreement or any applicable laws.

Intellectual Property

The Site, Apps, Services, and all Vetted Dating Advice intellectual property therein (e.g., text, logos, images, software, and designs) are owned by Vetted Dating Advice or its licensors and are protected by U.S. and international copyright, trademark, patent, and trade secret laws. All rights not expressly granted are reserved. Any feedback or ideas you submit become our property, and we may use them without compensation.
Unauthorized use of the Site, Apps, Services, or Content may violate intellectual property laws and result in legal consequences. You may not reproduce, modify, or distribute our proprietary materials without written permission. You may not disclose proprietary information obtained through the Site, Apps or Services without our consent.
The Site, Apps and Services may offer an opportunity for users to post and exchange data, feedback, opinions and information (“Content”). Vetted Dating Advice does not filter, edit, publish or review Content prior to publication. Content does not reflect the views and opinions of Vetted Dating Advice, its agents, affiliates or subsidiaries. To the extent permitted by applicable law, Vetted Dating Advice shall not be liable for the Content or for any liability, damages or expenses caused or suffered from any use of or posting of or appearance of Content. Vetted Dating Advice reserves the right to monitor all Content and to remove any Content which causes breach of this Agreement.
Vetted Dating Advice does not endorse, guarantee, or assume responsibility for any Content, third-party products, services, information or advertisements appearing on or through the Site, Apps, or Services. Such content reflects the views of its creators, not Vetted Dating Advice, its affiliates, or subsidiaries. We reserve the right to monitor, remove, or restrict any Content at our sole discretion, but we are not obligated to review or verify its accuracy, legality, or appropriateness. Your reliance on such content, including dating information or third-party offerings, is at your own risk, and Vetted Dating Advice disclaims all liability for any damages or losses arising from such reliance. We do not verify user identities or Content accuracy; interactions are at your own risk.
You warrant and represent that:
You have rights to any Content you submit to the Site, Apps, or Services, and you have all necessary licenses and consents to do so;
The Content you submit is non-confidential and may be disclosed through the Services to others on a worldwide basis;
The Content you submit is accurate, truthful and not misleading;
Your Content does not infringe any intellectual property right of Vetted Dating Advice or a third party, including without limitation any copyright, patent, trademark or trade secret;
Your Content may not display any personal details (e.g., phone numbers, last names, addresses, health information, specific details about an individual’s occupation), banking information, nudity, obscene images, or pornographic images. Moreover, you should refrain from submitting Content that is offensive, abusive, libelous, defamatory, obscene, racist, ethnically or culturally offensive, indecent, that promotes violence, terrorism, or illegal acts, incites hatred on grounds of race, gender, religion or sexual orientation;
Your Content does not contain any defamatory, libelous, offensive, harassing, indecent or otherwise unlawful material, and is not an invasion of privacy; and
Your Content will not be used to solicit or promote unlawful activity.
You hereby grant Vetted Dating Advice a worldwide, royalty-free, perpetual, irrevocable, sublicensable, non-exclusive right and license to use, reproduce, sell, publish, distribute, modify, adapt, display, perform, promote, link to, use, or authorize others to use, in any form of media, any Content that you submit on or through the Site, Apps or Services.
Any link to our Site must not be deceptive in any way or falsely imply sponsorship, endorsement or approval of Vetted Dating Advice or another unauthorized party. 
No use of Vetted Dating Advice’s logo, trademarks, copyrights, images, or other artwork will be allowed for linking absent a written and signed trademark license agreement.
We comply with the Digital Millennium Copyright Act ("DMCA"), and we will respond to a properly submitted notification of claimed copyright infringement in accordance with our DMCA procedures. If you or any user of our Site, Apps or Services believes its copyright rights have been infringed, the copyright's owner (“Complaining Party”) should send notification to Our Designated Agent (as identified below) immediately. To be effective, the notification must include:
A physical or electronic signature of the Complaining Party or such person authorized to act on behalf of the Complaining Party;
Identification of the copyrights(s) claimed to have been infringed;
Information reasonably sufficient to permit us to contact the Complaining Party or such person authorized to act on behalf of the Complaining Party, such as address, telephone number and, if available, an electronic mail address at which the Complaining Party may be contacted;
Identification of the material that is claimed to be infringing the Complaining Party’s copyrights(s) that is to be removed and information reasonably sufficient to permit us to locate such materials;
A statement that the Complaining Party has a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, agent, or by law; and
A statement that the information in the notification is accurate and, under penalty of perjury, the Complaining Party or such person authorized to act on behalf of the Complaining Party is the owner of an exclusive copyright that is allegedly infringed.
Pursuant to the DMCA, Vetted Dating Advice’s Designated Agent for notice of claims of copyright infringement can be contacted at the addresses below:

Vetted Dating Advice 
Attn: ZenBusiness Inc.
Postal Address: [221 West Lake Lansing Road Suite 200
East Lansing, MI 48823]
E-mail address: [vetteddatingadvice@gmail.com]

DMCA Counter-Notification - If a work that you submitted to the Site, Apps or Services is disabled or the work is removed as a result of a DMCA Copyright Infringement Notice, and if you believe that the disabled access or removal is the result of mistake or misidentification, then you may send us a DMCA Counter-Notification to the addresses above. Your DMCA Counter-Notification should contain the following information:
a reference or subject line that says: “DMCA Counter-Notification”;
a description of the material that has been removed or to which access has been disabled and the location at which the material appeared before it was removed or access to it was disabled (please include the full URL of the page(s) on the Site from which the material was removed or access to it disabled);
a statement under penalty of perjury that you have a good faith belief that the material was removed or disabled as a result of mistake or misidentification of the material to be removed or disabled;
your name, address, telephone number, email address;
a statement that you consent to the jurisdiction of the Federal District Court for the judicial district in which your address is located, and that you will accept service of process from the person who provided DMCA Notification to us or an agent of such person; and
your electronic or physical signature.
If we receive a DMCA Counter-Notification, then we may replace the material that we removed (or stop disabling access to it) in not less than ten (10) and not more than fourteen (14) business days following receipt of the DMCA Counter-Notification. However, we will not do this if we first receive notice at the addresses above that the party who sent us the DMCA Copyright Infringement Notice has filed a lawsuit asking a court for an order restraining the person who provided the material from engaging in infringing activity relating to the material on the Services. You should also be aware that we may forward the Counter-Notification to the party who sent us the DMCA Copyright Infringement Notice.
You acknowledge, accept and agree that if we receive a notice of a claim of copyright infringement, we may immediately remove the identified materials from our Site, Apps or Services without liability to you or any other party and that the claims of the Complaining Party may be referred to the United States Copyright Office for adjudication as provided in the DMCA.
Please note that this procedure is exclusively for notifying Vetted Dating Advice and its affiliates that your copyrighted material has been infringed. The preceding requirements are intended to comply with our rights and obligations under the DMCA, including 17 U.S.C. §512(c), but do not constitute legal advice. It may be advisable to contact an attorney regarding your rights and obligations under the DMCA and other applicable laws. Allegations that other intellectual property rights are being infringed should be sent to [vetteddatingadvice@gmail.com]. 

Third-Party Providers
The Site, Apps, or Services may connect to third-party websites, applications, or resources (“Third-Party Services”), which are subject to their own terms, privacy policies, or agreements. Vetted Dating Advice does not control, endorse, or guarantee the accuracy, reliability, or availability of Third-Party Services. You are responsible for reviewing their terms and policies before use. Accessing or using Third-Party Services is at your own risk, and such use remains subject to this Agreement. Vetted Dating Advice is not liable for any costs, losses, or damages arising from your interactions with Third-Party Services, and any transactions with third parties are solely between you and them.
No Warranties

THE SITE, APPS AND SERVICES ARE PROVIDED ON AN "AS IS" AND "AS AVAILABLE" BASIS, AND ‘WITH ALL FAULTS.’ TO THE FULLEST EXTENT PERMITTED BY LAW, WE DISCLAIM ANY REPRESENTATIONS AND WARRANTIES OF ANY KIND, WHETHER EXPRESS, IMPLIED, OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, THE WARRANTIES OF MERCHANTABILITY, TITLE, NON-INFRINGEMENT, AND FITNESS FOR A PARTICULAR PURPOSE. YOU ACKNOWLEDGE AND AGREE THAT YOUR USE OF EACH OF OUR SITE, APPS AND SERVICES IS AT YOUR OWN RISK. WE DO NOT REPRESENT OR WARRANT THAT ACCESS WILL BE CONTINUOUS, UNINTERRUPTED, TIMELY, OR SECURE; THAT THE INFORMATION, CONTENT OR DATA WILL BE ACCURATE, RELIABLE, COMPLETE, OR CURRENT; OR THAT THE SITE, APPS, OR SERVICES WILL BE FREE FROM ERRORS, DEFECTS, VIRUSES, OR OTHER HARMFUL ELEMENTS. NO ADVICE, INFORMATION, OR STATEMENT THAT WE MAKE SHOULD BE TREATED AS CREATING ANY WARRANTY. WE DO NOT ENDORSE, GUARANTEE, OR ASSUME RESPONSIBILITY FOR ANY ADVERTISEMENTS, OFFERS, OR STATEMENTS MADE BY THIRD PARTIES.

YOU ACKNOWLEDGE AND AGREE THAT THE WARRANTY DISCLAIMERS SET FORTH ARE FUNDAMENTAL ELEMENTS OF THE BASIS OF THE BARGAIN BETWEEN VETTED DATING ADVICE AND YOU.

WE ASSUME NO RESPONSIBILITY REGARDING THE ACCURACY OF CONTENT PRESENTED ON THE SERVICES. THE CONTENT IS FOR INFORMATIONAL PURPOSES ONLY. WE MAKE NO WARRANTY WHATSOEVER THAT ANY OF THE CONTENT IS ACCURATE, RELIABLE OR VERIFIED. THE CONTENT IS NOT INTENDED TO BE A GUARANTEE OF SUCCESS OR POSITIVE RESULTS – IT IS FOR INFORMATIONAL PURPOSES ONLY AND THE RESULTS OF YOUR ACTIONS ARE THE RESPONSIBILITY OF YOU AND YOU ALONE. RELIANCE ON ANY INFORMATION PROVIDED BY THE SITE, APPS OR SERVICES IS SOLELY AT YOUR OWN RISK. WE DISCLAIM ALL LIABILITY AND RESPONSIBILITY ARISING FROM ANY RELIANCE PLACED ON SUCH MATERIALS BY YOU OR ANY OTHER USER OF THE SITE, APPS, SERVICES OR CONTENT.

THIS SECTION 8 WILL NOT APPLY TO THE EXTENT PROHIBITED BY LAW.

Limitation of Liability

UNDER NO CIRCUMSTANCES SHALL VETTED DATING ADVICE OR ANY OF OUR AGENTS, AFFILIATES, OR SUBSIDIARIES BE LIABLE TO YOU FOR ANY INDIRECT, PUNITIVE, INCIDENTAL, INTANGIBLE, SPECIAL, CONSEQUENTIAL, OR EXEMPLARY DAMAGES, INCLUDING, BUT NOT LIMITED TO, DAMAGES FOR LOSS OF PROFITS, LOSS OF GOODWILL OR REPUTATION, USE, DATA LOSS OR CORRUPTION, DIMINUTION IN VALUE OR BUSINESS OPPORTUNITY, OR OTHER INTANGIBLE PROPERTY, ARISING OUT OF OR RELATING TO ANY ACCESS OR USE OF, OR INABILITY TO ACCESS OR USE, THE SITE, APPS OR SERVICES, NOR WILL WE BE RESPONSIBLE FOR ANY DAMAGE, LOSS, OR INJURY RESULTING FROM HACKING, TAMPERING, OR OTHER UNAUTHORIZED ACCESS OR USE OF THE SITE, APPS, OR SERVICES, WHETHER SUCH DAMAGES ARE BASED IN CONTRACT, TORT, NEGLIGENCE, STRICT LIABILITY, OR OTHERWISE, ARISING OUT OF OR IN CONNECTION WITH ANY AUTHORIZED OR UNAUTHORIZED USE OF ANY OF THE SITE, SERVICES OR THIS AGREEMENT, EVEN IF VETTED DATING ADVICE OR ITS REPRESENTATIVE HAS BEEN ADVISED OF OR KNEW OR SHOULD HAVE KNOWN OF THE POSSIBILITY OF SUCH DAMAGES. WE ASSUME NO LIABILITY OR RESPONSIBILITY FOR ANY: (A) ERRORS, MISTAKES, OR INACCURACIES; (B) PERSONAL INJURY OR PROPERTY DAMAGE, OF ANY NATURE WHATSOEVER, RESULTING FROM ANY ACCESS OR USE OF THE SITE, APPS, OR SERVICES; (C) UNAUTHORIZED ACCESS OR USE OF ANY SECURE SERVER OR DATABASE IN OUR CONTROL, OR THE USE OF ANY INFORMATION OR DATA STORED THEREIN; (D) INTERRUPTION OR CESSATION OF FUNCTION RELATED TO THE SITE, APPS, OR SERVICES; (E) BUGS, VIRUSES, TROJAN HORSES, OR THE LIKE THAT MAY BE TRANSMITTED; (F) ERRORS OR OMISSIONS IN, OR LOSS OR DAMAGE INCURRED AS A RESULT OF THE USE OF, ANY CONTENT MADE AVAILABLE; AND (G) THE DEFAMATORY, OFFENSIVE, OR ILLEGAL CONDUCT OF ANY USER OR THIRD PARTY.

WE SHALL NOT BE LIABLE UNDER ANY CIRCUMSTANCES FOR DAMAGES ARISING OUT OF OR IN ANY WAY RELATED TO THIRD-PARTY SERVICES, SOFTWARE, PRODUCTS, SERVICES, DATA, OR INFORMATION OFFERED OR PROVIDED BY THIRD PARTIES AND ACCESSED THROUGH OUR SITE.

IN NO EVENT SHALL THE TOTAL LIABILITY OF VETTED DATING ADVICE, ITS AFFILIATES, SUBSIDIARIES, AGENTS AND LICENSORS, FOR ANY DAMAGES (OTHER THAN AS MAY BE REQUIRED BY APPLICABLE LAW), EXCEED THE AGGREGATE AMOUNT OF ONE HUNDRED U.S. DOLLARS (\$100.00 USD) OR ITS EQUIVALENT IN THE LOCAL CURRENCY OF THE APPLICABLE JURISDICTION.

YOU ACKNOWLEDGE AND AGREE THAT THE LIMITATIONS OF LIABILITY SET FORTH ARE FUNDAMENTAL ELEMENTS OF THE BASIS OF THE BARGAIN BETWEEN VETTED DATING ADVICE AND YOU.

THIS SECTION 9 WILL NOT APPLY TO THE EXTENT PROHIBITED BY LAW.

Indemnification & Release of Vetted Dating Advice

You agree to release and hold harmless, defend, and indemnify Vetted Dating Advice, our affiliates, subsidiaries and those parties’ respective officers, directors, employees, contractors, agents, service providers, licensors, and representatives, including any successors and assigns, (collectively, the " Vetted Dating Advice Parties") from and against all claims, damages, obligations, losses, liabilities, costs, and expenses of every kind and nature (including reasonable attorney's fees) arising from or relating to: (a) your access and use of the Site, Apps or Services; (b) your submission of content, (c) your violation of any term or condition of this Agreement, the right of any third party, or any other applicable law, rule, or regulation; (d) any other party's access and use of the Site, Apps, or Services with your assistance or using any device or account that you own or control; and (e) any dispute between you and (i) Vetted Dating Advice or any other user of any of the Site, Apps or Services, or (ii) any of your own customers or users. We will provide notice to you of any such claim, suit, or proceeding. We reserve the right to assume the exclusive defense and control of any matter which is subject to indemnification under this section, and you agree to cooperate with any reasonable requests assisting our defense of such matter. You may not settle or compromise any claim against any Vetted Dating Advice Party without our written consent.
You expressly agree that you assume all risks in connection with your access and use of the Site, Apps and Services. You further expressly waive and release us from any and all liability, claims, causes of action, or damages arising from or in any way relating to your use of the Site, Apps or Services. If you are a California resident, you waive the benefits and protections of California Civil Code § 1542, which provides: "[a] general release does not extend to claims that the creditor or releasing party does not know or suspect to exist in his or her favor at the time of executing the release and that, if known by him or her, would have materially affected his or her settlement with the debtor or released party."

Dispute Resolution, Arbitration, Class-Action and Jury Trial Waivers

We will use our best efforts to resolve any potential disputes through informal, good faith negotiations. If a potential dispute arises, you must contact us by sending an email to [vetteddatingadvice@gmail.com] so that we can attempt to resolve it without resorting to formal dispute resolution. If we aren't able to reach an informal resolution within sixty (60) days of your email receipt, then you and we both agree to resolve the potential dispute according to the process set forth below.

Any dispute, controversy, or claim arising out of or in connection with the Site, Apps, Services, or this Agreement, including any question regarding its existence, validity, termination, breach, interpretation, performance, or arbitrability (a "Dispute"), shall be referred to and finally resolved by arbitration administered by the American Arbitration Association (AAA) in accordance with its Consumer Arbitration Rules (the "Rules"), which Rules are deemed to be incorporated by reference hereto. The seat (legal place) of arbitration shall be [East Lansing, Michigan, United States]. The language of the arbitration shall be English. The arbitral tribunal shall consist of three (3) arbitrators. Each party shall nominate one arbitrator, and the two arbitrators so appointed shall appoint a third arbitrator who shall act as the presiding arbitrator. If either party fails to nominate an arbitrator within thirty (30) days of receiving notice of the nomination of an arbitrator by the other party, or if the two arbitrators fail to agree on the presiding arbitrator within thirty (30) days of their appointment, such arbitrator(s) shall be appointed by the AAA. The arbitral tribunal shall have the power to grant any legal or equitable remedy or relief available under law, including injunctive relief (whether interim or final), specific performance, and any other relief that would be available in any legal proceeding. The arbitral award shall be final and binding upon the parties and shall be enforceable in any court of competent jurisdiction. The parties hereby waive irrevocably their right to any form of appeal, review, or recourse to any court or other judicial authority, to the extent that such waiver may be validly made. This arbitration agreement shall be governed by and construed in accordance with the laws of the State of [Michigan], United States, without regard to its conflict of law principles. The parties agree to keep confidential all matters relating to the arbitration, including all documents exchanged or produced during the proceedings, as well as the arbitration proceedings themselves and the arbitral award, except as may be required by applicable law or for the purpose of enforcement of the arbitral award. Nothing in this arbitration provision shall prevent either party from seeking interim or conservatory measures from any court of competent jurisdiction before the constitution of the arbitral tribunal. The parties agree that any arbitration proceedings commenced pursuant to this arbitration provision shall be consolidated with any other arbitration proceedings commenced under this Agreement if the disputes in the proceedings arise from the same or substantially the same transactions, relationships, or events. Each party shall be responsible for its own costs and expenses arising from the arbitration, except as may otherwise be determined by the Arbitrator. 

You must bring any and all Disputes against us in your individual capacity and not as a plaintiff in or member of any purported class action, collective action, private attorney general action, or mass action or other representative proceeding. This provision applies to class arbitration. You and we both agree to waive the right to demand a trial by jury. Without limiting the foregoing, this section does not prevent you or Vetted Dating Advice from participating in a class-wide settlement of claims.

Additional Terms and Conditions

Compliance – One or more of the Site, Apps or Services may not be available or appropriate for use in your jurisdiction or by you. By accessing or using the Site, Apps, or Services, you agree that you are solely and entirely responsible for compliance with all laws and regulations that may apply to you. We do not provide medical, psychological, therapeutic, or professional relationship advice. Content and information are for general informational purposes only and are not a substitute for professional counseling or therapy.
Taxes - Your use of our Site, Apps and Services may result in various tax consequences in certain jurisdictions, including but not limited to income or capital gains tax, value-added tax, goods and services tax, or sales tax. It is your responsibility to determine whether taxes apply to you, and if so to report and/or remit the correct tax to the appropriate tax authority. 
Assignment - You may not assign or transfer this Agreement, or any rights or licenses granted hereunder, by operation of law or otherwise, without our prior written consent. Any attempt by you to assign or transfer this Agreement without our prior written consent shall be null and void. We may freely assign or transfer this Agreement, without restriction. Subject to the foregoing, this Agreement will bind and inure to the benefit of the parties, their successors and permitted assigns. If we are acquired by or merged with a third-party entity, we reserve the right, in any of these circumstances, to transfer or assign the information we have collected as part of such merger, acquisition, sale, or other change of control.
No Waiver - Vetted Dating Advice’s failure to enforce any right or provision of this Agreement will not be considered a waiver of such right or provision. The waiver of any such right or provision will be effective only if in writing and signed by a duly authorized representative of Vetted Dating Advice. Except as expressly set forth in this Agreement, the exercise by Vetted Dating Advice of any of its remedies under this Agreement will be without prejudice to its other remedies herein. 
Severability - If any provision of this Agreement shall be determined to be invalid or unenforceable under any rule, law, or regulation of any local, state, or federal government agency, such provision will be changed and interpreted to accomplish the objectives of the provision to the greatest extent possible under any applicable law and the validity or enforceability of any other provision of this Agreement shall not be affected.
Eligibility - To access or use our Site, Apps, or Services, you must be able to form a legally binding contract with us. Accordingly, you represent that you are at least the age of majority in your jurisdiction (e.g., 18 years old in the United States) and have the full right, power, and authority to enter into and comply with the terms and conditions of this Agreement on behalf of yourself and any company or legal entity for which you may represent or act on behalf of. If you are entering into this Agreement on behalf of an entity, you represent to us that you have the legal authority to bind such entity to this Agreement. There are certain features which may or may not be available to you depending on your location and other criteria.
Relationship - Nothing herein shall constitute an employment, consultancy, joint venture, or partnership relationship between you and Vetted Dating Advice or any of its affiliates or subsidiaries. 
Electronic Signature –Your use of electronic signatures, transactions, or consents via the Site, Apps, or Services constitutes a legally binding agreement, equivalent to a handwritten signature. By engaging in any electronic action (e.g., clicking "I Agree," subscribing, or submitting content), you represent that you have the ability to access and retain records of such actions and agree to be bound by them as if signed on paper. You are responsible for reviewing the Site periodically for updates to this Agreement and acknowledge that electronically stored copies of this Agreement are admissible and enforceable in any dispute. You agree to conduct business electronically and bear responsibility for maintaining equipment and services (e.g., internet access, email) necessary to receive and store electronic communications.
Electronic Notices - You agree and consent to receive electronically all communications, agreements, documents, notices and disclosures (collectively, "Communications") that we provide in connection with your use of the Site, Apps, or Services, including but not limited to (a) this Agreement and our Privacy Policy; (b) legal, regulatory, and tax disclosures or statements we may be required to make available to you; (c) responses to claims or customer support inquiries; and (d) any other applicable Communication. We may provide these Communications to you by posting them on the Site, Apps, or Services, emailing them to you, communicating to you via the Site, Apps, or Services, and/or through other electronic communication means. To access and retain electronic Communications, you will need a computer with an internet connection that has a current web browser with cookies enabled and sufficient storage space, 128-bit encryption, and a current and valid email address. For certain Communications you may also need software to view PDF files. You agree that you are solely responsible for maintaining such equipment and services required for online access. You may withdraw your consent to receive Communications electronically by contacting us at [vetteddatingadvice@gmail.com]. It is your responsibility to provide us with true, accurate and complete contact information, and to keep such information up to date. You understand and agree that if we send you an electronic Communication but you do not receive it because your information is incorrect, out of date, blocked by a service provider, or you are otherwise unable to receive electronic Communications, we will be deemed to have provided the Communication to you. For us to send paper copies to you, you must have a current street address on file with us. Any request for a paper copy of a Communication is limited to that individual piece of Communication and won’t affect your consent to receive any other Communications electronically. We may charge you fees for any paper copies of Communications.
Governing Law - This Agreement shall be governed by and construed in accordance with the laws of [Michigan]. Any Dispute arising out of or in connection with this Agreement shall be subject to the exclusive jurisdiction of [Michigan]. The parties irrevocably submit to the jurisdiction of the [Michigan] and waive any objection to proceedings on the grounds of venue or that proceedings have been brought in an inappropriate forum.
Accessibility – Our Site and Services are designed with accessibility features to help ensure they are accessible to everyone. If you have a disability or need assistance accessing any portion of our website, please contact us at [vetteddatingadvice@gmail.com].
Survival – All provisions of this Agreement which by their nature extend beyond the expiration or termination of this Agreement, including but not limited to, sections pertaining to No Warranties, Limitation of Liability, Dispute Resolution, Arbitration, Class Action and Jury Trial Waivers, Taxes, Compliance, Intellectual property, and other provisions that by their nature should persist expiration or termination of this Agreement, shall survive any termination or expiration of this Agreement.
Force Majeure - We shall not be liable for any error, delay, loss, failure or damage arising, directly or indirectly, from any cause or condition beyond our reasonable control, including but not limited to, extraordinary weather conditions, an act of God, an act of civil or military authorities, acts of terrorists, civil disturbance, war, insurrection, riot, accident, an action of government, a strike or other labor dispute, fire, interruption in telecommunications or internet services or network provider services, failure of power or equipment or software, pandemic, or any other catastrophe or other occurrence which is beyond our reasonable control.
Headings - The section titles in this agreement are for convenience only and have no legal or contractual effect. Use of the word ‘including’ will be interpreted to mean ‘including without limitation.’ 
Contact Us – If you have questions or concerns regarding this Agreement, or if you have a complaint, please contact us [vetteddatingadvice@gmail.com].
Entire Agreement – This Agreement and our Privacy Policy constitutes the entire agreement between you and us with respect to the subject matter hereof. This Agreement supersedes any and all prior or contemporaneous written and oral agreements, communications and other understandings (if any) relating to the subject matter of the terms, the Site and Services.
Terms for Apple Mobile Devices – Your use of the App on Apple devices is governed by this Agreement, not Apple, Inc. (“Apple”). Vetted Dating Advice grants you a non-transferable license to use the App on Apple-branded devices you own or control, per Apple’s Media Services Terms (www.apple.com/legal/internet-services/itunes/), including Family Sharing or volume purchasing. Vetted, not Apple, is responsible for the App’s content, maintenance, support, and any claims (e.g., product liability, failure to meet legal or regulatory requirements, or consumer protection laws). Apple and its subsidiaries are third-party beneficiaries of this Agreement and may enforce it against you. You must comply with applicable third-party terms and not use the App on jailbroken devices. To the extent any warranty applies (and is not disclaimed in Section 8), Vetted, not Apple, is responsible. If the App fails to conform to such warranty, you may notify Apple for a refund of the purchase price (if any), but Apple has no further warranty obligations. In-app purchases are processed per Apple’s payment terms and policies.
Terms for Android Mobile Devices – The App downloaded via Google Play is licensed for use on your devices, including family group accounts, per Google’s Play Store terms. This Agreement governs your relationship with Vetted Dating Advice, not Google, Inc. (“Google”). Vetted, not Google, is responsible for the App’s content, maintenance, support, and any claims (e.g., product liability, failure to meet legal or regulatory requirements, or consumer protection laws). Google has no support or warranty obligations. To the extent any warranty applies (and is not disclaimed in Section 8), Vetted is responsible. In-app purchases are processed per Google’s payment terms and policies. If any terms conflict with Google’s Developer Distribution Agreement, Google’s terms prevail.
We reserve the right to use AI and other moderation tools to monitor and manage user Content and to use anonymized data to improve the Site, Apps and Services.
We reserve the right to investigate and prosecute any suspected or actual violations of this Agreement. We may disclose any information as necessary or appropriate to satisfy any law, regulation, legal process, or government request.Users may report content or behavior that violates these Terms directly within the App or by contacting [vetteddatingadvice@gmail.com]. We review reports and take appropriate action in accordance with this Agreement. 
Contact Us – For questions or concerns about this Agreement or our practices, contact us at: [vetteddatingadvice@gmail.com]. """,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.05),
            if (justAScreen == true) ...[
              Row(
                children: [
                  Obx(() {
                    return Checkbox(
                      value: isChecked.value,
                      onChanged: (value) => isChecked.toggle(),
                      side: BorderSide(color: AppColors.primaryColor),
                      activeColor: AppColors.primaryColor,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    );
                  }),
                  Expanded(
                    child: Text(
                      "I confirm that I have read and accept the terms and conditions and privacy policy.",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.05),
              Obx(() {
                return Opacity(
                  opacity: isChecked.value ? 1 : 0.5,
                  child: CustomButton(
                    ontap: () async {
                      if (!isChecked.value) return;
                      await authController.googleAuthSignUp();
                    },
                    isLoading: authController.isGoogleLoading,
                    child: Text(
                      "Accept",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }),
            ],
            SizedBox(height: Get.height * 0.02),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
        'Terms and Condition',
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
