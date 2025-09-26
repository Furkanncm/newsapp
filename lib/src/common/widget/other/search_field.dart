import 'package:codegen/gen/assets.gen.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/widget/sized_box/space_box.dart';
import 'package:newsapp/src/common/utils/extensions/asset_extensionss.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    this.onChanged,
    super.key,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.focusNode,
  });

  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.focusNode != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!widget.readOnly) {
          widget.focusNode!.requestFocus();
        }
      });
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode != null) {
      widget.focusNode!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      focusNode: widget.focusNode,
      controller: _controller,
      onChanged: (value) {
        widget.onChanged?.call(value);
        setState(() {});
      },
      decoration: InputDecoration(
        hintText: LocaleKeys.search.tr(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: Assets.uiKitImages.icQuestionmarkOutline.toIcon(32),
        suffixIcon: widget.controller?.text.isEmpty ?? true
            ? emptyBox
            : IconButton(
                onPressed: () {
                  _controller.clear();
                  widget.onChanged?.call('');
                  setState(() {});
                },
                icon: const Icon(Icons.clear, color: AppTheme.backgroundDark),
              ),
      ),
    );
  }
}
