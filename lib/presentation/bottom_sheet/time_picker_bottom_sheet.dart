import 'package:flutter/material.dart';
import '../res/dimen/dimens.dart';

class TimePickerBottomSheet extends StatefulWidget {
  final DateTime? current;

  const TimePickerBottomSheet({
    Key? key,
    required this.current,
  }) : super(key: key);

  @override
  State<TimePickerBottomSheet> createState() => _TimePickerBottomSheetState();
}

class _TimePickerBottomSheetState extends State<TimePickerBottomSheet> {
  int _index = 0;
  int _start = 0;
  final now = DateTime.now();

  @override
  void initState() {

    _start = now.hour * 2 + now.minute ~/ 30;
    _start = _start < 13 ? 13 : _start;
    if (widget.current == null) {
      _index = 0;
    } else {
      _index = widget.current!.hour * 2 + widget.current!.minute ~/ 30 - _start;
      if (_index < 0 || _index > 43) {
        _index = 0;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: const EdgeInsets.all(12),
                child: const Text(
                  'Chọn thời gian đặt hàng',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    size: 22,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 1),
          const SizedBox(height: spaceSM),
          Expanded(
            child: SizedBox(
              height: 200,
              child: ListWheelScrollView(
                onSelectedItemChanged: (value) {
                  setState(() {
                    _index = value;
                  });
                },
                squeeze: 0.75,
                itemExtent: 50,
                physics: const FixedExtentScrollPhysics(),
                controller: FixedExtentScrollController(initialItem: _index),
                children: List.generate(43 - _start, (index) {
                  if (index == 0) {
                    return Text(
                      'Càng sớm càng tốt',
                      style: TextStyle(
                        fontSize: fontXL,
                        fontWeight:
                            _index == 0 ? FontWeight.w600 : FontWeight.w300,
                      ),
                    );
                  }
                  var i = index + _start;
                  var h = (i ~/ 2).toString().padLeft(2, '0');
                  var m = ((i % 2) * 30).toString().padLeft(2, '0');
                  return Text(
                    '$h:$m',
                    style: TextStyle(
                      fontSize: fontXL,
                      fontWeight:
                          _index == index ? FontWeight.w600 : FontWeight.w300,
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: spaceSM),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                _index == 0 ? null : DateTime(
                  now.year,
                  now.month,
                  now.day,
                  (_index + _start) ~/ 2,
                  (_index + _start) % 2 * 30,
                ),
              );
            },
            child: const Text('Chọn'),
          ),
          const SizedBox(height: dimSM),
        ],
      ),
    );
  }
}
