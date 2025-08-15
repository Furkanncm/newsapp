import 'package:codegen/codegen.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/constants/contact_links.dart';
import 'package:newsapp/src/common/utils/extensions/asset_extensionss.dart';

enum Contact {
  email(LocaleKeys.email),
  instagram(LocaleKeys.instagram),
  twitter(LocaleKeys.twitter);

  const Contact(this.key);
  final String key;

  String get title => key.tr();

  Image get icon {
    switch (this) {
      case Contact.email:
        return Assets.images.icGoogle.toIcon(44);
      case Contact.instagram:
        return Assets.images.icInstagram.toIcon(44);
      case Contact.twitter:
        return Assets.images.icX.toIcon(44);
    }
  }

  String get webUrl {
    switch (this) {
      case Contact.email:
        return ContactLinks.emailWeb;
      case Contact.instagram:
        return ContactLinks.instagramWeb;
      case Contact.twitter:
        return ContactLinks.twitterWeb;
    }
  }

  String get appUrl {
    switch (this) {
      case Contact.email:
        return ContactLinks.emailApp;
      case Contact.instagram:
        return ContactLinks.instagramApp;
      case Contact.twitter:
        return ContactLinks.twitterApp;
    }
  }
}
