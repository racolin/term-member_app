import 'package:flutter/material.dart';

import '../../data/models/news_model.dart';
import '../res/strings/values.dart';
import '../res/dimen/dimens.dart';
import '../widgets/news/news_widget.dart';

class NewsScreen extends StatefulWidget {
  final List<NewsModel> news;

  const NewsScreen({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _index = 0;
  List<double> _offsets = [];
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _offsets = List.generate(widget.news.length, (index) => 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  void _selectSubject(int index) {
    if (_index != index) {
      _offsets[_index] = _controller.offset;
      _controller.jumpTo(_offsets[index]);
      setState(() {
        _index = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          splashRadius: spaceLG,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            size: fontXL,
          ),
        ),
        title: const Text(
          txtNews,
          style: TextStyle(
            fontSize: fontLG,
          ),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: spaceXS),
            scrollDirection: Axis.horizontal,
            child: Wrap(
              alignment: WrapAlignment.start,
              children: [
                for (int i = 0; i < widget.news.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: spaceXS),
                    child: TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: spaceXS,
                          ),
                        ),
                        overlayColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor.withOpacity(opaMD),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          _index == i
                              ? Theme.of(context)
                              .primaryColor
                              .withOpacity(opaSM)
                              : Colors.white.withOpacity(opaSM),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(spaceXS),
                          ),
                        ),
                      ),
                      onPressed: () {
                        _selectSubject(i);
                      },
                      child: Text(
                        widget.news[i].name,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: [
                  NewsWidget(newsList: widget.news[_index].news),
                  const SizedBox(
                    height: dimMD,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
