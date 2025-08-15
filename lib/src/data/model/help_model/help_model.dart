import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HelpModel {
  HelpModel({required this.icon, required this.question, required this.answer});

  final IconData icon;
  final String question;
  final String answer;

  static List<HelpModel> getQuestions = [
    HelpModel(
      icon: Icons.notifications,
      question: LocaleKeys.notifications_question.tr(),
      answer: LocaleKeys.notifications_answer.tr(),
    ),
    HelpModel(
      icon: Icons.bookmark,
      question: LocaleKeys.bookmarks_question.tr(),
      answer: LocaleKeys.bookmarks_answer.tr(),
    ),
    HelpModel(
      icon: Icons.dark_mode,
      question: LocaleKeys.darkmode_question.tr(),
      answer: LocaleKeys.darkmode_answer.tr(),
    ),
    HelpModel(
      icon: Icons.wifi_off,
      question: LocaleKeys.offline_question.tr(),
      answer: LocaleKeys.offline_answer.tr(),
    ),
    HelpModel(
      icon: Icons.share,
      question: LocaleKeys.share_question.tr(),
      answer: LocaleKeys.share_answer.tr(),
    ),
  ];
}
