import 'package:codegen/codegen.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:codegen/model/topic/topic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/constants/string_constants.dart';
import 'package:newsapp/src/common/utils/dialog/news_app_dialogs.dart';
import 'package:newsapp/src/common/utils/enums/language_enum.dart';
import 'package:newsapp/src/common/utils/enums/my_account.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/other/circular_progress.dart';
import 'package:newsapp/src/common/widget/other/decorated_container.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/domain/theme/theme_repository.dart';
import 'package:newsapp/src/presentation/profile/profile_viewmodel.dart';

part 'profile_mixin.dart';

@immutable
final class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const _AppBar(), body: _Body());
  }
}

@immutable
final class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Builder(
        builder: (context) {
          return LuciText.titleMedium(
            tr(LocaleKeys.myAccount),
            fontWeight: FontWeight.bold,
            textColor: AppTheme.primaryColor,
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

@immutable
final class _Body extends StatelessWidget with ProfileMixin {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return viewmodel.currentUser == null
            ? const AdaptiveCircular.withoutExpanded()
            : ListView(
                children: [
                  verticalBox16,
                  _UserDetails(),
                  verticalBox16,
                  _AccountSections(),
                ],
              );
      },
    );
  }
}

@immutable
final class _UserDetails extends StatelessWidget with ProfileMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: StringConstants.profileImage,
          child: GestureDetector(
            onTap: () => showProfileImageDialog(context),
            child: CircleAvatar(
              radius: 75,
              backgroundImage: Assets.images.onboard2.toFit.image,
              onBackgroundImageError: (exception, stackTrace) {
                // error handle edilecek
              },
            ),
          ),
        ),
        verticalBox12,
        LuciText.titleSmall(
          viewmodel.currentUser?.name ?? LocaleKeys.unknown.tr(),
          fontWeight: FontWeight.bold,
        ),
        verticalBox4,
        LuciText.bodyMedium(
          viewmodel.currentUser?.email ?? LocaleKeys.exampleGmail.tr(),
        ),
        verticalBox16,
        const _EditButton(),
      ],
    );
  }
}

@immutable
final class _EditButton extends StatelessWidget {
  const _EditButton();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.brightnessOf(context) == AppTheme.darkTheme.brightness;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: NaPadding.pagePadding,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: const BorderSide(color: AppTheme.placeholder),
      ),
      child: LuciText.bodyLarge(
        textColor: isDark ? AppTheme.bodyDark : AppTheme.bodyText,
        LocaleKeys.editProfile.tr(),
        fontWeight: FontWeight.bold,
      ),
      onPressed: () => router.pushNamed(RoutePaths.editProfile.name),
    );
  }
}

@immutable
final class _AccountSections extends StatelessWidget with ProfileMixin {
  @override
  Widget build(BuildContext context) {
    viewmodel.getLocale(context);
    return Padding(
      padding: NaPadding.pagePadding,
      child: Column(
        children: [
          const _DarkmodeSwitch(),
          verticalBox12,
          _LanguageSection(viewmodel: viewmodel),
          verticalBox12,
          MyAccountSection(
            item: MyAccountEnum.help,
            onPressed: () => router.pushNamed(RoutePaths.help.name),
          ),
          verticalBox12,
          MyAccountSection(
            item: MyAccountEnum.logOut,
            onPressed: () => _showLogOutDialog(context),
          ),
        ],
      ),
    );
  }
}

class _LanguageSection extends StatefulWidget {
  const _LanguageSection({required this.viewmodel});

  final ProfileViewModel viewmodel;

  @override
  State<_LanguageSection> createState() => _LanguageSectionState();
}

class _LanguageSectionState extends State<_LanguageSection> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return MyAccountSection(
          item: MyAccountEnum.language,
          onPressed: () {},
          leading: Icons.language_outlined,
          trailing: DropdownButton<LanguageEnum>(
            borderRadius: BorderRadius.circular(16),
            value: widget.viewmodel.currentLanguage,
            underline: emptyBox,
            items: LanguageEnum.values
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: LuciText.bodyMedium(e.title),
                  ),
                )
                .toList(),
            onChanged: (value) {
              widget.viewmodel.changeLanguage(
                context: context,
                language: value!,
              );
            },
          ),
        );
      },
    );
  }
}

@immutable
final class _DarkmodeSwitch extends StatelessWidget {
  const _DarkmodeSwitch();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeRepository.instance.themeNotifier,
      builder: (context, value, child) {
        final isDark =
            Theme.brightnessOf(context) == AppTheme.darkTheme.brightness;
        return MyAccountSection(
          item: MyAccountEnum.darkMode,
          onPressed: () => ThemeRepository.instance.setTheme(context),
          leading: isDark
              ? Icons.light_mode_outlined
              : Icons.dark_mode_outlined,
          trailing: Switch.adaptive(
            activeColor: AppTheme.primaryColor,
            value: isDark,
            onChanged: (_) => ThemeRepository.instance.setTheme(context),
          ),
        );
      },
    );
  }
}

@immutable
final class MyAccountSection extends StatelessWidget {
  const MyAccountSection({
    required this.item,
    required this.onPressed,
    super.key,
    this.trailing,
    this.leading,
  });
  final MyAccountEnum item;
  final VoidCallback onPressed;
  final Widget? trailing;
  final IconData? leading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed.call,
      child: DecoratedContainer(
        child: ListTile(
          contentPadding: NaPadding.horizontalPadding,
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(leading ?? item.icon, color: AppTheme.primaryColor),
          ),
          title: LuciText.bodyMedium(item.title),
          trailing: trailing ?? const Icon(Icons.chevron_right_outlined),
        ),
      ),
    );
  }
}
