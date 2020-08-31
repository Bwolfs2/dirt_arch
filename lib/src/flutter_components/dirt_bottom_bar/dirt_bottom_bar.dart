import 'package:flutter/material.dart';

import '../../../dirt_arch.dart';
import 'dirt_tab_item.dart';

class DirtBottomBar extends StatefulWidget {
  final List<TabItem> items;
  final void Function(int) onTap;
  final Color backgroundColor;
  final int elevation;
  final Color activeColor;
  final List<DirtTabItem> onTapItems;
  final Map<int, dynamic> badge;

  const DirtBottomBar({
    Key key,
    this.onTap,
    this.backgroundColor,
    this.elevation,
    this.activeColor,
    this.items,
    this.onTapItems,
    this.badge,
  })  : assert((items != null && onTapItems == null && onTap != null) ||
            (onTapItems != null && items == null && onTap == null)),
        super(key: key);
  @override
  _DirtBottomBarState createState() => _DirtBottomBarState();
}

class _DirtBottomBarState extends State<DirtBottomBar> {
  @override
  Widget build(BuildContext context) {
    if (widget.onTapItems != null) {
      if (widget.badge != null) {
        return ConvexAppBar.badge(
          widget.badge,
          backgroundColor:
              widget.backgroundColor ?? Theme.of(context).primaryColor,
          initialActiveIndex: 1,
          items: widget.onTapItems
              .map((tabItem) => TabItem(
                    title: tabItem.title,
                    icon: tabItem.icon,
                    activeIcon: tabItem.activeIcon,
                    isIconBlend: (tabItem.icon is IconData),
                  ))
              .toList(),
          onTap: (index) => widget.onTapItems[index].onTap(index),
          elevation: widget.elevation ?? 1,
          activeColor: widget.activeColor ?? Colors.white,
        );
      }

      return ConvexAppBar(
        backgroundColor:
            widget.backgroundColor ?? Theme.of(context).primaryColor,
        initialActiveIndex: 1,
        items: widget.onTapItems
            .map((tabItem) => TabItem(
                  title: tabItem.title,
                  icon: tabItem.icon,
                  activeIcon: tabItem.activeIcon,
                  isIconBlend: (tabItem.icon is IconData),
                ))
            .toList(),
        onTap: (index) => widget.onTapItems[index].onTap(index),
        elevation: widget.elevation ?? 1,
        activeColor: widget.activeColor ?? Colors.white,
      );
    }

    if (widget.badge != null) {
      return ConvexAppBar.badge(
        widget.badge,
        initialActiveIndex: 1,
        backgroundColor:
            widget.backgroundColor ?? Theme.of(context).primaryColor,
        items: widget.items,
        onTap: widget.onTap,
        elevation: widget.elevation ?? 1,
        activeColor: widget.activeColor ?? Colors.white,
      );
    }

    return ConvexAppBar(
      initialActiveIndex: 1,
      backgroundColor: widget.backgroundColor ?? Theme.of(context).primaryColor,
      items: widget.items,
      onTap: widget.onTap,
      elevation: widget.elevation ?? 1,
      activeColor: widget.activeColor ?? Colors.white,
    );
  }
}
