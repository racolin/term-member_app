import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../widgets/app_bar_widget.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Center(child: Text('Home Body'),);
  }
}
// class HomeBody extends StatefulWidget {
//   const HomeBody({Key? key}) : super(key: key);
//
//   @override
//   State<HomeBody> createState() => _HomeBodyState();
// }

// class _HomeBodyState extends State<HomeBody> {
//   _left = 0;
//   @override
//   Widget build(BuildContext context) {
//     return NestedScrollView(
//       headerSliverBuilder: (context, innerBoxIsScrolled) {
//         return [
//           SliverAppBar(
//             backgroundColor: Colors.transparent,
//             expandedHeight: 240,
//             collapsedHeight: 0,
//             toolbarHeight: 0,
//             floating: true,
//             pinned: true,
//             elevation: 0,
//             flexibleSpace: FlexibleSpaceBar(
//               collapseMode: CollapseMode.none,
//               centerTitle: true,
//               background: Container(
//                 height: 240,
//                 padding: const EdgeInsets.only(
//                   top: 24,
//                   left: 8,
//                   right: 8,
//                   bottom: 76,
//                 ),
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: NetworkImage(
//                       "https://images.pexels.com/photos/4148020/pexels-photo-4148020.jpeg",
//                     ),
//                   ),
//                 ),
//                 // child: const CardWidget(isDetail: false),
//               ),
//             ),
//           ),
//         ];
//       },
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // DragBarWidget(margin: _space),
//             // _getOptions(height: 80, margin: _largeSpace),
//             _getSlider(
//               images: [
//                 'https://static.vecteezy.com/system/resources/previews/001/349/622/non_2x/bubble-tea-in-milk-splash-advertisement-banner-free-vector.jpg',
//                 'https://static.vecteezy.com/system/resources/thumbnails/001/073/526/small_2x/bubble-tea-cup-collection.jpg',
//                 'https://static.vecteezy.com/system/resources/thumbnails/001/073/526/small_2x/bubble-tea-cup-collection.jpg',
//                 'https://static.vecteezy.com/system/resources/previews/002/909/345/non_2x/bubble-milk-tea-special-promotions-design-boba-milk-tea-pearl-milk-tea-yummy-drinks-coffees-and-soft-drinks-with-logo-and-cute-funny-doodle-style-advertisement-banner-illustration-vector.jpg'
//               ],
//               margin: 8,
//             ),
//             Container(
//               margin: const EdgeInsets.all(8),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network(
//                   'https://static.vecteezy.com/system/resources/previews/006/152/539/non_2x/bubble-milk-tea-pearl-milk-tea-different-sorts-of-boba-yummy-drinks-vector.jpg',
//                   height: 100,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             _getReorders('Đặt lại đơn hàng nhanh', []),
//             Container(
//               margin: const EdgeInsets.only(
//                 left: 8,
//                 top: 8,
//               ),
//               child: const Text(
//                 'Khám phá thêm',
//                 style: TextStyle(
//                     fontWeight: FontWeight.w700, fontSize: 17),
//               ),
//             ),
//             _getExploreTitles(),
//             _getExploreItems([]),
//           ],
//           // ),
//         ),
//       ),
//     );
//   }
//
//   Widget _getSlider({
//     required List<String> images,
//     required double margin,
//   }) {
//     return Container(
//       margin: EdgeInsets.all(margin),
//       child: Column(
//         children: <Widget>[
//           CarouselSlider(
//             items: images
//                 .map((image) => ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 image,
//                 fit: BoxFit.cover,
//               ),
//             ))
//                 .toList(),
//             options: CarouselOptions(
//               onScrolled: (value) {
//                 if (value != null) {
//                   var v = (value - 10000).floor() % images.length;
//                   var space =
//                       (120 - images.length * 24) / (images.length - 1) + 24;
//                   setState(() {
//                     if (v == images.length - 1) {
//                       _left = (images.length - 1) *
//                           space *
//                           (1 - value + value.floor());
//                     } else {
//                       _left = v * space + (value - value.floor()) * space;
//                     }
//                   });
//                 }
//               },
//               autoPlay: true,
//               autoPlayAnimationDuration: const Duration(milliseconds: 300),
//               autoPlayCurve: Curves.easeInOut,
//               autoPlayInterval: const Duration(seconds: 5),
//               aspectRatio: 2,
//               viewportFraction: 1,
//               initialPage: 0,
//             ),
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           Stack(
//             alignment: Alignment.centerLeft,
//             children: [
//               Container(
//                 margin: EdgeInsets.only(left: _left),
//                 width: 24,
//                 height: 2,
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               SizedBox(
//                 width: 120,
//                 height: 4,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: List.generate(
//                     images.length,
//                         (index) => Container(
//                       width: 24,
//                       height: 2,
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget _getReorders(String title, List<ReorderModel> reorders) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           margin: EdgeInsets.only(
//             left: _space,
//             top: _space,
//           ),
//           child: Text(
//             title,
//             style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
//           ),
//         ),
//         const SizedBox(
//           height: 4,
//         ),
//         for (var reorder in reorders) ReorderWidget(reorder: reorder),
//         const SizedBox(
//           height: 4,
//         ),
//       ],
//     );
//   }
//
//
//   }
// }
