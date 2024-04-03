// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_location_search/flutter_location_search.dart';
import 'package:unitysocial/core/utils/validators/validators.dart';

import 'package:unitysocial/core/widgets/custom_button.dart';
import 'package:unitysocial/core/widgets/snack_bar.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';
import 'package:unitysocial/core/widgets/unity_text_field/unity_text_field.dart';
import 'package:unitysocial/features/recruit/bloc/recruit_bloc.dart';
import 'package:unitysocial/features/recruit/data/models/badge_model.dart';
import 'package:unitysocial/features/recruit/data/models/location_model.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';
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
          preferredSize: Size.fromHeight(80),
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
                const TextFieldHeader(title: 'Name'),
                UnityTextField(
                    controller: recruitProvider.titleController,
                    hintText: 'Title  of the cause',
                    validator: titlevalidation),
                const TextFieldHeader(title: 'Description'),
                UnityTextField(
                    maxLines: 4,
                    controller: recruitProvider.descriptionController,
                    hintText: 'Description  of the cause',
                    validator: descriptionValidation),

                // CATEGORY SELECTOR
                const TextFieldHeader(title: 'Select category'),
                CategorySelector(
                  onChanged: (catFromWidget) =>
                      selectedCategory = catFromWidget ?? '',
                ),
                // MAXIMUM MEMBERS
                const TextFieldHeader(title: 'Maximum members'),
                UnityTextField(
                  controller: recruitProvider.membersController,
                  hintText: 'How many members do you need?',
                  validator: maximumMembersValidation,
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
                      log('${selectedLocation?.addressData}');
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
                      return const CircularProgressIndicator(
                        strokeWidth: 1.5,
                      );
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

                BlocBuilder<RecruitBloc, RecruitState>(
                    builder: (context, state) {
                  if (state is SentForApproval) {
                    return sentForApprovalWidget();
                  }
                  return CustomButton(
                    label: 'Submit for approval',
                    onPressed: () {
                      String errorMsg = '';
                      final form = recruitProvider.recruitFormKey.currentState!;
                      if (!form.validate()) {
                        errorMsg = 'Check missing fields';
                      } else if (selectedCategory == '') {
                        errorMsg = 'Category is not selected';
                      } else if (selectedDateTimeRange?.start.day ==
                              DateTime.now().day ||
                          selectedDateTimeRange == null) {
                        errorMsg = 'Date range is not selected';
                      } else if (selectedLocation == null) {
                        errorMsg = 'Location is not selected';
                      } else if (selectedBadges.isEmpty) {
                        errorMsg = 'No badges selected';
                      }
                      if (errorMsg.isNotEmpty) {
                        showSnackbar(
                            context, errorMsg, CupertinoColors.systemRed);
                        // showErrorSnackBar(context, errorMsg);
                        return;
                      }

                      String host = FirebaseAuth.instance.currentUser!.uid;

                      final data = RecruitmentPost(
                          host: host,
                          title: recruitProvider.titleController.text.trim(),
                          description:
                              recruitProvider.descriptionController.text.trim(),
                          category: selectedCategory,
                          maximumMembers:
                              int.parse(recruitProvider.membersController.text),
                          duration: selectedDateTimeRange!,
                          location: Location(
                              address: selectedLocation!.address,
                              latitude: selectedLocation!.latitude,
                              longitude: selectedLocation!.longitude),
                          badges: selectedBadges);

                      context
                          .read<RecruitBloc>()
                          .add(CreateRecruitmentEvent(data: data));

                      showSuccessSnackBar(
                          context, 'Your post was sent for approval');
                      recruitProvider.descriptionController.clear();
                      recruitProvider.titleController.clear();
                      recruitProvider.membersController.clear();
                      selectedCategory = '';
                      selectedDateTimeRange = null;
                      selectedLocation = null;
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card sentForApprovalWidget() {
    return const Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.check_mark, color: CupertinoColors.systemGreen),
            SizedBox(
              width: 10,
            ),
            Text('Sent for Approval  ',
                style: TextStyle(
                    color: CupertinoColors.systemGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
