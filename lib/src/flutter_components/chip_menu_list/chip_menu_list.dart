import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chip_menu_item.dart';
import 'measure_size.dart';

class ChipMenuList<T> extends StatefulWidget {
  final List<ChipMenuItem<T>> items;
  final void Function(T clickedItem)? onTap;
  final Color? backgroundColor;
  final double? elevation;
  final Color? activeColor;
  final bool useTips;

  const ChipMenuList({
    Key? key,
    required this.items,
    this.onTap,
    this.backgroundColor,
    this.elevation,
    this.activeColor,
    this.useTips = false,
  }) : super(key: key);

  @override
  _ChipMenuListState<T> createState() => _ChipMenuListState<T>();
}

class _ChipMenuListState<T> extends State<ChipMenuList<T>> {
  var selectedIndex = 0;
  late Size size;
  late Size totalSize;

  List<Size> childSizes = [];
  double sizeUntilIndex(int index) {
    var totalSize = 0.0;
    for (var i = 0; i < index; i++) {
      totalSize += childSizes[i].width + padding * 2;
    }

    return totalSize;
  }

  double padding = 5.0;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.backgroundColor ?? Colors.transparent,
        height: 50,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          scrollDirection: Axis.horizontal,
          child: Stack(
            children: [
              if (childSizes.length > 0)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.red,
                    ),
                    transform: Matrix4.identity()..translate(sizeUntilIndex(selectedIndex)),
                    width: childSizes[selectedIndex].width,
                    height: childSizes[selectedIndex].height,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOutBack,
                    alignment: Alignment.center,
                  ),
                ),
              MeasureSize(
                onChange: (size) {
                  setState(() {
                    this.totalSize = size;
                  });
                },
                child: SizedBox(
                  height: 30,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.items.map((e) {
                      Size localSize;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: padding),
                        child: MeasureSize(
                          onChange: (size) {
                            localSize = size;
                            var id = widget.items.indexOf(e);
                            if (childSizes.length < id) {
                              childSizes[id] = localSize;
                            } else {
                              childSizes.add(localSize);
                            }
                          },
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = widget.items.indexOf(e);
                                widget.onTap?.call(e.item);
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: AnimatedText(
                                text: e.item.toString(),
                                color: widget.items.indexOf(e) == selectedIndex ? Colors.white : Colors.grey[800]!,
                                curve: Curves.easeIn,
                                duration: Duration(milliseconds: 300),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class AnimatedText extends ImplicitlyAnimatedWidget {
  final Color? color;
  final String? text;

  AnimatedText({
    this.color,
    this.text,
    Duration duration = Duration.zero,
    Curve curve = Curves.linear,
  }) : super(duration: duration, curve: curve);

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends AnimatedWidgetBaseState<AnimatedText> {
  late ColorTween _color;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text ?? '',
      textAlign: TextAlign.center,
      style: GoogleFonts.roboto(
        fontWeight: FontWeight.bold,
        color: _color.evaluate(animation),
      ),
    );
  }

  @override
  void forEachTween(visitor) {
    _color = visitor(_color, widget.color, (dynamic value) => ColorTween(begin: value)) as ColorTween;
  }
}
