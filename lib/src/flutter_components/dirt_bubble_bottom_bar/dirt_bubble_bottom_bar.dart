import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:dirt_arch/src/flutter_components/dirt_bubble_bottom_bar/dirt_bubble_bottom_bar_item.dart';
import 'package:flutter/material.dart';

class DirtBubbleBottomBar extends StatefulWidget {
  final void Function(int)? onTap;
  final List<BubbleBottomBarItem>? items;
  final bool hasNotch;
  final double elevation;
  final BubbleBottomBarFabLocation fabLocation;
  final List<DirtBubbleBottomBarItem>? onTapItems;

  const DirtBubbleBottomBar({
    super.key,
    this.onTap,
    this.items,
    this.hasNotch = true,
    this.elevation = 8,
    this.fabLocation = BubbleBottomBarFabLocation.end,
    this.onTapItems,
  }) : assert((onTapItems == null) || (items == null && onTap == null));

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
    return BubbleBottomBar(
      opacity: .2,
      currentIndex: currentIndex,
      onTap: (index) {
        changePage(index ?? 0);
        widget.onTapItems?[index ?? 0].onTap(index ?? 0);
      },
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      elevation: widget.elevation,
      fabLocation: widget.fabLocation, //new
      hasNotch: widget.hasNotch, //new
      hasInk: true, //new, gives a cute ink effect
      inkColor: Colors.black12,
      //optional, uses theme color if not specified
      items: widget.onTapItems
              ?.map(
                (item) => BubbleBottomBarItem(
                  icon: item.icon,
                  title: item.title,
                  activeIcon: item.activeIcon,
                  backgroundColor: item.backgroundColor,
                ),
              )
              .toList() ??
          [],
    );
  }
}
