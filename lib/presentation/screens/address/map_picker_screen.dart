import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:member_app/business_logic/cubits/geolocator_cubit.dart';
import 'package:member_app/presentation/res/strings/values.dart';
import 'package:member_app/presentation/widgets/address/location_widget.dart';

import '../../../business_logic/cubits/address_cubit.dart';
import '../../res/dimen/dimens.dart';

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({Key? key}) : super(key: key);

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  List<AddressEntity> addresses = [];
  late LatLng current;

  @override
  void initState() {
    current = context.read<GeolocatorCubit>().state.latLng;
    pick();
    super.initState();
  }

  void pick() {
    var location = Location(
      lat: current.latitude,
      lng: current.longitude,
    );
    context
        .read<AddressCubit>()
        .searchLocation(location, radius: 50)
        .then((value) {
      setState(() {
        addresses = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chọn địa chỉ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: fontLG,
          ),
        ),
        leading: IconButton(
          splashRadius: spaceXL,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: context.read<GeolocatorCubit>().state.latLng,
              zoom: 15,
            ),
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            onCameraMove: (position) {
              current = position.target;
            },
            onCameraIdle: () {
              pick();
            },
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Image.asset(
                  assetCurrentLocationIcon,
                  height: 36,
                  width: 28.8,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                constraints: const BoxConstraints(
                  maxHeight: 300,
                  minHeight: 0,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) => LocationWidget(
                    model: addresses[index],
                    root: current,
                    onClick: () {
                      Navigator.pop(context, addresses[index]);
                    },
                  ),
                  padding: EdgeInsets.zero,
                  itemCount: addresses.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
