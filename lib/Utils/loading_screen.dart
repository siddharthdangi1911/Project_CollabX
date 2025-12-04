import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    useRootNavigator: true,
    builder: (_) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
