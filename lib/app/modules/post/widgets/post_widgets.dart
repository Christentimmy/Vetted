import 'package:Vetted/app/controller/post_controller.dart';
import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/data/models/post_model.dart';
import 'package:Vetted/app/modules/post/widgets/comment_widget.dart';
import 'package:Vetted/app/modules/post/widgets/reaction_row.dart';
import 'package:Vetted/app/modules/report/widgets/report_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildPostActionRowWidget({
  required PostModel postModel,
  bool? isGhostCard,
  Color? iconColor,
  Color? textColor,
}) {
  final controller = Get.find<PostController>();
  return Row(
    children: [
      Obx(
        () => ReactionRowWidget(
          onReactionSelected: (v) async {
            if (postModel.reactedEmoji?.value.isEmpty == true) {
              postModel.stats!.reactionCount!.value++;
              postModel.reactedEmoji!.value = v;
              await Get.find<PostController>().reactToPost(
                postId: postModel.id!,
                emoji: v,
                reactedEmoji: emojiMap[v] ?? "",
              );
            } else {
              postModel.reactedEmoji!.value = "";
              postModel.stats!.reactionCount!.value--;
              await Get.find<PostController>().deletePostReaction(
                postId: postModel.id!,
              );
            }
          },
          selectedReaction: postModel.reactedEmoji?.value ?? "",
          reactionCount: postModel.stats?.reactionCount?.value ?? 0,
          iconColor: iconColor,
          textColor: textColor,
        ),
      ),

      SizedBox(width: 15),
      Obx(
        () => buildTextButton(
          icon: FontAwesomeIcons.comment,
          text: postModel.stats?.comments?.value.toString() ?? "0".obs.value,
          onTap: () {
            buildCommentSheet(Get.context!, postModel, isGhostCard);
          },
          iconColor: iconColor,
          textColor: textColor,
        ),
      ),
      const Spacer(),
      SizedBox(width: 15),
      Obx(
        () => buildTextButton(
          icon:
              postModel.isBookmarked!.value
                  ? FontAwesomeIcons.solidBookmark
                  : FontAwesomeIcons.bookmark,
          onTap: () async {
            await controller.toggleSavePost(postId: postModel.id!);
          },
          iconColor: iconColor,
          textColor: textColor,
        ),
      ),
    ],
  );
}

Future<dynamic> buildCommentSheet(
  BuildContext context,
  PostModel postModel,
  bool? isGhostCard,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: CommentSheet(postModel: postModel, isGhostCard: isGhostCard),
      );
    },
  );
}

Widget buildTextButton({
  required IconData icon,
  String? text,
  VoidCallback? onTap,
  Color? iconColor,
  Color? textColor,
}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: iconColor ?? const Color.fromARGB(255, 65, 6, 5).withValues(),
        ),
        SizedBox(width: 2),
        text != null
            ? Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: textColor ?? const Color.fromARGB(255, 24, 24, 24),
              ),
            )
            : SizedBox.shrink(),
      ],
    ),
  );
}

final Map<String, String> emojiMap = {
  "👍": "like",
  "❤️": "love",
  "😂": "laugh",
  "😮": "wow",
  "👎": "dislike",
  "😢": "sad",
  "😡": "angry",
};

Widget buildOptionAboutPost({
  required PostModel postModel,
  required bool isProfilePost,
  RxInt? index,
  VoidCallback? onDelete,
  Color? iconColor,
}) {
  final userController = Get.find<UserController>();
  final postController = Get.find<PostController>();
  final userModel = userController.userModel.value;
  final isAuthor = userModel?.id == postModel.author?.id;
  final isMediaAvailable = postModel.media?.isNotEmpty ?? false;

  return InkWell(
    onTap: () async {
      final selected = await showMenu<String>(
        context: Get.context!, // or pass `context` if available directly
        position: const RelativeRect.fromLTRB(100, 100, 0, 0),
        items: [
          PopupMenuItem(
            value: "report",
            child: Text(
              "Report",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
          ),
          if (isMediaAvailable)
            PopupMenuItem(
              value: "copy",
              child: Text(
                "Copy",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          if (!isAuthor)
            PopupMenuItem(
              value: "block",
              child: Text(
                "Block",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          if (isAuthor)
            PopupMenuItem(
              value: "delete",
              child: Text(
                "Delete",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          PopupMenuItem(
            value: "save",
            child: Obx(
              () => Text(
                postModel.isBookmarked!.value ? "Unsave" : "Save",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      );

      switch (selected) {
        case "report":
          showModalBottomSheet(
            context: Get.context!,
            builder:
                (context) => ReportBottomSheet(
                  reportUser: postModel.author?.id ?? "",
                  type: ReportType.post,
                  referenceId: postModel.id,
                ),
          );
          break;
        case "copy":
          if (postModel.media != null) {
            Clipboard.setData(
              ClipboardData(text: postModel.media![index?.value ?? 0].url!),
            );
            // CustomSnackbar.showSuccessToast("Copied to clipboard");
          }
          break;
        case "block":
          if (postModel.author != null) {
            await userController.toggleBlock(blockId: postModel.author!.id!);
          }
          break;
        case "delete":
          if (onDelete != null) onDelete.call();
          await postController.deletePost(
            postId: postModel.id!,
            isProfilePost: isProfilePost,
          );
          break;
        case "save":
          await postController.toggleSavePost(postId: postModel.id!);
          break;
      }
    },
    child: Icon(Icons.more_vert_outlined, size: 20, color: iconColor),
  );
}
