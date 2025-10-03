import 'package:Vetted/app/controller/subscription_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpgradePlanScreen extends StatelessWidget {
  UpgradePlanScreen({super.key});

  final subscriptionController = Get.find<SubscriptionController>();

  @override
  Widget build(BuildContext context) {
    final List<String> features = [
      "Unlimited post search",
      "Access all nationwide post",
      "Filter post by location",
      "Set alerts for men’s name",
      "No screenshots",
      "Background checks",
      "Criminal record search",
      "Sex offenders search",
      "Phone number lookup",
      "Reverse image search",
      "Find social media profiles",
      "Boost your posts",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔙 Back button + title
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Upgrade Your Plan',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 🧾 Table-like Feature Card
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red.shade200),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: const [
                          Expanded(
                            flex: 3,
                            child: Text(
                              '  What you get:',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Your Plan',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Pro',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),

                    // 📝 Feature rows
                    ...features.mapIndexed((index, feature) {
                      final bool isFree = index < 5;
                      return Container(
                        color:
                            index % 2 == 0
                                ? Colors.transparent
                                : Colors.grey.shade50,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 8,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                feature,
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      isFree
                                          ? Colors.black
                                          : Colors.grey.shade500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child:
                                    isFree
                                        ? const Icon(
                                          Icons.check,
                                          size: 18,
                                          color: Colors.black,
                                        )
                                        : const SizedBox(),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.red.shade100,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.check,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 12),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'Just \$99/month',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // 🔓 Unlock Features Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await subscriptionController.createSubscription();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Obx(() {
                    if (subscriptionController.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }
                    return const Text(
                      'Unlock All Features',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Recurring billing? Cancel anytime.',
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
              const SizedBox(height: 12),

              // ❌ Maybe Later
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'Maybe later',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Extension to use mapIndexed
extension IndexedMap<T> on Iterable<T> {
  Iterable<E> mapIndexed<E>(E Function(int index, T item) f) {
    int i = 0;
    return map((item) => f(i++, item));
  }
}
