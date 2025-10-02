part of 'profile_view.dart';

mixin ProfileMixin on StatelessWidget {
  final ProfileViewModel viewmodel = ProfileViewModel();

  void showProfileImageDialog(BuildContext context, String imagePath) {
    showAdaptiveDialog<void>(
      barrierColor: Colors.transparent.withValues(alpha: 0.7),

      context: context,
      builder: (context) {
        return Hero(
          tag: StringConstants.profileImage,
          child: Dialog(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(150),
            ),
            child: ProfilePhoto(
              imagepath: imagePath,
              height: context.height * 0.4,
              radius: 150,
            ),
          ),
        );
      },
    );
  }

  Future<void> _showLogOutDialog(BuildContext context) async {
    await NewsAppDialogs.logOutDialog(
      context: context,
      title: LocaleKeys.logOut.tr(),
      content: LocaleKeys.logOutConfirm.tr(),

      onPositiveButton: () async {
        await viewmodel.logOut();
        router.goNamed(RoutePaths.login.name);
      },
    );
  }
}
