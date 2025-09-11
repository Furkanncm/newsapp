part of 'profile_view.dart';

mixin ProfileMixin on StatelessWidget {
  final ProfileViewModel viewmodel = ProfileViewModel();

  void showProfileImageDialog(BuildContext context) {
    showAdaptiveDialog<void>(
      barrierColor: Colors.black,
      context: context,
      builder: (context) {
        return Hero(
          tag: StringConstants.profileImage,
          child: Dialog(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            child: ClipRect(
              child: SizedBox(
                height: 300,
                child: Assets.images.onboard2.image(
                  package: LocaleKeys.packageName.tr(),
                  fit: BoxFit.cover,
                ),
              ),
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
