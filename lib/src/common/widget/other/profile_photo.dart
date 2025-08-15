import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:share_plus/share_plus.dart';

@immutable
final class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({required this.imageFile, super.key});

  final ValueNotifier<XFile?> imageFile;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<XFile?>(
      valueListenable: imageFile,
      builder: (context, imageFileValue, child) {
        return CircleAvatar(
          radius: 75,
          backgroundColor: AppTheme.buttonText.withValues(alpha: .3),
          child: imageFileValue != null
              ? ClipOval(
                  child: Image.file(
                    File(imageFileValue.path),
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
                )
              : const Icon(
                  Icons.person,
                  size: 80,
                  color: AppTheme.surfaceColor,
                ),
        );
      },
    );
  }
}

@immutable
final class CameraIcon extends StatelessWidget {
  const CameraIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 4,
      right: 8,
      child: ClipOval(
        child: Container(
          height: 40,
          width: 40,
          color: AppTheme.primaryColor,
          child: const Icon(
            Icons.camera_alt_outlined,
            color: AppTheme.surfaceColor,
          ),
        ),
      ),
    );
  }
}

class PhotoChange extends StatelessWidget {
  const PhotoChange({
    required this.onPressed,
    required this.imageFile,
    super.key,
  });

  final VoidCallback onPressed;
  final ValueNotifier<XFile?> imageFile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ProfilePhoto(imageFile: imageFile),
            const CameraIcon(),
          ],
        ),
      ),
    );
  }
}
