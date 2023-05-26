import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:member_app/business_logic/cubits/app_bar_cubit.dart';
import 'package:member_app/business_logic/cubits/cart_template_cubit.dart';
import 'package:member_app/data/models/cart_template_model.dart';
import 'package:member_app/presentation/dialogs/app_dialog.dart';
import 'package:member_app/presentation/pages/loading_page.dart';
import 'package:member_app/supports/extension.dart';

import '../../business_logic/blocs/interval/interval_bloc.dart';
import '../../business_logic/cubits/product_cubit.dart';
import '../../business_logic/states/cart_template_state.dart';
import '../../data/models/product_model.dart';
import '../../supports/convert.dart';
import '../screens/product_search_screen.dart';
import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';
import '../widgets/app_image_widget.dart';

class CartTemplateBottomSheet extends StatefulWidget {
  final String id;

  const CartTemplateBottomSheet({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<CartTemplateBottomSheet> createState() =>
      _CartTemplateBottomSheetState();
}

class _CartTemplateBottomSheetState extends State<CartTemplateBottomSheet> {
  List<ProductModel> products = [];
  List<int> amounts = [];
  List<int> costs = [];
  String? name;

  void setup(CartTemplateModel model) {
    products = [];
    costs = [];
    amounts = [];
    for (var e in model.products) {
      var product = context.read<ProductCubit>().getProductById(e.id,);
      if (product != null) {
        amounts.add(e.amount);
        products.add(product);
        amounts.add(e.amount);
        costs.add(
          (product.cost +
              getCostOptions(
                context,
                e.options,
              )) * e.amount,
        );
      }
    }
  }

  @override
  void initState() {
    var message = context.read<CartTemplateCubit>().select(widget.id);
    if (message != null) {
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
    super.initState();
  }

  int getCostOptions(BuildContext context, List<String> options) {
    return context.read<ProductCubit>().getCostOptionsItem(
              options,
            ) ??
        0;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 1,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Container(
          margin: const EdgeInsets.only(top: dimMD),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(spaceMD),
          ),
          child: BlocBuilder<CartTemplateCubit, CartTemplateState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case CartTemplateInitial:
                  return const SizedBox();
                case CartTemplateLoading:
                  return const LoadingPage();
                case CartTemplateLoaded:
                  var model = (state as CartTemplateLoaded).selected;
                  if (model == null) {
                    return const LoadingPage();
                  }
                  name ??= state.selected?.name;
                  setup(model);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: spaceSM),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: spaceSM,
                              ),
                              Expanded(
                                child: Container(
                                  width: double.maxFinite,
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Chi tiết đơn hàng mẫu',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: spaceSM,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.close_sharp,
                                  size: 22,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                width: spaceSM,
                              ),
                            ],
                          ),
                          const SizedBox(height: spaceSM),
                          const Divider(height: 1),
                        ],
                      ),
                      const SizedBox(height: spaceSM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: spaceMD),
                            Center(
                              child: SvgPicture.string(
                                model.getCode().qrCode(240, 240),
                              ),
                            ),
                            const SizedBox(height: spaceMD),
                            const SizedBox(height: spaceSM),
                            const Divider(height: 1),
                            const SizedBox(height: spaceSM),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: spaceSM,
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 48,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: spaceSM),
                                    padding: const EdgeInsets.all(spaceSM),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(spaceXS),
                                      border: Border.all(
                                          color: Colors.black54, width: 0.5),
                                    ),
                                    child: TextFormField(
                                      initialValue: name,
                                      keyboardType: TextInputType.name,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                      onChanged: (value) {
                                        name = value;
                                      },
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 2,
                                    left: spaceSM,
                                    child: Text(
                                      'Tên đơn',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: spaceSM,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          txtTemplateProducts,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: fontLG,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (ctx) {
                                                  return BlocProvider<
                                                      IntervalBloc<
                                                          ProductModel>>(
                                                    create: (ctx) =>
                                                        IntervalBloc<
                                                            ProductModel>(
                                                      submit: BlocProvider.of<
                                                          ProductCubit>(ctx),
                                                    ),
                                                    child:
                                                        const ProductSearchScreen(
                                                      withFloatingButton: false,
                                                      isTemplate: true,
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                              Colors.orange.withAlpha(20),
                                            ),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  spaceMD,
                                                ),
                                              ),
                                            ),
                                          ),
                                          child: const Text(
                                            txtAdd,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: spaceSM,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (var i = 0;
                                                i < products.length;
                                                i++)
                                              Slidable(
                                                key: ValueKey(i),
                                                endActionPane: ActionPane(
                                                  extentRatio: 0.4,
                                                  motion: const ScrollMotion(),
                                                  children: [
                                                    CustomSlidableAction(
                                                      backgroundColor: Theme.of(
                                                              context)
                                                          .scaffoldBackgroundColor,
                                                      padding: EdgeInsets.zero,
                                                      onPressed: null,
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                          left: 12,
                                                          right: 6,
                                                          top: 2,
                                                          bottom: 2,
                                                        ),
                                                        width: double.maxFinite,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Icon(
                                                              Icons
                                                                  .edit_note_outlined,
                                                              color:
                                                                  Colors.white,
                                                              size: 20,
                                                            ),
                                                            Text(
                                                              'SỬA',
                                                              style: TextStyle(
                                                                fontSize: 8,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    CustomSlidableAction(
                                                      padding: EdgeInsets.zero,
                                                      backgroundColor: Theme.of(
                                                              context)
                                                          .scaffoldBackgroundColor,
                                                      onPressed: (context) {
                                                        context
                                                            .read<
                                                                CartTemplateCubit>()
                                                            .deleteItemInCart(
                                                              widget.id,
                                                              products[i].id,
                                                            );
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        width: double.maxFinite,
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 6,
                                                                  right: 12),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: const [
                                                              Icon(
                                                                Icons
                                                                    .delete_forever,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              ),
                                                              Text(
                                                                'XOÁ',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 8,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                child: ListTile(
                                                  dense: true,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  leading: AppImageWidget(
                                                    width: 36,
                                                    height: 36,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                    assetsDefaultImage:
                                                        assetDefaultIcon,
                                                    image: products[i]?.image,
                                                  ),
                                                  trailing: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        numberToCurrency(
                                                            costs[i], 'đ'),
                                                      ),
                                                      const Icon(
                                                        Icons
                                                            .keyboard_double_arrow_left_rounded,
                                                        size: 18,
                                                      )
                                                    ],
                                                  ),
                                                  title: Text(
                                                    '${model.products[i].amount} x ${products[i]?.name}',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                  subtitle: Text(
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    model.products[i].options
                                                        .map((e) => context
                                                            .read<
                                                                ProductCubit>()
                                                            .getProductOptionItemById(
                                                                e)
                                                            ?.name)
                                                        .join(', '),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 1,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: double.maxFinite,
                              height: dimLG,
                              padding: const EdgeInsets.only(
                                top: spaceXXS,
                                bottom: spaceXL,
                                left: spaceMD,
                                right: spaceXXS,
                              ),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(spaceSM),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  var message = await context
                                      .read<CartTemplateCubit>()
                                      .updateTemplate(
                                        model.id,
                                        name ?? model.name,
                                        model.products,
                                      );
                                  if (mounted) {
                                    if (message == null) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Cập nhật đơn hàng mẫu thành công!'),
                                        ),
                                      );
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
                                child: const Text(
                                  'Cập nhật',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: double.maxFinite,
                              height: dimLG,
                              padding: const EdgeInsets.only(
                                top: spaceXXS,
                                bottom: spaceXL,
                                left: spaceXXS,
                                right: spaceMD,
                              ),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(spaceSM),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  var message = await context
                                      .read<CartTemplateCubit>()
                                      .deleteCart(model.id);
                                  if (context.mounted) {
                                    if (message == null) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(txtDeleteTemplate),
                                        ),
                                      );
                                      context
                                          .read<AppBarCubit>()
                                          .addTemplateCart(-1);
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
                                child: const Text(
                                  'Xoá',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                case CartTemplateFailure:
                  return const SizedBox();
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}
