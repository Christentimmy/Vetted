import 'dart:io';
import 'package:Vetted/app/controller/post_controller.dart';
import 'package:Vetted/app/data/models/post_model.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/utils/image_picker.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CreatePostController extends GetxController {
  final RxString selectedCity = ''.obs;
  final RxBool isLoading = false.obs;

  final RxBool isChecked = false.obs;
  final RxList<File> images = <File>[].obs;

  final textController = TextEditingController();
  final titleController = TextEditingController();

  final firstNameController = TextEditingController();
  final ageController = TextEditingController();
  final captionController = TextEditingController();

  final RxList<TextEditingController> options =
      [TextEditingController(), TextEditingController()].obs;

  void addOption() {
    options.add(TextEditingController());
  }

  void removeOption(int index) {
    if (options.length > 2) {
      options[index].dispose();
      options.removeAt(index);
    } else {
      CustomSnackbar.showErrorToast("A poll must have at least 2 options");
    }
  }

  void selectImages() async {
    final im = await pickMultipleImages();
    if (im == null) return;
    images.addAll(im.where((file) => !images.contains(file)));
  }

  void removeImage(int index) {
    images.removeAt(index);
  }

  void createRegularPost({required GlobalKey<FormState> formKey}) async {
    isLoading.value = true;
    try {
      HapticFeedback.lightImpact();
      if (!formKey.currentState!.validate()) return;
      final postController = Get.find<PostController>();
      final postModel = PostModel(
        postType: "regular",
        content: Content(
          title: titleController.text,
          text: textController.text,
        ),
      );
      await postController.createPost(postModel: postModel);
      await Get.find<PostController>().getFeedCommunity(showLoader: false);
      Get.offAllNamed(
        AppRoutes.bottomNavigationWidget,
        arguments: {"index": 1},
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void createPost({required GlobalKey<FormState> formKey}) async {
    isLoading.value = true;
    try {
      HapticFeedback.lightImpact();
      if (selectedCity.value.isEmpty) {
        CustomSnackbar.showErrorToast("Please select a city");
        return;
      }
      if (images.isEmpty) {
        CustomSnackbar.showErrorToast("Please add at least one image");
        return;
      }
      if (!isChecked.value) {
        CustomSnackbar.showErrorToast("Please accept the terms and conditions");
        return;
      }
      if (!formKey.currentState!.validate()) return;
      final postController = Get.find<PostController>();
      final postModel = PostModel(
        personName: firstNameController.text,
        personLocation: selectedCity.value,
        personAge: ageController.text,
        postType: "woman",
        content: Content(text: captionController.text),
      );
      await postController.createPost(postModel: postModel, files: images);
      Get.offAllNamed(AppRoutes.bottomNavigationWidget);
      Get.find<PostController>().getFeed(showLoader: false, type: "woman");
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  bool validatePoll() {
    if (textController.text.trim().isEmpty) {
      CustomSnackbar.showErrorToast("Please enter a question for your poll");
      return false;
    }

    // Check if at least 2 options have text
    int filledOptions = 0;
    for (var controller in options) {
      if (controller.text.trim().isNotEmpty) {
        filledOptions++;
      }
    }

    if (filledOptions < 2) {
      CustomSnackbar.showErrorToast("Please fill at least 2 poll options");
      return false;
    }

    return true;
  }

  void createPollPost() async {
    isLoading.value = true;
    try {
      HapticFeedback.lightImpact();
      if (!validatePoll()) return;
      List<PollOptions> pollOptions =
          options
              .map((controller) => PollOptions(text: controller.text.trim()))
              .where(
                (text) => text.text != null && text.text?.isNotEmpty == true,
              )
              .toList();
      final poll = Poll(question: textController.text, options: pollOptions);
      final postController = Get.find<PostController>();
      final postModel = PostModel(postType: "regular", poll: poll);
      await postController.createPost(postModel: postModel);
      await Get.find<PostController>().getFeedCommunity(showLoader: false);
      Get.offAllNamed(
        AppRoutes.bottomNavigationWidget,
        arguments: {"index": 1},
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  final List<String> states =
      [
        "Alabama",
        "Alaska",
        "Arizona",
        "Arkansas",
        "California",
        "Colorado",
        "Connecticut",
        "Delaware",
        "Florida",
        "Georgia",
        "Hawaii",
        "Idaho",
        "Illinois",
        "Indiana",
        "Iowa",
        "Kansas",
        "Kentucky",
        "Louisiana",
        "Maine",
        "Maryland",
        "Massachusetts",
        "Michigan",
        "Minnesota",
        "Mississippi",
        "Missouri",
        "Montana",
        "Nebraska",
        "Nevada",
        "New Hampshire",
        "New Jersey",
        "New Mexico",
        "New York",
        "North Carolina",
        "North Dakota",
        "Ohio",
        "Oklahoma",
        "Oregon",
        "Pennsylvania",
        "Rhode Island",
        "South Carolina",
        "South Dakota",
        "Tennessee",
        "Texas",
        "Utah",
        "Vermont",
        "Virginia",
        "Washington",
        "West Virginia",
        "Wisconsin",
        "Wyoming",
      ].obs;

  @override
  void onClose() {
    textController.dispose();
    titleController.dispose();
    firstNameController.dispose();
    ageController.dispose();
    captionController.dispose();
    super.onClose();
  }
}
