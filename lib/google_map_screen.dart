import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Constants/Constants.dart';
import 'package:flutter_base/core/utils/extensions/request_handle_extension.dart';
import 'package:flutter_base/core/widgets/custom_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'core/utils/location_handler.dart';
import 'core/utils/permissions_handler.dart';
import 'core/widgets/svg_icons.dart';
import 'features/common/presentation/providers/usecases_providers.dart';
import 'features/home/persentaion/widget/search_with_filter.dart';

import 'package:http/http.dart' as http;


class GoogleMapScreen extends ConsumerStatefulWidget {
  final LatLng? locationSelected;
  const GoogleMapScreen({super.key, this.locationSelected});

  @override
  ConsumerState<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends ConsumerState<GoogleMapScreen> {
  final Completer<GoogleMapController> controller = Completer();

  CameraPosition currentLocation = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 11);
  Position? _currentPosition;
  LatLng? _currentLatLng;
  Marker? _marker;
  TextEditingController _controller = TextEditingController();
  // List<dynamic> _suggestions = [];

  void _onMapCreated(GoogleMapController _controller) {
    controller.complete(_controller);
    // Listen to camera movements
    if (widget.locationSelected != null) {
      _controller
          .animateCamera(CameraUpdate.newLatLng(widget.locationSelected!));
    } else {
      _getLocation();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final suggestionsState = ref.watch(getSuggestionsUseCaseProvider);

    handleState(getLatLngFromPlaceIdUseCaseProvider,onSuccess: (res){
      if(res.data != null){
        _currentLatLng = res.data;
        moveCamera(res.data ?? const LatLng(0.0, 0.0));
        clearSuggestion();
      }
    });

    return Scaffold(
      appBar: CustomAppBar(
        appContext: context,
        title: "Map Search",
        navigated: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsetsDirectional.only(start: defaultPaddingHorizontal,end: defaultPaddingHorizontal,bottom: defaultPaddingHorizontal),
            child: Column(
              children: [
                AppSearchBarWithFilter(
                  hasFilter: false,
                  enableSearch: true,
                  hintTxt: "Type your location",
                  delay: 1,
                  prefixIcon: SVGIcons.gpsIcon(),
                  controller: _controller,
                  onTextChangeListener: _onSearchChanged
                ),
                SizedBox(
                  height: suggestionsState.data?.isNotEmpty == true ? 300 : 0,
                  child: ListView.builder(
                    itemCount: suggestionsState.data?.length,
                    itemBuilder: (context, index) {
                      final suggestion = suggestionsState.data?[index];
                      return ListTile(
                        title: Text(suggestion['description']),
                        onTap: () {
                          _controller.text = suggestion['description'];
                          _onSuggestionTap(suggestion['place_id']);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: currentLocation,
                  markers: _marker != null ? {_marker!} : {},
                  // onCameraIdle: _onCameraIdle, // Use this callback
                  onCameraMove: _onCameraUpdate,
                ),
                _currentLatLng != null
                    ? Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Padding(
                          padding: const EdgeInsets.all(37.0),
                          child: InkWell(
                              onTap: () {
                                context.pop(_currentLatLng);
                              },
                              child: Text("Done")),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getLocation,
        materialTapTargetSize: MaterialTapTargetSize.padded,
        backgroundColor: Colors.green,
        child: const Icon(Icons.map, size: 36.0),
      ),
    );
  }

  void _onSearchChanged(String input) async {
    ref.read(getSuggestionsUseCaseProvider.notifier).clearSuggestions();
    ref.read(getSuggestionsUseCaseProvider.notifier).call(input);
  }

  void _onSuggestionTap(String placeId)  {
    ref.read(getLatLngFromPlaceIdUseCaseProvider.notifier).call(placeId);
  }

  void _getLocation() async {
    if (await PermissionsHandler.checkLocationPermission()) {
      var position = await LocationHandler.getCurrentLocation();
      _currentLatLng = LatLng(position!.latitude, position.longitude);
      moveCamera(LatLng(position.latitude, position.longitude));
      initOrUpdateMarker(_currentLatLng!);
    } else {}
  }

  void moveCamera(LatLng location) async {
    var _controller = await controller.future;
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: location, zoom: 15)));
  }

  void initOrUpdateMarker(LatLng position) {
    setState(() {
      if (_marker == null) {
        _marker = Marker(
          markerId: MarkerId('currentLocation'),
          position: position,
        );
      } else {
        _marker = _marker!.copyWith(positionParam: position);
      }
    });
  }

  void _onCameraUpdate(CameraPosition position) {
    _currentLatLng = position.target;
    initOrUpdateMarker(position.target);
    print("${position.target}");
  }

  void clearSuggestion() {
    ref.read(getSuggestionsUseCaseProvider.notifier).clearSuggestions();
  }
}
