import 'package:flutter/material.dart';
import '../helpers/popup_helper.dart';

class MenuButton extends StatelessWidget {
  final String label;
  final String? popupText; // Tornado opcional
  final VoidCallback? onPressed; // Novo parâmetro

  const MenuButton({
    Key? key,
    required this.label,
    this.popupText, // Opcional agora
    this.onPressed, // Nova ação personalizada
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 110,
      child: ElevatedButton(
        onPressed: onPressed ?? () {
          // Mostra popup apenas se houver texto
          if (popupText != null) {
            PopupHelper.showPopup(context, popupText!);
          }
        },
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: Text(label, textAlign: TextAlign.center),
      ),
    );
  }
}