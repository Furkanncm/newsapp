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
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: ListTile(
                dense: true,
                visualDensity: VisualDensity.compact,
                contentPadding: NaPadding.zeroPadding,
                leading: Container(
                  padding: NaPadding.zeroPadding,
                  margin: NaPadding.zeroPadding,
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  ),
                  child: Icon(question.icon, color: AppTheme.primaryColor),
                ),
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
