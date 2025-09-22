import 'package:flutter/material.dart';
import 'inbox_screen.dart';
import 'add_friends_screen.dart'; // ✅ Import this

class MessageListScreen extends StatelessWidget {
  const MessageListScreen({super.key});

  final List<Map<String, String>> messages = const [
    {
      'name': 'Diana Allen',
      'message':
          "Trust your memory. She’ll try to rewrite it. Fucking gas lighter.",
      'time': '1d',
    },
    {
      'name': 'John Doe',
      'message': "Hey, are we still meeting tomorrow?",
      'time': '2h',
    },
    {'name': 'Lina K.', 'message': "Thanks for your help!", 'time': '5h'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Messages',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.black,
            onPressed: () {
              // ✅ Navigate to AddFriendsScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddFriendsScreen()),
              );
            },
          ),
        ],
        elevation: 0.5,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final msg = messages[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InboxScreen(username: msg['name']!),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg['name']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          msg['message']!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    msg['time']!,
                    style: const TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
