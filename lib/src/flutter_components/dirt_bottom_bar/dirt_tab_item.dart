import 'package:flutter/material.dart';

class DirtTabItem<T> {
  /// Tab text.
  final String? title;

  final T icon;

  /// Optional if not provided ,[icon] is used.
  final T? activeIcon;

  /// Whether icon should blend with color.
  /// If [icon] is instance of [IconData] then blend is default to true, otherwise false
  final bool blend;

  ///OntTap Function
  final Function(int index) onTap;

  /// Create item
  const DirtTabItem({
    this.title,
    required this.icon,
    required this.onTap,
    this.activeIcon,
    bool? isIconBlend,
  })  : assert(icon is IconData || icon is Widget, 'TabItem only support IconData and Widget'),
        blend = isIconBlend ?? (icon is IconData);
}
