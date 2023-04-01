import 'package:flutter/material.dart';
import 'package:member_app/data/models/news_model.dart';

class NewsItemWidget extends StatelessWidget {
  final VoidCallback onClick;
  final NewsItemModel newsItem;

  const NewsItemWidget({
    Key? key,
    required this.newsItem,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            newsItem.image,
            height: 150,
            width: 400,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          newsItem.title.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.access_time,
              size: 14,
            ),
            const SizedBox(width: 8),
            Text(
              newsItem.dateTime,
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
      ],
    );
  }
}
