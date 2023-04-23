import 'dart:math';

import 'package:flutter/material.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';

class CardHolderWidget extends StatefulWidget {
  final double padding;
  final double radius;
  final double rate;
  final Color color;
  final String name;
  final bool expand;

  const CardHolderWidget({
    super.key,
    required this.padding,
    required this.radius,
    required this.rate,
    required this.color,
    required this.name,
    required this.expand,
  });

  @override
  State<CardHolderWidget> createState() => _CardHolderWidgetState();
}

class _CardHolderWidgetState extends State<CardHolderWidget>
    with TickerProviderStateMixin {
  @override
  void didUpdateWidget(covariant CardHolderWidget oldWidget) {
    if (oldWidget.expand != widget.expand) {
      if (widget.expand) {
        _controller.forward(from: 0);
      } else {
        _controller.reverse(from: 1);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  late final AnimationController _controller;
  late Animation<double> _animation;

  double padding = 0;
  double radius = 0;
  double size = 0;
  double rate = 0;
  Color color = Colors.white;
  String name = '';

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.72, end: 0.86).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    radius = widget.radius;
    padding = widget.padding;
    color = widget.color;
    name = widget.name;
    if (widget.expand) {
      _controller.forward(from: 0);
    } else {
      _controller.reverse(from: 1);
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(spaceXXS),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: widget.expand
            ? [
                const BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1.5, 1.5),
                  blurRadius: 2,
                ),
              ]
            : null,
      ),
      duration: const Duration(milliseconds: 250),
      child: LayoutBuilder(
        builder: (context, constraint) {
          var width = constraint.biggest.width;
          size = width * 5 / 7 / 16;
          print("name");
          print(name);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScaleTransition(
                scale: _animation,
                child: AspectRatio(
                  aspectRatio: 7 / 5,
                  child: Container(
                    padding: EdgeInsets.all(padding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      gradient: LinearGradient(
                        colors: [color.withAlpha(160), color],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: const [0.16, 1],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '00',
                              style: TextStyle(
                                backgroundColor: Colors.white,
                                fontSize: size,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: size / 2,
                            ),
                            Text(
                              '00000000',
                              style: TextStyle(
                                backgroundColor: Colors.white,
                                fontSize: size,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: size * 4.8,
                          height: size * 3.6,
                          color: Colors.white,
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.ideographic,
                          children: [
                            Text(
                              '00',
                              style: TextStyle(
                                backgroundColor: Colors.white,
                                fontSize: size,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: size / 2,
                            ),
                            Text(
                              '00000000',
                              style: TextStyle(
                                backgroundColor: Colors.white,
                                fontSize: size,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: size / 2,
                            ),
                            Text(
                              '00',
                              style: TextStyle(
                                backgroundColor: Colors.white,
                                fontSize: size,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'TCH',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                // height: 0.01,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                fontSize: size * 3.2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: spaceXXS),
              Text(
                name,
                style: TextStyle(fontSize: size * 4, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: spaceXXS),
            ],
          );
        },
      ),
    );
  }
}
