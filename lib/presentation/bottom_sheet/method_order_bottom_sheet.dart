import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_app/business_logic/cubits/cart_cubit.dart';
import 'package:member_app/business_logic/repositories/store_repository.dart';
import 'package:member_app/data/models/address_model.dart';
import 'package:member_app/exception/app_message.dart';
import 'package:member_app/presentation/app_router.dart';
import 'package:member_app/presentation/dialogs/app_dialog.dart';

import '../../business_logic/blocs/interval/interval_bloc.dart';
import '../../business_logic/cubits/geolocator_cubit.dart';
import '../../business_logic/cubits/store_cubit.dart';
import '../../data/models/store_model.dart';
import '../../data/repositories/api/store_api_repository.dart';
import '../../presentation/res/strings/values.dart';
import '../../data/models/cart_model.dart';
import '../../supports/convert.dart';
import '../screens/store_search_screen.dart';

class MethodOrderBottomSheet extends StatelessWidget {
  final DeliveryType? type;
  final String? addressName;
  final bool login;

  const MethodOrderBottomSheet({
    Key? key,
    required this.type,
    required this.addressName,
    this.login = false,
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
          const Divider(height: 1),
          for (var method in [
            DeliveryType.delivery,
            DeliveryType.takeOut,
          ])
            Container(
              color: type == method
                  ? Colors.orange.withAlpha(
                      30,
                    )
                  : Colors.white,
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
                    if (login == false) {
                      Navigator.pushNamed(
                        context,
                        AppRouter.auth,
                      );
                      return;
                    }
                    if (method == DeliveryType.delivery) {
                      Navigator.pushNamed(
                        context,
                        AppRouter.addressSearch,
                      ).then((value) {
                        if (value == null || value is! AddressModel) {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return AppDialog(
                                message: AppMessage(
                                  type: AppMessageType.failure,
                                  title: txtFailureTitle,
                                  content: 'Không có địa chỉ nào được trả về.',
                                ),
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
                        var address = value as AddressModel;
                        context.read<CartCubit>().setCategory(2);
                        context.read<CartCubit>().setAddress(
                              address.address,
                              '${address.receiver} ${address.name}',
                            );

                        context.read<CartCubit>().setReceiver(
                              address.receiver,
                              address.phone,
                            );

                        Navigator.pop(context);
                      });
                    } else if (method == DeliveryType.takeOut) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => RepositoryProvider<StoreRepository>(
                            create: (ctx2) => StoreApiRepository(),
                            child: MultiBlocProvider(
                              providers: [
                                BlocProvider<StoreCubit>(
                                  create: (ctx) => StoreCubit(
                                    repository:
                                        RepositoryProvider.of<StoreRepository>(
                                            ctx),
                                  ),
                                ),
                                BlocProvider<IntervalBloc<StoreModel>>(
                                  create: (ctx) => IntervalBloc<StoreModel>(
                                    submit: BlocProvider.of<StoreCubit>(ctx),
                                  ),
                                ),
                              ],
                              child: Builder(
                                builder: (context) {
                                  return StoreSearchScreen(
                                    onClick: (StoreModel store) async {
                                      context.read<CartCubit>().setCategory(1);
                                      context.read<CartCubit>().setAddress(
                                            store.address,
                                            positionToDistanceString(
                                              store.lat,
                                              store.lng,
                                              context.read<GeolocatorCubit>().state.latLng.latitude,
                                              context.read<GeolocatorCubit>().state.latLng.longitude,
                                            ),
                                          );
                                      context
                                          .read<StoreCubit>()
                                          .getDetailStore(store.id)
                                          .then((detail) {
                                        if (detail != null) {
                                          context.read<CartCubit>().setStore(
                                                store,
                                                detail,
                                              );
                                          print('23232323');
                                        } else {
                                          print('23232323222222');
                                        }
                                      });

                                      Navigator.pop(ctx);
                                      Navigator.pop(ctx);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
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
