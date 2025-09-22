import 'package:flutter/material.dart';
import 'post_screen.dart';
import 'inbox_screen.dart';

class ViewAndCommentScreen extends StatelessWidget {
  const ViewAndCommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top image and icons
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                child: Image.asset(
                  'assets/images/sample_post.png',
                  width: double.infinity,
                  height: 320,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 40,
                left: 16,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const PostScreen()),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),

              Positioned(
                top: 40,
                right: 60,
                child: const Icon(
                  Icons.bookmark_border,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: const Icon(Icons.share, color: Colors.white, size: 28),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Name and location
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _showUserOptions(context),
                        child: const Text(
                          "Diana Allen  21",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      "Los Angeles, US",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _flagWithCount(Icons.flag, Colors.red, '40'),
                        const SizedBox(width: 12),
                        _flagWithCount(Icons.flag, Colors.green, '15'),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.shade700,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Anonym',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Comments list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                CommentCard(
                  username: "Baddest guy",
                  content:
                      "“If you enjoy being blamed for things that happened in her dreams, she’s perfect.\nEmotional roller-coaster with no seatbelts.”",
                  time: "21h",
                  liked: false,
                ),
                CommentCard(
                  username: "Rockstar266",
                  content:
                      "“Trust your memory. She’ll try to rewrite it.\nFucking gas lighter!”",
                  time: "21h",
                  liked: true,
                  likeCount: 8,
                ),
                CommentCard(
                  username: "Huss001",
                  content: "“Talk to a female coworker? You're cheating.”",
                  time: "21h",
                  liked: false,
                ),
              ],
            ),
          ),

          // Comment input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 0.3)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "Type your comment",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.image_outlined, color: Colors.black54),
                IconButton(
                  icon: const Icon(Icons.mic, color: Colors.redAccent),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _flagWithCount(IconData icon, Color color, String count) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: color),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: Text(
            count,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  void _showUserOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _optionTile(context, Icons.block, 'Block user'),
              _optionTile(context, Icons.message_outlined, 'Send a DM'),
              _optionTile(context, Icons.report_gmailerrorred, 'Report user'),
            ],
          ),
    );
  }

  Widget _optionTile(BuildContext context, IconData icon, String title) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          onTap: () {
            Navigator.pop(context);
            if (title == 'Send a DM') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => const InboxScreen(username: 'Diana Allen'),
                ),
              );
            }
          },
        ),
        const Divider(height: 1),
      ],
    );
  }
}

class CommentCard extends StatelessWidget {
  final String username;
  final String content;
  final String time;
  final bool liked;
  final int likeCount;

  const CommentCard({
    super.key,
    required this.username,
    required this.content,
    required this.time,
    this.liked = false,
    this.likeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _showUserOptions(context),
            child: Row(
              children: [
                const Icon(Icons.person, size: 16),
                const SizedBox(width: 6),
                Text(
                  username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(content),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                "Reply",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(width: 8),
              Text(
                time,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const Spacer(),
              liked
                  ? Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.black, size: 18),
                      if (likeCount > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            "$likeCount",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                    ],
                  )
                  : const Icon(Icons.favorite_border, size: 18),
            ],
          ),
        ],
      ),
    );
  }

  void _showUserOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _optionTile(context, Icons.block, 'Block user'),
              _optionTile(context, Icons.message_outlined, 'Send a DM'),
              _optionTile(context, Icons.report_gmailerrorred, 'Report user'),
            ],
          ),
    );
  }

  Widget _optionTile(BuildContext context, IconData icon, String title) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          onTap: () {
            Navigator.pop(context);
            if (title == 'Send a DM') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InboxScreen(username: username),
                ),
              );
            }
          },
        ),
        const Divider(height: 1),
      ],
    );
  }
}
