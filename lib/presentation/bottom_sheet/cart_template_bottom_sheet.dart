import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:member_app/business_logic/cubits/app_bar_cubit.dart';
import 'package:member_app/business_logic/cubits/cart_template_cubit.dart';
import 'package:member_app/presentation/dialogs/app_dialog.dart';
import 'package:member_app/supports/extension.dart';

import '../../business_logic/blocs/interval/interval_bloc.dart';
import '../../business_logic/cubits/product_cubit.dart';
import '../../data/models/cart_template_model.dart';
import '../../data/models/product_model.dart';
import '../../supports/convert.dart';
import '../screens/product_search_screen.dart';
import '../res/dimen/dimens.dart';
import '../res/strings/values.dart';
import '../widgets/app_image_widget.dart';

class CartTemplateBottomSheet extends StatelessWidget {
  final CartTemplateModel model;

  const CartTemplateBottomSheet({
    Key? key,
    required this.model,
  }) : super(key: key);

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
            color: Colors.white,
            borderRadius: BorderRadius.circular(spaceMD),
          ),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: spaceSM,
                      ),
                      GestureDetector(
                        onTap: () async {
                          var message = await context
                              .read<CartTemplateCubit>()
                              .deleteCart(
                                model.id,
                              );
                          if (context.mounted) {
                            if (message == null) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(txtDeleteTemplate),
                                ),
                              );
                              context.read<AppBarCubit>().addTemplateCart(-1);
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
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 55,
                          width: double.maxFinite,
                          alignment: Alignment.center,
                          child: Text(
                            model.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: spaceSM),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: spaceSM,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          return MultiRepositoryProvider(
                                            providers: [
                                              BlocProvider<ProductCubit>.value(
                                                value: BlocProvider.of<
                                                    ProductCubit>(
                                                  context,
                                                ),
                                              ),
                                              BlocProvider<
                                                  IntervalBloc<ProductModel>>(
                                                create: (ctx) =>
                                                    IntervalBloc<ProductModel>(
                                                  submit: BlocProvider.of<
                                                      ProductCubit>(ctx),
                                                ),
                                              ),
                                            ],
                                            child: ProductSearchScreen(
                                              onClick: (model) {
                                                Navigator.pop(context);
                                              },
                                              withFloatingButton: false,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.orange.withAlpha(20),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(spaceMD),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    txtAdd,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: model.products
                                      .map(
                                        (e) => Row(
                                          children: [
                                            Expanded(
                                              child: ListTile(
                                                onTap: () {},
                                                dense: true,
                                                contentPadding: EdgeInsets.zero,
                                                leading: AppImageWidget(
                                                  width: 36,
                                                  height: 36,
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  assetsDefaultImage:
                                                      assetDefaultIcon,
                                                  image:
                                                      'https://product.hstatic.net/1000075078/product/1669736835_ca-phe-sua-da_15ae84580c4141fc809ac8fffd72b194.png',
                                                ),
                                                trailing: Text(
                                                  numberToCurrency(100000, 'đ'),
                                                ),
                                                title: Text(
                                                  '${e.id} x ${e.amount}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                                subtitle: Text(
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  e.options.join(', '),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: spaceMD,
                                              width: 1,
                                              color: Colors.black87,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: spaceSM),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: const Text(txtDelete),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
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
              Container(
                width: double.maxFinite,
                height: dimLG,
                padding: const EdgeInsets.only(
                  top: spaceXXS,
                  bottom: spaceXL,
                  left: spaceMD,
                  right: spaceMD,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(spaceSM),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Đặt ngay',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
