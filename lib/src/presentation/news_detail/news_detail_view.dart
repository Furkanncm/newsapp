import 'package:flutter/material.dart';
import 'package:lucielle/widget/text/luci_text.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';

@immutable
final class NewsDetailView extends StatelessWidget {
  const NewsDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: NaPadding.pagePadding,
        child: Center(
          child: LuciText.displayMedium('dadadada'),
        ),
      ),
    );
  }
}
