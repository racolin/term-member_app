import 'package:flutter/material.dart';

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
  State<ProductBottomSheet> createState() =>
      _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  final List<int> _selectRadios = [];
  final _moreRequireController = TextEditingController();
  var amount = 0;
  double total = 0;
  ProductModel? product;
  HomeProvider? _provider;

  @override
  void didChangeDependencies() {
    _provider = context.read<HomeProvider>();
    var map = _provider?.getProductAndAdditivesById(widget.id);

    product = map!['product'];
    additivesList = map['additives'];

    for (var i = 0; i < additivesList.length; i++) {
      _selectRadios.add(-1);
      if (additivesList[i].isForce) {
        additivesList[i].items[0].isSelect = true;
        _selectRadios[i] = 0;
      }
    }
    plus();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _moreRequireController.dispose();
    super.dispose();
  }

  void plus() {
    setState(() {
      total = (product!.price * ++amount).toDouble();
    });
  }

  void minus() {
    if (amount > 0) {
      setState(() {
        total = (product!.price * --amount).toDouble();
      });
    }
  }

  void select(String id, int additiveIndex, bool isSelect) {
    for (var i = 0; i < additivesList.length; i++) {
      if (additivesList[i].id == id) {
        if (additivesList[i].isForce && isSelect) {
          setState(() {
            additivesList[i].items[additiveIndex].isSelect = isSelect;
            _selectRadios[i] = additiveIndex;
          });
        }
        if (!additivesList[i].isForce) {
          if (isSelect) {
            var count = additivesList[i].items.fold(
              0,
                  (pre, e) => pre + (e.isSelect ? 1 : 0),
            );
            if (count < additivesList[i].maxChoose) {
              setState(() {
                additivesList[i].items[additiveIndex].isSelect = isSelect;
              });
            }
          } else {
            setState(() {
              additivesList[i].items[additiveIndex].isSelect = isSelect;
            });
          }
        }
      }
    }
  }

  void selectAdditive(String id, int index) {
    additivesList.where((element) => element.id == id);
    for (int i = 0; i < additivesList.length; i++) {
      if (additivesList[i].id == id) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, instance, child) => DraggableScrollableSheet(
        initialChildSize: 1,
        minChildSize: 1,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return Container(
            margin: const EdgeInsets.only(top: 56),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              _getListImage(),
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
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.white,
                                    ),
                                  ),
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
                          ),
                          _getInformation(),
                          for (var i = 0; i < additivesList.length; i++)
                            _getAdditives(i),
                          _getMoreRequire(
                            'Yêu cầu khác',
                            'Nhập những yêu cầu bạn muốn',
                            'Thêm ghi chú',
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(height: 2),
                Container(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                    bottom: 28,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          minus();
                        },
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.orange,
                          size: 36,
                        ),
                      ),
                      Text(
                        amount.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            plus();
                          });
                        },
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.orange,
                          size: 36,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 232,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.add_shopping_cart_outlined,
                                color: Colors.white,
                              ),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(12),
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                var sizeName = '';
                                var toppings = <String>[];
                                for (var i in additivesList[0].items) {
                                  if (i.isSelect) {
                                    sizeName = i.title;
                                  }
                                }
                                toppings = additivesList[1]
                                    .items
                                    .where((element) => element.isSelect)
                                    .map((e) => e.title)
                                    .toList();
                                for (var i in additivesList[1].items) {
                                  if (i.isSelect) {
                                    sizeName = i.title;
                                  }
                                }

                                context.read<HomeProvider>().increaseCart(
                                  context,
                                  CartItemModel(
                                    id: product!.id,
                                    amount: amount,
                                    sizeName: sizeName,
                                    toppings: toppings,
                                  ),
                                );
                              },
                              label: Text(
                                numberToCurrency(total, 'đ'),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _getListImage() {
    return SizedBox(
      height: 300,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        // height: 300,
        child: product!.images.length < 2
            ? Image.network(
          product!.images[0],
          height: 300,
          width: double.maxFinite,
          fit: BoxFit.cover,
        )
            : ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            width: 2,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: product!.images.length,
          itemBuilder: (context, index) => Image.network(
            product!.images[index],
            height: 300,
            width: 250,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _getInformation() {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  product!.name,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  product!.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.orange,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            numberToCurrency(product!.price, 'đ'),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            product!.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _getAdditives(int additivesIndex) {
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
              Text.rich(
                TextSpan(
                  text: additivesList[additivesIndex].title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    if (additivesList[additivesIndex].isForce)
                      const TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                  ],
                ),
              ),
              Text(additivesList[additivesIndex].description),
            ],
          ),
        ),
        ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 12),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              additivesList[additivesIndex].type == AdditiveType.checkbox
                  ? Checkbox(
                value: additivesList[additivesIndex]
                    .items[index]
                    .isSelect,
                onChanged: (value) {
                  select(additivesList[additivesIndex].id, index, value!);
                },
              )
                  : additivesList[additivesIndex].type == AdditiveType.radio
                  ? Radio(
                value: index,
                onChanged: (value) {
                  select(
                    additivesList[additivesIndex].id,
                    index,
                    true,
                  );
                },
                groupValue: _selectRadios[additivesIndex],
              )
                  : Container(),
              Text(additivesList[additivesIndex].items[index].title),
              const Spacer(),
              Text(numberToCurrency(
                  additivesList[additivesIndex].items[index].price, 'đ')),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Divider(height: 1),
          ),
          itemCount: additivesList[additivesIndex].items.length,
        ),
      ],
    );
  }

  Widget _getMoreRequire(String title, String description, hint) {
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
                title,
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
