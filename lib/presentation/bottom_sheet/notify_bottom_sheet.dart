import 'package:flutter/material.dart';
import 'package:member_app/presentation/res/strings/values.dart';
import 'package:member_app/presentation/widgets/app_image_widget.dart';

import '../../data/models/notify_model.dart';

class NotifyBottomSheet extends StatelessWidget {
  final NotifyModel notify;

  const NotifyBottomSheet({
    Key? key,
    required this.notify,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppImageWidget(
                image: notify.image,
                height: 280,
                width: double.maxFinite,
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 12, left: 16, right: 16, bottom: 56),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      notify.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      notify.description,
                      style: const TextStyle(height: 1.5),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(12),
                          ),
                        ),
                        child: const Text(
                          txtSeeNow,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.cancel,
              color: Colors.grey,
              size: 32,
            ),
          ),
        ),
      ],
    );
  }
}
