import 'package:easy_localization/easy_localization.dart';

enum GenderEnum {
  male('Male'),
  female('Female'),
  other('Other');

  const GenderEnum(this.label);
  final String label;
  String get value => label.tr();
}
