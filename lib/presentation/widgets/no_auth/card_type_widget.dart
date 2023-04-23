import 'package:flutter/material.dart';
import 'package:member_app/presentation/app_router.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';
import 'package:member_app/presentation/widgets/card_holder_widget.dart';

class CardTypeWidget extends StatefulWidget {
  const CardTypeWidget({Key? key}) : super(key: key);

  @override
  State<CardTypeWidget> createState() => _CardTypeWidgetState();
}

class _CardTypeWidgetState extends State<CardTypeWidget> {
  List<List<MapEntry<String, String>>> properties = [
    [
      const MapEntry(
        'assets/images/icon_default.png',
        'Miễn phí upsize cho đơn đầu tiên',
      ),
    ],
    [
      const MapEntry(
        'assets/images/icon_default.png',
        'Tặng một phần bánh sinh nhật',
      ),
      const MapEntry(
        'assets/images/icon_default.png',
        'Miễn phí 01 phần Snack cho đơn hàng trên 100,000đ',
      ),
      const MapEntry(
        'assets/images/icon_default.png',
        'Đặc quyền đổi Ưu đãi bằng $txtPointName tích luỹ',
      ),
    ],
    [
      const MapEntry(
        'assets/images/icon_default.png',
        'Tặng một phần bánh sinh nhật',
      ),
      const MapEntry(
        'assets/images/icon_default.png',
        'Ưu đãi mua 2 tặng 1',
      ),
      const MapEntry(
        'assets/images/icon_default.png',
        'Đặc quyền đổi Ưu đãi bằng $txtPointName tích luỹ',
      ),
    ],
    [
      const MapEntry(
        'assets/images/icon_default.png',
        'Tặng một phần bánh sinh nhật',
      ),
      const MapEntry(
        'assets/images/icon_default.png',
        'Miễn phí một phần Cà phê / Trà',
      ),
      const MapEntry(
        'assets/images/icon_default.png',
        'Đặc quyền đổi Ưu đãi bằng $txtPointName tích luỹ',
      ),
    ],
    [
      const MapEntry(
        'assets/images/icon_default.png',
        'Nhận được 1.5 $txtPointName tích luỹ',
      ),
      const MapEntry(
        'assets/images/icon_default.png',
        'Tặng một phần bánh sinh nhật',
      ),
      const MapEntry(
        'assets/images/icon_default.png',
        'Miễn phí 01 phần nước bất kì',
      ),
      const MapEntry(
        'assets/images/icon_default.png',
        'Nhận riêng ưu đãi từ $txtAppName và đối tác khác',
      ),
      const MapEntry(
        'assets/images/icon_default.png',
        'Cơ hội trải nghiệm & hưởng đặc quyền đầu tiên',
      ),
      const MapEntry(
        'assets/images/icon_default.png',
        'Đặc quyền đổi Ưu đãi bằng $txtPointName tích luỹ',
      ),
    ],
  ];
  int index = 0;
  double rate = 1;
  List<MapEntry<String, Color>> list = [
    const MapEntry('Mới', Colors.blue),
    const MapEntry('Đồng', Colors.deepOrange),
    const MapEntry('Bạc', Colors.grey),
    MapEntry('Vàng', Colors.yellow.shade800),
    const MapEntry('Kim Cương', Colors.black87),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: spaceSM,
            // vertical: spaceMD,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.2,
              ),
            ),
          ),
          width: double.maxFinite,
          child: Column(
            children: [
              const SizedBox(height: spaceXXL),
              Text(
                'Thăng hạng dễ dàng\nQuyền lợi đa dạng & hấp dẫn',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: spaceLG),
              Row(
                children: [
                  for (var i = 0; i < list.length; i++)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            index = i;
                          });
                        },
                        child: CardHolderWidget(
                          padding: 4,
                          rate: rate,
                          radius: 8,
                          color: list[i].value,
                          name: list[i].key,
                          expand: index == i,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: spaceXS),
              for (var i = 0; i < properties[index].length; i++)
                Container(
                  decoration: BoxDecoration(
                    border: (i != properties[index].length - 1) ? const Border(
                      bottom: BorderSide(
                        width: 0.2,
                        color: Colors.grey,
                      ),
                    ) : null,
                  ),
                  padding: const EdgeInsets.all(spaceSM),
                  child: Row(
                    children: [
                      const SizedBox(width: spaceLG),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            Colors.orange,
                            BlendMode.color,
                          ),
                          child: Image.asset(
                            properties[index][i].key,
                            height: 36,
                            width: 36,
                          ),
                        ),
                      ),
                      const SizedBox(width: spaceLG),
                      Expanded(
                        child: Text(
                          properties[index][i].value,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ),
                      const SizedBox(width: spaceLG),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const Divider(height: 1),
        const SizedBox(height: dimMD,),
      ],
    );
  }
}
