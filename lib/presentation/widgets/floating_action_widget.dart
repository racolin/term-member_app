import 'package:flutter/material.dart';

import '../../supports/convert.dart';
import '../../presentation/res/strings/values.dart';
import '../../presentation/widgets/app_image_widget.dart';
import '../../data/models/cart_model.dart';
import '../bottom_sheet/cart_bottom_sheet.dart';
import '../res/dimen/dimens.dart';

class FloatingActionWidget extends StatefulWidget {
  final VoidCallback onClick;
  final bool expanded;
  final DeliveryType? type;
  final String? addressName;
  final int? amount;
  final int? cost;
  final double maxHeight = 60;
  final double minHeight = 48;

  const FloatingActionWidget({
    Key? key,
    required this.onClick,
    this.type,
    this.addressName,
    this.amount,
    this.cost,
    this.expanded = false,
  }) : super(key: key);

  @override
  State<FloatingActionWidget> createState() => _FloatingActionWidgetState();
}

class _FloatingActionWidgetState extends State<FloatingActionWidget>
    with TickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 400);
  late final AnimationController _controller = AnimationController(
    duration: duration,
    vsync: this,
  );
  late final Animation<double> animation;
  late bool expanded;

  @override
  void didUpdateWidget(covariant FloatingActionWidget oldWidget) {
    if (expanded != widget.expanded) {
      if (expanded) {
        _controller.reverse(from: 1);
      } else {
        _controller.forward(from: 0);
      }
      expanded = widget.expanded;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    expanded = widget.expanded;
    animation = Tween(begin: 1.0, end: 0.0).animate(
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
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _getValue(spaceSM, spaceLG, animation.value),
        ),
        child: GestureDetector(
          onTap: widget.onClick,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4,
                  offset: Offset(1, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(
                _getValue(spaceXS, spaceMD, animation.value),
              ),
              color: Colors.white,
            ),
            width: double.maxFinite,
            height: _getValue(
              widget.maxHeight,
              widget.minHeight,
              animation.value,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _getDetail(
                    widget.type,
                    widget.minHeight,
                    widget.addressName,
                  ),
                ),
                if (widget.type != null &&
                    widget.cost != null &&
                    widget.cost != 0 &&
                    widget.amount != 0)
                  _getCost(widget.cost ?? 0, widget.amount ?? 0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _getValue(double from, double to, double rate) {
    return from + (to - from) * rate;
  }

  Widget _getDetail(
    DeliveryType? type,
    double minHeight,
    String? addressName,
  ) {
    return Padding(
      padding: const EdgeInsets.all(spaceSM),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: spaceXXS,
            top: _getValue(
                0, (minHeight - spaceLG - 2 * spaceSM) / 2, animation.value),
            child: Row(
              children: [
                AppImageWidget(
                  image: null,
                  assetsDefaultImage: type == null
                      ? 'assets/images/image_select.png'
                      : type.image,
                  height: _getValue(
                    spaceMD,
                    spaceLG,
                    animation.value,
                  ),
                  width: _getValue(
                    spaceMD,
                    spaceLG,
                    animation.value,
                  ),
                  borderRadius: BorderRadius.circular(_getValue(
                        spaceMD,
                        spaceLG,
                        animation.value,
                      ) /
                      2),
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
                  child: Text(
                    type == null ? txtSelect : type.name,
                    style: const TextStyle(
                      fontSize: fontSM,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: _getValue(
              0,
              (minHeight - fontMD - 2 - 2 * spaceSM) / 2,
              animation.value,
            ),
            right: spaceXXS,
            left: _getValue(
              spaceXXS,
              spaceXS + spaceLG,
              animation.value,
            ),
            child: Text(
              type != null
                  ? (addressName ?? type.description)
                  : txtSelectDelivery,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: fontMD,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCost(int cost, int amount) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (ctx) {
            return const CartBottomSheet();
          },
        );
      },
      child: Container(
        margin: EdgeInsets.all(_getValue(6, 10, _controller.value)),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(spaceLG),
        ),
        height: spaceLG * 2,
        // width: 100,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 6,
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: _getValue(12, 14, _controller.value),
              child: Text(
                (amount).toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              numberToCurrency(cost, 'đ'),
              style: const TextStyle(
                fontSize: fontSM,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            const Icon(
              Icons.keyboard_arrow_right_outlined,
              size: 12,
              color: Colors.white,
            ),
            const SizedBox(
              width: 6,
            ),
          ],
        ),
      ),
    );
  }
}
