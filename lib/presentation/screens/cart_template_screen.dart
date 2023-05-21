import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/dialogs/app_dialog.dart';
import 'package:member_app/presentation/pages/initial_page.dart';
import 'package:member_app/presentation/pages/loading_page.dart';
import 'package:member_app/presentation/res/strings/values.dart';

import '../../business_logic/cubits/cart_template_cubit.dart';
import '../../business_logic/cubits/product_cubit.dart';
import '../../business_logic/states/cart_template_state.dart';
import '../../data/models/cart_template_model.dart';
import '../bottom_sheet/cart_template_bottom_sheet.dart';
import '../res/dimen/dimens.dart';
import '../widgets/cart_template_widget.dart';

class CartTemplateScreen extends StatefulWidget {
  const CartTemplateScreen({Key? key}) : super(key: key);

  @override
  State<CartTemplateScreen> createState() => _CartTemplateScreenState();
}

class _CartTemplateScreenState extends State<CartTemplateScreen> {
  List<CartTemplateModel> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: spaceXL,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        actions: [
          IconButton(
            splashRadius: spaceXL,
            onPressed: () async {
              var message = await context.read<CartTemplateCubit>().arrangeCart(
                    list.map((e) => e.id).toList(),
                  );
              if (mounted) {
                if (message == null) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        txtArrangeTemplate,
                      ),
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
            icon: const Icon(Icons.checklist_outlined),
          ),
        ],
        title: Text(
          txtCartTemplate,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocBuilder<CartTemplateCubit, CartTemplateState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartTemplateInitial:
              return const InitialPage();
            case CartTemplateLoading:
              return const LoadingPage();
            case CartTemplateLoaded:
              state as CartTemplateLoaded;
              if (list.isEmpty) {
                list = [...state.list];
              }
              if (list.length != state.list.length) {
                list = state.list;
              }
              return ReorderableListView.builder(
                padding: const EdgeInsets.only(bottom: dimMD),
                itemBuilder: (context, index) {
                  return CartTemplateWidget(
                    key: ValueKey(list[index].id),
                    onClick: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        isScrollControlled: true,
                        builder: (ctx) => BlocProvider<ProductCubit>.value(
                          value: BlocProvider.of<ProductCubit>(context),
                          child: CartTemplateBottomSheet(
                            model: list[index],
                          ),
                        ),
                      );
                    },
                    cart: list[index],
                  );
                },
                itemCount: list.length,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    var template = list.removeAt(oldIndex);
                    if (newIndex > oldIndex) {
                      newIndex--;
                    }
                    list.insert(newIndex, template);
                  });
                },
              );
          }
          return const LoadingPage();
        },
      ),
    );
  }
}
