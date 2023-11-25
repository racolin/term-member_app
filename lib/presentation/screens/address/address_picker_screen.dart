import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:member_app/presentation/widgets/address/location_widget.dart';

import '../../../business_logic/blocs/interval/interval_bloc.dart';
import '../../../business_logic/cubits/address_cubit.dart';
import '../../../business_logic/cubits/geolocator_cubit.dart';
import '../../animation/typing_animation.dart';
import '../../dialogs/app_dialog.dart';
import '../../res/dimen/dimens.dart';
import '../../res/strings/values.dart';
import 'map_picker_screen.dart';

class AddressPickerScreen extends StatefulWidget {
  const AddressPickerScreen({Key? key}) : super(key: key);

  @override
  State<AddressPickerScreen> createState() => _AddressPickerScreenState();
}

class _AddressPickerScreenState extends State<AddressPickerScreen> {
  @override
  void initState() {
    var current = context.read<GeolocatorCubit>().state.latLng;
    context.read<AddressCubit>().location = Location(
      lat: current.latitude,
      lng: current.longitude,
    );
    context.read<IntervalBloc<AddressEntity>>().add(IntervalSearch(key: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<IntervalBloc<AddressEntity>, IntervalState>(
        builder: (context, state) {
          var list = <AddressEntity>[];
          if (state is IntervalLoaded<AddressEntity>) {
            list = state.list;
          }
          return Column(
            children: [
              _getSearchAddress(context, state),
              const Divider(height: 1),
              ListTile(
                tileColor: Colors.white,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) {
                        return BlocProvider<AddressCubit>.value(
                          value: BlocProvider.of<AddressCubit>(context),
                          child: const MapPickerScreen(),
                        );
                      },
                    ),
                  ).then((model) {
                    if (model != null && model is AddressEntity) {
                      Navigator.pop(context, model);
                    }
                  });
                },
                leading: const Icon(
                  Icons.map_outlined,
                  color: Colors.black,
                ),
                title: const Text(
                  'Chọn từ bản đồ',
                  style: TextStyle(fontSize: fontLG),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) => LocationWidget(
                      model: list[index],
                      onClick: () {
                        Navigator.pop(context, list[index]);
                      },
                    ),
                    padding: const EdgeInsets.only(bottom: dimLG),
                    itemCount: list.length,
                  ),
                ),
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
                  height: dimLG,
                  color: Colors.orange,
                  padding: const EdgeInsets.only(top: dimXXS),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.my_location,
                          size: fontXL, color: Colors.white),
                      SizedBox(width: spaceXS),
                      Text(
                        'Cập nhật vị trí để tính khoảng cách',
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
        },
      ),
    );
  }

  Widget _getSearchAddress(BuildContext context, IntervalState state) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: dimMD),
      child: Padding(
        padding: const EdgeInsets.all(spaceXS),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(spaceXS),
                  ),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: (state is IntervalLoaded && state.reload)
                      ? TypingAnimation(
                          backgroundColor: Colors.grey.shade100,
                          color: Colors.grey.shade400,
                          activeColor: Colors.orange.shade500,
                        )
                      : null,
                ),
                style: Theme.of(context).textTheme.bodyLarge,
                onChanged: (value) {
                  context.read<IntervalBloc<AddressEntity>>().add(
                        IntervalSearch(key: value),
                      );
                },
              ),
            ),
            const SizedBox(
              width: spaceXXS,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(spaceXS),
              child: Container(
                padding: const EdgeInsets.all(spaceXXS),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(spaceXS),
                ),
                child: const Text(
                  txtCancel,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
