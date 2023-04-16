import 'package:flutter/material.dart';
import 'package:member_app/presentation/widgets/slide_images_widget.dart';

import '../../data/models/product_option_model.dart';
import '../../data/models/product_model.dart';

class ProductBottomSheet extends StatefulWidget {
  final ProductModel product;
  final List<ProductOptionModel> options;

  const ProductBottomSheet({
    Key? key,
    required this.product,
    required this.options,
  }) : super(key: key);

  @override
  State<ProductBottomSheet> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  int amount = 0;
  int cost = 0;
  List<String> options = [];
  String name = '';
  String note = '';

  void plus() {
    setState(() {
      cost = widget.product.cost * ++amount;
    });
  }

  void minus() {
    if (amount > 0) {
      setState(() {
        cost = widget.product.cost * --amount;
      });
    }
  }

  void select(String id, int additiveIndex, bool isSelect) {
  }

  void selectAdditive(String id, int index) {
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: const Text('Stores main'),);
    // return DraggableScrollableSheet(
    //   initialChildSize: 1,
    //   minChildSize: 1,
    //   maxChildSize: 1,
    //   builder: (context, scrollController) {
    //     return Container(
    //       margin: const EdgeInsets.only(top: 56),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(16),
    //         color: Colors.white,
    //       ),
    //       child: Column(
    //         children: [
    //           Expanded(
    //             child: Padding(
    //               padding: EdgeInsets.only(
    //                 bottom: MediaQuery.of(context).viewInsets.bottom,
    //               ),
    //               child: SingleChildScrollView(
    //                 child: Column(
    //                   children: [
    //                     Stack(
    //                       children: [
    //                         SlideImagesWidget(
    //                           height: 300,
    //                           separator: 2,
    //                           itemWidth: 250,
    //                           borderRadius: const BorderRadius.vertical(
    //                             top: Radius.circular(10),
    //                           ),
    //                           images: widget.product.images,
    //                         ),
    //                         Positioned(
    //                           top: 12,
    //                           right: 12,
    //                           child: Container(
    //                             height: 24,
    //                             width: 24,
    //                             decoration: BoxDecoration(
    //                               borderRadius: BorderRadius.circular(12),
    //                               color: Colors.white,
    //                             ),
    //                           ),
    //                         ),
    //                         Positioned(
    //                           top: 0,
    //                           right: 0,
    //                           child: IconButton(
    //                             style: ButtonStyle(
    //                               backgroundColor: MaterialStateProperty.all(
    //                                 Colors.white,
    //                               ),
    //                             ),
    //                             onPressed: () {
    //                               Navigator.pop(context);
    //                             },
    //                             icon: const Icon(
    //                               Icons.cancel,
    //                               color: Colors.grey,
    //                               size: 32,
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     _getInformation(),
    //                     for (var i = 0; i < [].length; i++)
    //                       _getAdditives(i),
    //                     _getMoreRequire(
    //                       'Yêu cầu khác',
    //                       'Nhập những yêu cầu bạn muốn',
    //                       'Thêm ghi chú',
    //                     ),
    //                     const SizedBox(height: 100),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //           const Divider(height: 2),
    //           Container(
    //             padding: const EdgeInsets.only(
    //               top: 16,
    //               left: 16,
    //               right: 16,
    //               bottom: 28,
    //             ),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 IconButton(
    //                   onPressed: () {
    //                     minus();
    //                   },
    //                   icon: const Icon(
    //                     Icons.remove_circle,
    //                     color: Colors.orange,
    //                     size: 36,
    //                   ),
    //                 ),
    //                 Text(
    //                   amount.toString(),
    //                   style: const TextStyle(fontSize: 18),
    //                 ),
    //                 IconButton(
    //                   onPressed: () {
    //                     setState(() {
    //                       plus();
    //                     });
    //                   },
    //                   icon: const Icon(
    //                     Icons.add_circle,
    //                     color: Colors.orange,
    //                     size: 36,
    //                   ),
    //                 ),
    //                 Expanded(
    //                   child: SizedBox(
    //                     width: 232,
    //                     child: Directionality(
    //                       textDirection: TextDirection.rtl,
    //                       child: ElevatedButton.icon(
    //                         icon: const Icon(
    //                           Icons.add_shopping_cart_outlined,
    //                           color: Colors.white,
    //                         ),
    //                         style: ButtonStyle(
    //                           padding: MaterialStateProperty.all(
    //                             const EdgeInsets.all(12),
    //                           ),
    //                           shape: MaterialStateProperty.all(
    //                             RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(8),
    //                             ),
    //                           ),
    //                         ),
    //                         onPressed: () {
    //                           var sizeName = '';
    //                           var toppings = <String>[];
    //                           for (var i in additivesList[0].items) {
    //                             if (i.isSelect) {
    //                               sizeName = i.title;
    //                             }
    //                           }
    //                           toppings = additivesList[1]
    //                               .items
    //                               .where((element) => element.isSelect)
    //                               .map((e) => e.title)
    //                               .toList();
    //                           for (var i in additivesList[1].items) {
    //                             if (i.isSelect) {
    //                               sizeName = i.title;
    //                             }
    //                           }
    //
    //                           context.read<HomeProvider>().increaseCart(
    //                                 context,
    //                                 CartItemModel(
    //                                   id: product!.id,
    //                                   amount: amount,
    //                                   sizeName: sizeName,
    //                                   toppings: toppings,
    //                                 ),
    //                               );
    //                         },
    //                         label: Text(
    //                           numberToCurrency(total, 'đ'),
    //                           style: const TextStyle(
    //                             color: Colors.white,
    //                             fontSize: 16,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }

