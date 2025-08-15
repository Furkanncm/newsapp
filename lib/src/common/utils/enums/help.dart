import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/presentation/contact/contact_view.dart';
import 'package:newsapp/src/presentation/faq/faq_view.dart';

enum Help {
  faq(LocaleKeys.faq),
  contact(LocaleKeys.contact);

  const Help(this.key);
  final String key;

  String get title => key.tr();

  Widget get page => switch (this) {
    Help.faq => FAQView(),
    Help.contact => const ContactView(),
  };
}
