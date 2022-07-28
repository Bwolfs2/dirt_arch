import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

class DirtSnackBar extends SnackBar {
  DirtSnackBar._(Key? key, String content, Color background, {IconData? icon, super.action})
      : super(
          key: key,
          backgroundColor: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              4,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 20,
                ),
                const SizedBox(width: 10)
              ],
              Expanded(
                child: Text(
                  content,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              if (action == null)
                const InkWell(
                  onTap: asuka.hideCurrentSnackBar,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                )
            ],
          ),
        );

  factory DirtSnackBar.warning(String content, {Key? key}) => DirtSnackBar._(key, content, const Color(0xffD9822B), icon: Icons.warning);

  factory DirtSnackBar.error(String content, {Key? key}) => DirtSnackBar._(key, content, const Color(0xffD13913), icon: Icons.error);

  factory DirtSnackBar.message(String content, {Key? key, SnackBarAction? snackBarAction}) => DirtSnackBar._(key, content, const Color(0xffFFFFFF), action: snackBarAction);

  factory DirtSnackBar.done(String content, {Key? key, SnackBarAction? snackBarAction}) => DirtSnackBar._(key, content, const Color(0xff0F9960), action: snackBarAction);

  void call() => show();

  void show() => asuka.showSnackBar(this);
}
