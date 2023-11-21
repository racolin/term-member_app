import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:member_app/business_logic/cubits/geolocator_cubit.dart';
import 'package:member_app/business_logic/cubits/store_cubit.dart';
import 'package:member_app/exception/app_message.dart';
import 'package:member_app/presentation/bottom_sheet/store_bottom_sheet.dart';
import 'package:member_app/presentation/dialogs/app_dialog.dart';
import 'package:member_app/presentation/res/dimen/dimens.dart';
import 'package:member_app/presentation/res/strings/values.dart';
import 'package:member_app/presentation/widgets/app_image_widget.dart';
import 'package:member_app/supports/convert.dart';

import '../../business_logic/blocs/interval/interval_bloc.dart';
import '../../business_logic/states/store_state.dart';
import '../../data/models/store_model.dart';
import '../widgets/store/store_item_widget.dart';
import 'package:latlong2/latlong.dart';
import '../screens/store_search_screen.dart';

class StoreBody extends StatelessWidget {
  static const String searchTag = 'Search';
  final bool login;

  const StoreBody({
    Key? key,
    this.login = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case StoreInitial:
            return const SizedBox();
          case StoreLoading:
            return const SizedBox();
          case StoreLoaded:
            state as StoreLoaded;
            return Column(
              children: [
                _getSearchAddress(context, state.isMap),
                Expanded(
                  child: state.isMap
                      ? _getMapStore(context, state.list)
                      : _getListStore(context, state.list),
                ),
                InkWell(
                  splashColor: Colors.green,
                  onTap: () async {
                    var message =
                    await context.read<GeolocatorCubit>().uploadPosition();
                    if (context.mounted && message != null) {
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
                  },
                  child: Ink(
                    width: double.maxFinite,
                    height: dimXS,
                    color: Colors.orange,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.my_location, size: fontXL, color: Colors.white),
                        SizedBox(width: spaceXS),
                        Text(
                          'Cập nhật vị trí',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
        }
        return const SizedBox();
      },
    );
  }

  List<Marker> _getMarkers(BuildContext context, List<StoreModel> list) {
    var lst = list
        .map((e) => Marker(
              height: dimXS,
              width: dimXS,
              rotate: true,
              point: LatLng(e.lat, e.lng),
              builder: (context) => GestureDetector(
                onTap: () {
                  _onClickStore(context, e);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(dimXS),
                  child: const ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.orange,
                      BlendMode.color,
                    ),
                    child: AppImageWidget(
                      image: assetDefaultIcon,
                      assetsDefaultImage: assetDefaultIcon,
                      width: dimXS,
                      height: dimXS,
                    ),
                  ),
                ),
              ),
            ))
        .toList();
    lst.add(
      Marker(
        height: dimXS,
        width: dimXS,
        rotate: true,
        point: context.read<GeolocatorCubit>().state.latLng,
        builder: (context) => const Icon(
          Icons.location_on_rounded,
          color: Colors.red,
          size: dimXS,
        ),
      ),
    );
    return lst;
  }

  void _onClickStore(BuildContext context, StoreModel model) {
    context.read<StoreCubit>().loadDetailStore(model.id).then((message) {
      if (message != null) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return AppDialog(
              message: message,
              actions: [
                CupertinoDialogAction(
                  child: const Text(txtYes),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      } else {
        var detail = context.read<StoreCubit>().detailStore;
        if (detail == null) {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return AppDialog(
                message: AppMessage(
                  type: AppMessageType.error,
                  title: txtErrorTitle,
                  content: 'Không có dữ liệu. Hãy thử lại!',
                ),
                actions: [
                  CupertinoDialogAction(
                    child: const Text(txtYes),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        } else {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) {
              return StoreBottomSheet(
                store: model,
                detail: detail,
                login: login,
              );
            },
          );
        }
      }
    });
  }

  Widget _getMapStore(BuildContext context, List<StoreModel> list) {
    return FlutterMap(
      options: MapOptions(
        center: context.read<GeolocatorCubit>().state.latLng,
        zoom: 15,
        maxZoom: 18,
        minZoom: 12,
        keepAlive: true,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: _getMarkers(context, list),
        ),
      ],
    );
  }

  Widget _getListStore(BuildContext context, List<StoreModel> list) {
    for (var i = 0; i < list.length; i++) {
      list[i].distance = positionToDistance(
        context.read<GeolocatorCubit>().state.latLng.latitude,
        context.read<GeolocatorCubit>().state.latLng.longitude,
        list[i].lat,
        list[i].lng,
      );
    }
    list.sort(
      (a, b) => a.distance - b.distance,
    );
    return RefreshIndicator(
      onRefresh: () async {
        var message = await context.read<StoreCubit>().reloadStores();
        if (context.mounted) {
          if (message != null) {
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return AppDialog(
                  message: message,
                  actions: [
                    CupertinoDialogAction(
                      child: const Text(txtYes),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          } else {}
        }
      },
      child: ListView.builder(
        itemBuilder: (context, index) => StoreItemWidget(
          store: list[index],
          onClick: (model) {
            _onClickStore(context, model);
          },
        ),
        padding: const EdgeInsets.only(bottom: dimLG),
        itemCount: list.length,
      ),
    );
  }

  Widget _getSearchAddress(BuildContext context, bool isMap) {
    return Hero(
      tag: searchTag,
      child: Material(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(
            bottom: spaceXS,
            left: spaceXS,
            right: spaceXS,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) =>
                            BlocProvider<IntervalBloc<StoreModel>>(
                          create: (ctx) => IntervalBloc<StoreModel>(
                            submit: BlocProvider.of<StoreCubit>(context),
                          ),
                          child: StoreSearchScreen(
                            onClick: (StoreModel model) {
                              context
                                  .read<StoreCubit>()
                                  .loadDetailStore(model.id)
                                  .then((message) {
                                if (message != null) {
                                  showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return AppDialog(
                                        message: message,
                                        actions: [
                                          CupertinoDialogAction(
                                            child: const Text(txtYes),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  var detail =
                                      context.read<StoreCubit>().detailStore;
                                  if (detail == null) {
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return AppDialog(
                                          message: AppMessage(
                                            type: AppMessageType.error,
                                            title: txtErrorTitle,
                                            content:
                                                'Không có dữ liệu. Hãy thử lại!',
                                          ),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: const Text(txtYes),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return StoreBottomSheet(
                                          store: model,
                                          detail: detail,
                                          login: login,
                                        );
                                      },
                                    );
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(spaceXS),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(
                width: spaceXXS,
              ),
              InkWell(
                onTap: () {
                  context.read<StoreCubit>().changeIsMap();
                },
                borderRadius: BorderRadius.circular(spaceSM),
                child: Container(
                  padding: const EdgeInsets.all(spaceXXS),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(spaceXS),
                  ),
                  child: isMap
                      ? Row(
                          children: const [
                            Icon(Icons.list, size: fontLG),
                            SizedBox(
                              width: spaceXXS,
                            ),
                            Text(
                              txtList,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: const [
                            Icon(Icons.map_outlined, size: fontLG),
                            SizedBox(
                              width: spaceXXS,
                            ),
                            Text(
                              txtMap,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
