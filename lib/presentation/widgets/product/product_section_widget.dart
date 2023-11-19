import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/presentation/pages/loading_page.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/widgets/product/product_normal_widget.dart';

import '../../../business_logic/blocs/interval/interval_bloc.dart';
import '../../../business_logic/cubits/cart_cubit.dart';
import '../../../business_logic/cubits/home_cubit.dart';
import '../../../business_logic/cubits/product_cubit.dart';
import '../../../business_logic/states/product_state.dart';
import '../../../data/models/product_model.dart';
import '../../app_router.dart';
import '../../res/strings/values.dart';
import '../../screens/product_favorite_screen.dart';
import '../../screens/product_search_screen.dart';

class ProductSectionWidget extends StatefulWidget {
  final bool login;

  const ProductSectionWidget({
    Key? key,
    required this.login,
  }) : super(key: key);

  @override
  State<ProductSectionWidget> createState() => _ProductSectionWidgetState();
}

class _ProductSectionWidgetState extends State<ProductSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(spaceXS),
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: spaceXS),
          Card(
            color: Colors.white.withOpacity(0.92),
            elevation: 0.5,
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(spaceXS),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: dimXS,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.grey.withAlpha(76)),
                          overlayColor: MaterialStateProperty.all(
                              Colors.grey.withAlpha(63)),
                          elevation: MaterialStateProperty.all(0),
                        ),
                        icon: const Icon(Icons.search, color: Colors.grey),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) {
                                return MultiRepositoryProvider(
                                  providers: [
                                    BlocProvider<HomeCubit>.value(
                                      value: BlocProvider.of<HomeCubit>(
                                        context,
                                      ),
                                    ),
                                    BlocProvider<IntervalBloc<ProductModel>>(
                                      create: (ctx) =>
                                          IntervalBloc<ProductModel>(
                                        submit:
                                            BlocProvider.of<ProductCubit>(ctx),
                                      ),
                                    ),
                                  ],
                                  child: const ProductSearchScreen(),
                                );
                              },
                            ),
                          );
                        },
                        label: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            txtSearch,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: spaceXS),
                  SizedBox(
                    width: dimXS,
                    height: dimXS,
                    child: GestureDetector(
                      onTap: () {
                        if (!widget.login) {
                          Navigator.pushNamed(context, AppRouter.auth);
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) {
                              return MultiRepositoryProvider(
                                providers: [
                                  BlocProvider<ProductCubit>.value(
                                    value: BlocProvider.of<ProductCubit>(
                                      context,
                                    ),
                                  ),
                                  BlocProvider<HomeCubit>.value(
                                    value: BlocProvider.of<HomeCubit>(
                                      context,
                                    ),
                                  ),
                                  BlocProvider<CartCubit>.value(
                                    value: BlocProvider.of<CartCubit>(
                                      context,
                                    ),
                                  ),
                                ],
                                child: const ProductFavoriteScreen(),
                              );
                            },
                          ),
                        );
                      },
                      child: Card(
                        elevation: 0,
                        color: Colors.orange.withAlpha(36),
                        margin: EdgeInsets.zero,
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.orange,
                          size: fontXXL,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
            switch (state.runtimeType) {
              case ProductInitial:
                return const SizedBox();
              case ProductLoading:
                return const LoadingWidget();
              case ProductLoaded:
                state as ProductLoaded;
                return Column(
                  children: state.listType
                      .map((e) => _getListProduct(
                          e.name, state.getProductsByCategoryId(e.id)))
                      .toList(),
                );
              case ProductFailure:
                return const SizedBox();
            }
            return const SizedBox(height: spaceSM);
          }),
        ],
      ),
    );
  }

  Widget _getListProduct(
    String title,
    List<ProductModel> shortProducts,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: spaceSM),
        Padding(
          padding: const EdgeInsets.only(
            top: spaceXXS,
            bottom: spaceXS,
          ),
          child: Text(
            title,
            style: const TextStyle(
              height: 1.25,
              fontSize: fontLG,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 7 / 9,
            crossAxisSpacing: spaceSM,
          ),
          itemBuilder: (context, index) {
            return ProductNormalWidget(
              model: shortProducts[index],
            );
          },
          itemCount: shortProducts.length,
        ),
      ],
    );
  }
}
