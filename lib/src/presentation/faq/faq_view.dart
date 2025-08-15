import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/other/decorated_container.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/data/model/help_model/help_model.dart';

@immutable
final class FAQView extends StatelessWidget {
  FAQView({super.key});

  final List<HelpModel> questionList = HelpModel.getQuestions;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => verticalBox12,
      padding: NaPadding.verticalPadding + NaPadding.pagePadding,
      itemCount: questionList.length,
      itemBuilder: (context, index) {
        final question = questionList[index];
        return Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: DecoratedContainer(
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 16),
              collapsedBackgroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              childrenPadding: NaPadding.pagePadding,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              iconColor: AppTheme.bodyDark,
              collapsedIconColor: AppTheme.backgroundDark,
              title: ListTile(
                dense: true,
                visualDensity: VisualDensity.compact,
                contentPadding: NaPadding.zeroPadding,
                leading: Icon(question.icon, color: AppTheme.primaryColor),
                title: LuciText.bodyLarge(question.question),
              ),
              children: [LuciText.bodyMedium(question.answer)],
            ),
          ),
        );
      },
    );
  }
}
