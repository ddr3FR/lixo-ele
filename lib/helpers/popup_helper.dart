import 'package:flutter/material.dart';

class PopupHelper {
  static void showPopup(BuildContext context, String popupText) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: Text(popupText),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Fechar'),
              ),
            ],
          ),
    );
  }
}
