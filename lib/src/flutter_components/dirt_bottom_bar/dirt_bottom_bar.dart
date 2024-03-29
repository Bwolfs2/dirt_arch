import 'package:dirt_arch/dirt_arch.dart';
import 'package:flutter/material.dart';

class DirtBottomBar extends StatefulWidget {
  final List<TabItem>? items;
  final void Function(int)? onTap;
  final Color? backgroundColor;
  final int? elevation;
  final Color? activeColor;
  final List<DirtTabItem>? onTapItems;
  final Map<int, dynamic>? badge;

  const DirtBottomBar({
    super.key,
    this.onTap,
    this.backgroundColor,
    this.elevation,
    this.activeColor,
    this.items,
    this.onTapItems,
    this.badge,
  }) : assert((onTapItems == null) || (items == null && onTap == null));
  @override
  _DirtBottomBarState createState() => _DirtBottomBarState();
}

class _DirtBottomBarState extends State<DirtBottomBar> {
  @override
  Widget build(BuildContext context) {
    if (widget.badge != null) {
      return ConvexAppBar.badge(
        widget.badge!,
        backgroundColor: widget.backgroundColor ?? Theme.of(context).primaryColor,
        initialActiveIndex: 1,
        items: widget.onTapItems
                ?.map(
                  (tabItem) => TabItem(
                    title: tabItem.title,
                    icon: tabItem.icon,
                    activeIcon: tabItem.activeIcon,
                    isIconBlend: tabItem.icon is IconData,
                  ),
                )
                .toList() ??
            [],
        onTap: (index) => widget.onTapItems?[index].onTap(index),
        elevation: (widget.elevation ?? 1.0).toDouble(),
        activeColor: widget.activeColor ?? Colors.white,
      );
    }

    return ConvexAppBar(
      backgroundColor: widget.backgroundColor ?? Theme.of(context).primaryColor,
      initialActiveIndex: 1,
      items: widget.onTapItems
              ?.map(
                (tabItem) => TabItem(
                  title: tabItem.title,
                  icon: tabItem.icon,
                  activeIcon: tabItem.activeIcon,
                  isIconBlend: tabItem.icon is IconData,
                ),
              )
              .toList() ??
          [],
      onTap: (index) => widget.onTapItems?[index].onTap(index),
      elevation: (widget.elevation ?? 1).toDouble(),
      activeColor: widget.activeColor ?? Colors.white,
    );
  }
}
