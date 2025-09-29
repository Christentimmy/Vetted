import 'package:Vetted/app/controller/post_controller.dart';
import 'package:Vetted/app/data/models/post_model.dart';
import 'package:Vetted/app/modules/post/widgets/post_widgets.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/utils/timeago.dart';
import 'package:Vetted/app/widgets/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

Widget buildPollWidget({
  required PostModel post,
  bool? isGhodePost,
  required bool isProfilePost,
  VoidCallback? onDelete,
}) {
  if (post.poll == null) {
    return const SizedBox();
  }

  return VisibilityDetector(
    key: ValueKey(post.id),
    onVisibilityChanged: (info) {
      if (info.visibleFraction > 0.5) {
        Get.find<PostController>().addViewedPost(post.id);
      }
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main post header (retweeter's info)
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primaryColor,
                child: FaIcon(FontAwesomeIcons.ghost, color: Colors.white),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      post.author?.displayName ?? "",
                      style: Get.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: 3,
                      height: 3,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Text(
                      timeAgo(post.createdAt),
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            buildOptionAboutPost(
              postModel: post,
              isProfilePost: isProfilePost,
              onDelete: onDelete,
            ),
          ],
        ),

        // Regular poll post content
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Regular post text
            if (post.content?.text != null && post.content!.text!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  post.content!.text!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),

            // Regular poll container
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 3,
                    color: const Color.fromARGB(26, 0, 0, 0),
                  ),
                ],
              ),
              child: PollWidget(post: post),
            ),
          ],
        ),

        const SizedBox(height: 2),
        // Action buttons (always for the main post/retweet)
        buildPostActionRowWidget(postModel: post),
        const SizedBox(height: 20),
      ],
    ),
  );
}

class PollWidget extends StatefulWidget {
  final PostModel post;
  const PollWidget({super.key, required this.post});

  @override
  State<PollWidget> createState() => _PollWidgetState();
}

class _PollWidgetState extends State<PollWidget> {
  final postController = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return FlutterPolls(
        pollId: widget.post.id,
        hasVoted: widget.post.poll?.hasVoted?.value ?? false,
        userVotedOptionId: widget.post.poll?.selectedOptionId?.value,
        onVoted: (PollOption pollOption, int newTotalVotes) async {
          if (widget.post.poll!.hasVoted?.value == true) {
            return false;
          }

          widget.post.poll!.hasVoted!.value = true;
          widget.post.poll!.selectedOptionId!.value = pollOption.id!;

          final success = await postController.voteOnPoll(
            postId: widget.post.id!,
            optionId: pollOption.id!,
          );
          
          if (success) {
            setState(() {
              final option = widget.post.poll!.options!.firstWhere(
                (o) => o.id == pollOption.id,
              );
              option.voteCount = (option.voteCount ?? 0) + 1;
              widget.post.poll!.totalVotes = widget.post.poll!.totalVotes! + 1;
            });
          }

          return success;
        },
        pollOptionsSplashColor: Colors.white,
        votedBackgroundColor: const Color.fromARGB(255, 240, 240, 240),
        heightBetweenOptions: 15,
        votesTextStyle: Get.textTheme.bodyMedium,
        votedPercentageTextStyle: Get.textTheme.bodyMedium?.copyWith(
          color: AppColors.primaryColor,
        ),
        loadingWidget: Loader2(),
        heightBetweenTitleAndOptions: 25,
        leadingVotedProgessColor: const Color.fromARGB(255, 226, 131, 129),
        pollTitle: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.post.poll?.question ?? "",
            style: Get.textTheme.bodySmall,
          ),
        ),
        pollOptionsBorder: Border.all(width: 1, color: Colors.grey.shade300),
        pollOptions: buildOptions(),
        pollEnded:
            widget.post.poll?.expiresAt != null &&
            widget.post.poll!.expiresAt!.isBefore(DateTime.now()),
      );
    });
  }

  List<PollOption> buildOptions() {
    if (widget.post.poll?.options == null) {
      return [];
    }
    final pollOptions =
        widget.post.poll!.options!.map((option) {
          return PollOption(
            id: option.id,
            title: Text(option.text ?? ""),
            votes: option.voteCount ?? 0,
          );
        }).toList();
    return pollOptions;
  }
}
