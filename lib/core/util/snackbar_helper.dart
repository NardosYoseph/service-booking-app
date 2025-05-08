import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

void showSnackbar({
  required String title,
  required String message,
  bool isError = false,
}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: isError ? AppColors.error : AppColors.lightPrimary,
    colorText: Colors.white,
    margin: const EdgeInsets.all(12),
    borderRadius: 12,
    duration: const Duration(seconds: 3),
    icon: Icon(
      isError ? Icons.error : Icons.check_circle,
      color: Colors.white,
    ),
    titleText: Text(
      title,
      style: AppTextStyles.headline.copyWith(color: Colors.white, fontSize: 16),
    ),
    messageText: Text(
      message,
      style: AppTextStyles.body.copyWith(color: Colors.white),
    ),
  );
}
