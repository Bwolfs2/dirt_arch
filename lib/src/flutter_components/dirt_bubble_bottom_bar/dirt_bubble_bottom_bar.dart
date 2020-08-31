import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

import 'dirt_bubble_bottom_bar_item.dart';

class DirtBubbleBottomBar extends StatefulWidget {
  final void Function(int) onTap;
  final List<BubbleBottomBarItem> items;
  final bool hasNotch;
  final double elevation;
  final BubbleBottomBarFabLocation fabLocation;
  final List<DirtBubbleBottomBarItem> onTapItems;

  const DirtBubbleBottomBar({
    Key key,
    this.onTap,
    this.items,
    this.hasNotch = true,
    this.elevation = 8,
    this.fabLocation = BubbleBottomBarFabLocation.end,
    this.onTapItems,
  })  : assert((items != null && onTapItems == null && onTap != null) ||
            (onTapItems != null && items == null && onTap == null)),
        super(key: key);

  @override
  _DirtBubbleBottomBarState createState() => _DirtBubbleBottomBarState();
}

class _DirtBubbleBottomBarState extends State<DirtBubbleBottomBar> {
  int currentIndex = 0;
  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onTapItems != null) {
      return BubbleBottomBar(
        opacity: .2,
        currentIndex: currentIndex,
        onTap: (index) {
          changePage(index);
          widget.onTapItems[index].onTap(index);
        },
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: widget.elevation,
        fabLocation: widget.fabLocation, //new
        hasNotch: widget.hasNotch, //new
        hasInk: true, //new, gives a cute ink effect
        inkColor: Colors.black12,
        //optional, uses theme color if not specified
        items: widget.onTapItems
            .map((item) => BubbleBottomBarItem(
                icon: item.icon,
                title: item.title,
                activeIcon: item.activeIcon,
                backgroundColor: item.backgroundColor))
            .toList(),
      );
    }

    return BubbleBottomBar(
      opacity: .2,
      currentIndex: currentIndex,
      onTap: (index) {
        changePage(index);
        widget.onTap?.call(index);
      },
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      elevation: widget.elevation,
      fabLocation: widget.fabLocation, //new
      hasNotch: widget.hasNotch, //new
      hasInk: true, //new, gives a cute ink effect
      inkColor: Colors.black12, //optional, uses theme color if not specified
      items: widget.items,
    );
  }
}
