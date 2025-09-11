import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: kElevationToShadow[4],
          color: Colors.white,
        ),
        width: 75,
        height: 75,
        child: const Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
