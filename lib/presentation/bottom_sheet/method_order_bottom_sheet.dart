import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/repositories/store_repository.dart';
import 'package:member_app/presentation/app_router.dart';

import '../../business_logic/blocs/interval/interval_bloc.dart';
import '../../business_logic/cubits/store_cubit.dart';
import '../../data/models/store_model.dart';
import '../../data/repositories/store_api_repository.dart';
import '../../presentation/res/strings/values.dart';
import '../../data/models/cart_model.dart';
import '../pages/store_search_page.dart';

class MethodOrderBottomSheet extends StatelessWidget {
  final DeliveryType? type;
  final String? addressName;

  const MethodOrderBottomSheet({
    Key? key,
    required this.type,
    required this.addressName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: const EdgeInsets.all(12),
                child: const Text(
                  txtSelectDeliveryTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    size: 22,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            height: 1,
          ),
          for (var method in [
            DeliveryType.delivery,
            DeliveryType.takeOut,
          ])
            Container(
              color:
                  type == method ? Colors.orange.withAlpha(30) : Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 16,
                  child: Image.asset(
                    method.image,
                    fit: BoxFit.cover,
                  ),
                ),
                trailing: ElevatedButton(
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (method == DeliveryType.delivery) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => RepositoryProvider<StoreRepository>(
                            create: (ctx) => StoreApiRepository(),
                            child: MultiBlocProvider(
                              providers: [
                                BlocProvider<StoreCubit>(
                                  create: (ctx) => StoreCubit(
                                    repository: RepositoryProvider.of<StoreRepository>(ctx),
                                  ),
                                ),
                                BlocProvider<IntervalBloc<StoreModel>>(
                                  create: (ctx) => IntervalBloc<StoreModel>(
                                    submit:
                                    BlocProvider.of<StoreCubit>(ctx),
                                  ),
                                ),
                              ],
                              child: StoreSearchPage(
                                onCLick: (StoreModel store) {
                                  Navigator.pop(ctx);
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (method == DeliveryType.takeOut) {
                      Navigator.pushNamed(context, AppRouter.selectAddress);
                    }
                  },
                  child: Text(
                    method == type ? txtEdit : txtSelect,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                title: Text(
                  method.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: Text(
                  method == type
                      ? (addressName ?? type!.description)
                      : method.description,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 0),
        ],
      ),
    );
  }
}
