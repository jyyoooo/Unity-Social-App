import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_location_search/flutter_location_search.dart';
import 'package:unitysocial/features/recruit/bloc/recruit_bloc.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    Key? key,
    required this.recruitBloc,
    required this.selectedLocation,
  }) : super(key: key);
  final RecruitBloc recruitBloc;
  final LocationData? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          selectedLocation != null
              ? Expanded(
                  child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(selectedLocation!.address),
                ))
              : const Expanded(
                  child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text('Select location'),
                )),
          IconButton(
            icon: const Icon(
              CupertinoIcons.location,
              color: CupertinoColors.activeBlue,
            ),
            onPressed: () async {
              final currentLocation = await LocationSearch.show(
                  searchBarTextColor: CupertinoColors.activeBlue,
                  context: context,
                  lightAdress: true,
                  mode: Mode.fullscreen);
              if (currentLocation != null) {
                recruitBloc.add(
                    LocationSelectEvent(selectedLocation: currentLocation));
              }
            },
          ),
        ],
      ),
    );
  }
}
