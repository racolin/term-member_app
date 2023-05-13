import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/product_cubit.dart';
import 'package:member_app/business_logic/states/product_state.dart';
import 'package:member_app/exception/app_message.dart';
import 'package:member_app/presentation/dialogs/app_dialog.dart';

import '../../data/models/product_option_model.dart';
import '../../data/models/product_model.dart';
import '../../supports/convert.dart';
import '../res/strings/values.dart';
import '../widgets/slide/slide_images_widget.dart';

class ProductBottomSheet extends StatefulWidget {
  final ProductModel product;

  const ProductBottomSheet({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductBottomSheet> createState() => _ProductBottomSheetState();
}

class _Selected {
  final List<ProductOptionModel> options;
  final int defaultCost;
  Map<String, MapEntry<int, Map<String, MapEntry<int, bool>>>> selected;

  _Selected({
    required this.options,
    required this.defaultCost,
  }) : selected = {
          for (var i = 0; i < options.length; i++)
            options[i].id: MapEntry(
              i,
              {
                for (var j = 0; j < options[i].optionItems.length; j++)
                  options[i].optionItems[j].id: MapEntry(
                    j,
                    options[i].defaultSelect.contains(
                          options[i].optionItems[j].id,
                        ),
                  ),
              },
            ),
        } {}

  int get cost {
    return defaultCost +
        selected.values.fold(
          0,
          (preParent, eParent) =>
              preParent +
              eParent.value.values.fold(
                0,
                (pre, e) =>
                    pre +
                    (e.value
                        ? options[eParent.key].optionItems[e.key].cost
                        : 0),
              ),
        );
  }

  bool get(String parentId, String id) {
    return selected[parentId]!.value[id]!.value;
  }

  String? getRadioGroup(String parentId) {
    var map = selected[parentId]!.value;
    for (var key in map.keys) {
      if (map[key]!.value) {
        return key;
      }
    }
    return null;
  }

  void set(String parentId, String id, bool status) {
    bool radio = isRadio(parentId);
    if (radio) {
      selected[parentId]!
          .value
          .updateAll((key, value) => MapEntry(value.key, false));
    } else {
      bool isOver = over(parentId);
      if (status && isOver) {
        return;
      }
    }
    var entry = selected[parentId]!.value[id];
    selected[parentId]!.value[id] = MapEntry(entry!.key, status);
  }

  bool isRadio(String parentId) {
    var model = options[selected[parentId]!.key];
    return model.maxSelected == 1 && model.minSelected == 1;
  }

  bool over(String parentId) {
    int amount = amountSelected(parentId);
    return options[selected[parentId]!.key].maxSelected <= amount;
  }

  int amountSelected(String parentId) {
    return selected[parentId]!.value.values.fold(
          0,
          (pre, e) => pre + (e.value ? 1 : 0),
        );
  }
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  late _Selected selected;
  int amount = 1;
  String? note;
  bool isFavorite = false;

  @override
  void initState() {
    if (context.read<ProductCubit>().state is ProductLoaded) {
      var state = context.read<ProductCubit>().state as ProductLoaded;
      loadFavorite();
      selected = _Selected(
        defaultCost: widget.product.cost,
        options: state.listOption
            .where(
              (e) => widget.product.optionIds.contains(e.id),
            )
            .toList(),
      );
    }
    super.initState();
  }

  void loadFavorite() {
    isFavorite = context.read<ProductCubit>().checkFavorite(widget.product.id);
  }

  void setAmount(int n) {
    if (n <= 0) {
      setState(() {
        amount = 0;
      });
      return;
    }

    setState(() {
      amount = n;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
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
                            SlideImagesWidget(
                              height: 300,
                              separator: 2,
                              itemWidth: 250,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                              images: widget.product.images,
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
                        _getInformation(isFavorite),
                        _getOptions(selected),
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
                        setAmount(amount - 1);
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
                        setAmount(amount + 1);
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
                            onPressed: () {},
                            label: Text(
                              numberToCurrency(amount * selected.cost, 'đ'),
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
    );
  }

  Widget _getInformation(bool isFavorite) {
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
                  widget.product.name,
                  // maxLines: 1,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  var message =
                      await context.read<ProductCubit>().changeFavorite(
                            widget.product.id,
                            isFavorite,
                          );
                  if (mounted) {
                    if (message == null) {
                      setState(() {
                        loadFavorite();
                        // this.isFavorite = !isFavorite;
                      });
                    } else {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return AppDialog(
                            message: message,
                            actions: [
                              CupertinoDialogAction(
                                child: const Text(txtConfirm),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.orange,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            numberToCurrency(widget.product.cost, 'đ'),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.product.description,
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

  Widget _getOptions(_Selected selectedModel) {
    return Column(
      children: [
        for (var model in selectedModel.options)
          Column(
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
                        text: model.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        children: [
                          if (model.minSelected > 0)
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
                    if (model.minSelected == 0)
                      Text('Chọn tối đa ${model.maxSelected} loại')
                    else if (model.minSelected == 1 && model.maxSelected == 1)
                      Text('Bạn phải chọn ${model.maxSelected} loại')
                    else if (model.minSelected == model.maxSelected)
                      Text('Bạn phải chọn ${model.maxSelected} loại')
                    else
                      Text(
                        'Chọn tối thiểu ${model.minSelected} và tối đa ${model.maxSelected} loại',
                      ),
                  ],
                ),
              ),
              ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 12),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      selectedModel.isRadio(model.id)
                          ? Radio<String>(
                              value: model.optionItems[index].id,
                              onChanged: model.optionItems[index].disable
                                  ? null
                                  : (id) {
                                      if (id != null) {
                                        setState(() {
                                          selectedModel.set(model.id, id, true);
                                        });
                                      }
                                    },
                              groupValue: selectedModel.getRadioGroup(model.id),
                            )
                          : Checkbox(
                              value: selectedModel.get(
                                model.id,
                                model.optionItems[index].id,
                              ),
                              onChanged: model.optionItems[index].disable
                                  ? null
                                  : (status) {
                                      if (status != null) {
                                        setState(() {
                                          selectedModel.set(
                                            model.id,
                                            model.optionItems[index].id,
                                            status,
                                          );
                                        });
                                      }
                                    },
                            ),
                      Text(model.optionItems[index].name),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            model.optionItems[index].disable
                                ? '$txtDisable | '
                                : '',
                          ),
                        ),
                      ),
                      Text(
                          numberToCurrency(model.optionItems[index].cost, 'đ')),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Divider(height: 1),
                ),
                itemCount: model.optionItems.length,
              ),
            ],
          ),
      ],
    );
  }

  Widget _getMoreRequire(
    String name,
    String description,
    String hint,
  ) {
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
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            maxLines: null,
            // controller: _moreRequireController,
            decoration: InputDecoration(
              isDense: true,
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
