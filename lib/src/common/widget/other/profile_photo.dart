import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/widget/bottom_sheet/image_picker_bottom_sheet.dart';
import 'package:newsapp/src/common/utils/extensions/future_extension.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';
import 'package:share_plus/share_plus.dart';

@immutable
final class PhotoWithCameraIcon extends StatefulWidget {
  const PhotoWithCameraIcon({super.key});

  @override
  State<PhotoWithCameraIcon> createState() => _PhotoWithCameraIconState();
}

class _PhotoWithCameraIconState extends State<PhotoWithCameraIcon> {
  late final IUserRepository _userRepository;
  late String? imagePath;

  @override
  void initState() {
    super.initState();
    _userRepository = UserRepository();
    imagePath = _userRepository.currentUser?.profilePhoto;
  }

  Future<void> onCameraIconPressed() async {
    final isLightTheme = Theme.brightnessOf(context) == Brightness.light;
    final result = await ImagePickerBottomSheet().showImagePickerBottomSheet(
      context: context,
      locale: context.locale,
      showDragHandle: true,
      bottomSheetBackgroundColor: isLightTheme
          ? AppTheme.buttonBackground
          : AppTheme.backgroundDark,
      iconColor: AppTheme.primaryColor,
      buttonBackgroundColor: isLightTheme
          ? AppTheme.bodyDark
          : AppTheme.inputDark,
    );
    if (result == null || !mounted) return;
    final file = result.path;
    final response = await _userRepository
        .updateProfilePhoto(file)
        .withIndicator(context);
    imagePath = response?.data;
    if (imagePath != null) {
      await _userRepository.getUserInfo();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onCameraIconPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (imagePath == null || (imagePath?.isEmpty ?? true))
              const _EmptyProfilePhoto()
            else
              ProfilePhoto(imagepath: imagePath!),
            const CameraIcon(),
          ],
        ),
      ),
    );
  }
}

@immutable
final class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    required this.imagepath,
    this.height = 150,
    this.radius,
    super.key,
  });

  final String imagepath;
  final double height;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final avatarRadius = radius ?? height / 2;
    final imageFile = XFile(imagepath);
    return ValueListenableBuilder<XFile>(
      valueListenable: ValueNotifier<XFile>(imageFile),
      builder: (context, imageFileValue, child) {
        Widget childWidget;
        if (imageFileValue.path.isEmpty) {
          childWidget = const _EmptyProfilePhoto();
        } else if (imageFileValue.path.startsWith('http')) {
          childWidget = Image.network(
            imageFileValue.path,
            fit: BoxFit.cover,
            width: height,
            height: height,
            errorBuilder: (context, error, stack) => Icon(
              Icons.person,
              size: avatarRadius,
              color: AppTheme.buttonText,
            ),
          );
        } else {
          final file = File(imageFileValue.path);
          if (!file.existsSync()) {
            return const _EmptyProfilePhoto();
          }
          childWidget = Image.file(
            file,
            fit: BoxFit.cover,
            width: height,
            height: height,
          );
        }

        return CircleAvatar(
          radius: avatarRadius,
          backgroundColor: AppTheme.buttonText.withValues(alpha: .3),
          child: ClipOval(child: childWidget),
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

class _EmptyProfilePhoto extends StatelessWidget {
  const _EmptyProfilePhoto();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 75,
      child: ClipOval(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Icon(Icons.person, size: 75, color: AppTheme.bodyText),
        ),
      ),
    );
  }
}
