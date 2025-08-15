import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/enums/contact.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/other/decorated_container.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/presentation/help/help_view.dart';

@immutable
final class ContactView extends StatelessWidget with ContactMixin {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: NaPadding.verticalPadding + NaPadding.pagePadding,
              separatorBuilder: (_, __) => verticalBox12,
              itemCount: Contact.values.length,
              itemBuilder: (context, index) {
                final contact = Contact.values[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => onPressed(contact),
                  child: DecoratedContainer(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: contact.icon,
                        ),
                        horizontalBox16,
                        Expanded(child: LuciText.bodyLarge(contact.title)),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppTheme.backgroundDark,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          LuciText.bodyLarge(LocaleKeys.contactUs.tr()),
          verticalBox16,
        ],
      ),
    );
  }
}
