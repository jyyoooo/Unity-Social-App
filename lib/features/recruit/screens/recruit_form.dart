// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_location_search/flutter_location_search.dart';

import 'package:unitysocial/core/widgets/custom_button.dart';
import 'package:unitysocial/core/widgets/snack_bar.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';
import 'package:unitysocial/core/widgets/unity_text_field.dart';
import 'package:unitysocial/features/recruit/bloc/recruit_bloc.dart';
import 'package:unitysocial/features/recruit/data/models/badge_model.dart';
import 'package:unitysocial/features/recruit/screens/widgets/date_time_range_widgets.dart';
import 'package:unitysocial/features/recruit/screens/widgets/location_picker_widgets.dart';

import 'widgets/badge_grid_widget.dart';
import 'widgets/category_selector_widget.dart';
import 'widgets/text_field_header_widget.dart';

class RecruitForm extends StatefulWidget {
  const RecruitForm({Key? key}) : super(key: key);

  @override
  State<RecruitForm> createState() => _RecruitFormState();
}

class _RecruitFormState extends State<RecruitForm> {
  List<String> selectedBadges = [];
  final today = DateTime.now();
  DateTimeRange? selectedDateTimeRange;
  LocationData? selectedLocation;
  String selectedCategory = '';
  List<AchievementBadge>? allbadges;

  void handleBadgeSelection(AchievementBadge badge, bool isSelected) {
    if (isSelected) {
      setState(() {
        selectedBadges.add(badge.id!);
      });
    } else {
      setState(() {
        selectedBadges.remove(badge.id!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<RecruitBloc>().add(FetchBadgesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final recruitProvider = BlocProvider.of<RecruitBloc>(context);
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: UnityAppBar(
            showBackBtn: true,
            title: 'Recruitment Form',
          )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: recruitProvider.recruitFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const TextFieldHeader(
                  title: 'Name',
                ),
                CustomTextField(
                    obscureText: false,
                    controller: recruitProvider.titleController,
                    hintText: 'Title  of the cause',
                    validator: () {}),
                const TextFieldHeader(title: 'Description'),
                CustomTextField(
                    obscureText: false,
                    maxLines: 4,
                    controller: recruitProvider.descriptionController,
                    hintText: 'Description  of the cause',
                    validator: () {}),

                // CATEGORY SELECTOR
                const TextFieldHeader(title: 'Select category'),
                CategorySelector(
                  onChanged: (catFromWidget) =>
                      selectedCategory = catFromWidget ?? '',
                ),
                // MAXIMUM MEMBERS
                const TextFieldHeader(title: 'Maximum members'),
                CustomTextField(
                  controller: recruitProvider.membersController,
                  hintText: 'How many members do you need?',
                  validator: () {},
                  onlyNumbers: true,
                ),

                // DATE RANGE WIDGET
                const TextFieldHeader(title: 'Duration'),
                BlocBuilder<RecruitBloc, RecruitState>(
                  builder: (context, state) {
                    if (state is DateRangeUpdatedState) {
                      selectedDateTimeRange = state.updatedDateTimeRange;
                      return DateTimeRangeWidget(
                          dateRange: state.updatedDateTimeRange,
                          recruitProvider: recruitProvider);
                    } else {
                      return DateTimeRangeWidget(
                          dateRange: selectedDateTimeRange,
                          recruitProvider: recruitProvider);
                    }
                  },
                ),
                // LOCATION SELECTOR
                const TextFieldHeader(title: 'Location'),
                BlocBuilder<RecruitBloc, RecruitState>(
                  builder: (context, state) {
                    if (state is LocationUpdatedState) {
                      selectedLocation = state.selectedLocation;
                      return LocationWidget(
                          recruitBloc: recruitProvider,
                          selectedLocation: state.selectedLocation);
                    } else {
                      return LocationWidget(
                          recruitBloc: recruitProvider,
                          selectedLocation: selectedLocation);
                    }
                  },
                ),
                // PARTICIPATION REWARDS
                const TextFieldHeader(title: 'Participation Rewards'),
                BlocBuilder<RecruitBloc, RecruitState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return const CircularProgressIndicator();
                    } else if (state is BadgeFetchSuccessState) {
                      allbadges = state.allbadges;
                      return BadgesGridWidget(
                        allbadges: state.allbadges,
                        passSelectedBadgeToForm: (badge, isSelected) =>
                            handleBadgeSelection(badge, isSelected),
                      );
                    }
                    return BadgesGridWidget(
                      allbadges: allbadges,
                      passSelectedBadgeToForm: (badge, isSelected) =>
                          handleBadgeSelection(badge, isSelected),
                    );
                  },
                ),

                CustomButton(
                  label: 'Submit for approval',
                  onPressed: () {
                    log('selected cat $selectedCategory');
                    log('selected daterange $selectedDateTimeRange');
                    log('selected location ${selectedLocation?.address}');
                    log('selected badges: ${selectedBadges.map((e) => e)}');
                    log(FirebaseAuth.instance.currentUser.toString());
                    recruitProvider.recruitFormKey.currentState!.validate();
                    if (selectedLocation?.address == '') {
                      log('hererere');
                      showSnackbar(context, 'Location is not selected');
                    }
                    if (selectedDateTimeRange?.start.day == today.day ||
                        selectedDateTimeRange == null) {
                      showSnackbar(context, 'Date range is not selected');
                    }
                    if (selectedCategory == '') {
                      showSnackbar(context, 'Category is not selected');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