  // Widget _getInformation() {
  //   return Container(
  //     alignment: Alignment.topLeft,
  //     padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Expanded(
  //               child: Text(
  //                 product!.name,
  //                 maxLines: 1,
  //                 style: const TextStyle(
  //                   fontSize: 22,
  //                   color: Colors.black87,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //             ),
  //             GestureDetector(
  //               onTap: () {},
  //               child: Icon(
  //                 product!.isFavorite ? Icons.favorite : Icons.favorite_border,
  //                 color: Colors.orange,
  //               ),
  //             )
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 4,
  //         ),
  //         Text(
  //           numberToCurrency(product!.price, 'đ'),
  //           style: const TextStyle(
  //             fontSize: 18,
  //             color: Colors.black87,
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 16,
  //         ),
  //         Text(
  //           product!.description,
  //           style: const TextStyle(
  //             fontSize: 14,
  //             color: Colors.black87,
  //             fontWeight: FontWeight.w300,
  //           ),
  //           textAlign: TextAlign.justify,
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _getAdditives(int additivesIndex) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //         height: 8,
  //         color: Colors.grey.withAlpha(40),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(left: 12.0, top: 12),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text.rich(
  //               TextSpan(
  //                 text: additivesList[additivesIndex].title,
  //                 style: const TextStyle(
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.w700,
  //                 ),
  //                 children: [
  //                   if (additivesList[additivesIndex].isForce)
  //                     const TextSpan(
  //                       text: '*',
  //                       style: TextStyle(
  //                         color: Colors.red,
  //                         fontWeight: FontWeight.w700,
  //                         fontSize: 18,
  //                       ),
  //                     ),
  //                 ],
  //               ),
  //             ),
  //             Text(additivesList[additivesIndex].description),
  //           ],
  //         ),
  //       ),
  //       ListView.separated(
  //         padding: const EdgeInsets.symmetric(vertical: 12),
  //         physics: const NeverScrollableScrollPhysics(),
  //         shrinkWrap: true,
  //         itemBuilder: (context, index) => Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             additivesList[additivesIndex].type == AdditiveType.checkbox
  //                 ? Checkbox(
  //                     value:
  //                         additivesList[additivesIndex].items[index].isSelect,
  //                     onChanged: (value) {
  //                       select(additivesList[additivesIndex].id, index, value!);
  //                     },
  //                   )
  //                 : additivesList[additivesIndex].type == AdditiveType.radio
  //                     ? Radio(
  //                         value: index,
  //                         onChanged: (value) {
  //                           select(
  //                             additivesList[additivesIndex].id,
  //                             index,
  //                             true,
  //                           );
  //                         },
  //                         groupValue: _selectRadios[additivesIndex],
  //                       )
  //                     : Container(),
  //             Text(additivesList[additivesIndex].items[index].title),
  //             const Spacer(),
  //             Text(numberToCurrency(
  //                 additivesList[additivesIndex].items[index].price, 'đ')),
  //             const SizedBox(
  //               width: 8,
  //             ),
  //           ],
  //         ),
  //         separatorBuilder: (context, index) => const Padding(
  //           padding: EdgeInsets.only(left: 16.0),
  //           child: Divider(height: 1),
  //         ),
  //         itemCount: additivesList[additivesIndex].items.length,
  //       ),
  //     ],
  //   );
  // }

  Widget _getMoreRequire(String name, String description, hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 8,
          color: Colors.grey.withAlpha(40),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(description),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            // controller: _moreRequireController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.only(
                left: 16,
                top: 12,
                bottom: 12,
                right: 12,
              ),
              // isDense: true,
              labelText: hint,
            ),
          ),
        )
      ],
    );
  }
}
