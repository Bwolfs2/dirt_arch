import 'package:flutter/material.dart';

class DirtBubbleBottomBarItem {
  const DirtBubbleBottomBarItem({
    @required this.icon,
    @required this.onTap,
    this.title,
    Widget activeIcon,
    this.backgroundColor,
  })  : activeIcon = activeIcon ?? icon,
        assert(icon != null);
  final Widget icon;
  final Widget activeIcon;
  final Widget title;
  final Color backgroundColor;

  ///OntTap Function
  final Function(int index) onTap;
}
