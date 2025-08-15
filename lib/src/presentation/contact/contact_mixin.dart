part of '../help/help_view.dart';

mixin ContactMixin on StatelessWidget {
  void onPressed(Contact contact) {
    switch (contact) {
      case Contact.instagram:
        LuciUrlLauncher.instance.launchURL(
          appUrl: contact.appUrl,
          webUrl: contact.webUrl,
        );
      case Contact.twitter:
        LuciUrlLauncher.instance.launchURL(
          appUrl: contact.appUrl,
          webUrl: contact.webUrl,
        );
      case Contact.email:
        LuciUrlLauncher.instance.launchURL(
          appUrl: contact.appUrl,
          webUrl: contact.webUrl,
        );
    }
  }
}
