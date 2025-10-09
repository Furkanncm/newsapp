import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/button/na_button.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/presentation/onboard/onboard_mixin.dart';
import 'package:newsapp/src/presentation/onboard/onboard_model.dart';

@immutable
final class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> with OnboardMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      right: false,
      left: false,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 9,
              child: PageView.builder(
                controller: pageController,
                onPageChanged: pageChanged,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: onboardList.length,
                itemBuilder: (context, index) {
                  final item = onboardList[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ImageField(item: item),
                      HeaderAndDescriptionField(item: item),
                    ],
                  );
                },
              ),
            ),
      
            Expanded(
              child: Padding(
                padding: NaPadding.pagePadding,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding:  NaPadding.zeroPadding,
                        shrinkWrap: true,
                        itemCount: onboardList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: NaPadding.onboardCounterPadding,
                            child: ValueListenableBuilder<int>(
                              valueListenable: currentPageNotifier,
                              builder: (context, value, child) {
                                return CircleAvatar(
                                  radius: index == value ? 8 : 4,
                                  backgroundColor: index == value
                                      ? AppTheme.primaryColor
                                      : AppTheme.buttonText,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: isFirstPage,
                      builder: (context, value, child) {
                        return Visibility(
                          visible: !value,
                          child: TextButton(
                            onPressed: backPage,
                            child: LuciText.labelSmall(LocaleKeys.back.tr()),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: isLastPage,
                      builder: (context, value, child) {
                        return NewsButton(
                          text: value
                              ? LocaleKeys.getStarted.tr()
                              : LocaleKeys.next.tr(),
                          onPressed: nextPage,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@immutable
final class _ImageField extends StatelessWidget {
  const _ImageField({required this.item});

  final OnboardModel item;

  @override
  Widget build(BuildContext context) {
    return item.image ?? const Icon(Icons.error_outline_outlined);
  }
}

@immutable
final class HeaderAndDescriptionField extends StatelessWidget {
  const HeaderAndDescriptionField({required this.item, super.key});

  final OnboardModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: NaPadding.pagePadding,
      child: Column(
        children: [
          LuciText.titleMedium(item.header ?? '', fontWeight: FontWeight.bold),
          verticalBox12,
          LuciText.bodyMedium(item.description ?? ''),
        ],
      ),
    );
  }
}
