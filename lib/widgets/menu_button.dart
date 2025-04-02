import 'package:flutter/material.dart';
import '../helpers/popup_helper.dart';

class MenuButton extends StatelessWidget {
  final String label;
  final String popupText;

  const MenuButton({Key? key, required this.label, required this.popupText})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 110,
      child: ElevatedButton(
        onPressed: () {
          PopupHelper.showPopup(context, popupText);
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Botão com cantos quadrados
          ),
        ),
        child: Text(label, textAlign: TextAlign.center),
      ),
    );
  }
}
