import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/home_state.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../business_logic/cubits/home_cubit.dart';
import '../res/dimen/dimens.dart';

class FloatingActionWidget extends StatefulWidget {
  final VoidCallback onClick;
  final double maxHeight = 60;
  final double minHeight = 48;

  const FloatingActionWidget({
    Key? key,
    required this.onClick,
  }) : super(key: key);

  @override
  State<FloatingActionWidget> createState() => _FloatingActionWidgetState();
}

class _FloatingActionWidgetState extends State<FloatingActionWidget>
    with TickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 300);
  late final AnimationController _controller = AnimationController(
    duration: duration,
    vsync: this,
  );
  late final Animation<double> animation;

  @override
  void initState() {
    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          previous.isExpandFloating != current.isExpandFloating,
      listener: (context, state) {
        if (state.isExpandFloating) {
          _controller.forward(from: 0);
        } else {
          _controller.reverse(from: 1);
        }
      },
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _getValue(
              spaceSM,
              spaceLG,
              animation.value,
            ),
          ),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(spaceSM),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(
                      1,
                      3,
                    ),
                  ),
                ],
                borderRadius: BorderRadius.circular(
                  _getValue(
                    spaceXS,
                    spaceMD,
                    animation.value,
                  ),
                ),
                color: Colors.white,
              ),
              width: double.maxFinite,
              height: _getValue(
                widget.maxHeight,
                widget.minHeight,
                animation.value,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: _getValue(
                        0,
                        (widget.minHeight - spaceLG - 2 * spaceSM) / 2,
                        animation.value),
                    child: Row(
                      children: [
                        _getIcon(
                          _getValue(
                            spaceMD,
                            spaceLG,
                            animation.value,
                          ),
                        ),
                        const SizedBox(
                          width: spaceXS,
                        ),
                        Opacity(
                          opacity: 1 -
                              (animation.value > 1
                                  ? 1
                                  : animation.value < 0
                                      ? 0
                                      : animation.value),
                          child: _getTypeTitle(),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: _getValue(
                        0,
                        (widget.minHeight - fontMD - 2 - 2 * spaceSM) / 2,
                        animation.value),
                    left: _getValue(0, spaceXS + spaceLG, animation.value),
                    child: _getAddress(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _getValue(double from, double to, double rate) {
    return from + (to - from) * rate;
  }

  Widget _getIcon(double size) {
    return Icon(
      Icons.emoji_food_beverage,
      size: size,
    );
  }

  Widget _getTypeTitle() {
    return const Text(
      txtTake,
      style: TextStyle(
        fontSize: fontSM,
        color: Colors.black54,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _getAddress() {
    return const Text(
      '175B Cao Thắng',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontMD,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
