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
    return Card(
      elevation: .2,
      color: Colors.grey[200],
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          final currentLocation = await LocationSearch.show(
              searchBarTextColor: CupertinoColors.activeBlue,
              context: context,
              lightAdress: true,
              mode: Mode.fullscreen);
          if (currentLocation != null) {
            recruitBloc
                .add(LocationSelectEvent(selectedLocation: currentLocation));
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selectedLocation != null ? _showAddress() : _selectAddress(),
            const Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(
                CupertinoIcons.location,
                color: CupertinoColors.activeBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _selectAddress() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        'Select location',
        style: TextStyle(
            color: Colors.black87.withOpacity(.7),
            fontSize: 15,
            fontWeight: FontWeight.w500),
      ),
    ));
  }

  Expanded _showAddress() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(selectedLocation!.address),
    ));
  }
}
