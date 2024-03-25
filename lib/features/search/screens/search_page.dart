import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/enums/search_filters.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';
import 'package:unitysocial/features/home/screens/widgets/cause_info_card.dart';
import 'package:unitysocial/features/search/bloc/search_bloc.dart';
import 'package:unitysocial/features/search/screens/widgets/filter_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode searchFocusNode = FocusNode();
  String selectedCategory = 'Category';
  String selectedDateFilter = 'Date range';

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => searchFocusNode.requestFocus()); // Request focus on next frame
  }

  @override
  void dispose() {
    searchFocusNode
        .dispose(); // Dispose the FocusNode when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        searchFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: UnityAppBar(
            title: 'Search',
            showBackBtn: true,
            search: true,
            focusNode: searchFocusNode,
            onChanged: (query) {
              context.read<SearchBloc>().add(SearchQuery(query: query));
            },
          ),
        ),
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: .1))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 3),
                child: Row(
                  children: [
                    FilterButton(
                      selectedFilter: selectedCategory,
                      filters: [
                        _buildCategoryMenuItem('Animals'),
                        _buildCategoryMenuItem('Humanitarian'),
                        _buildCategoryMenuItem('Water'),
                        _buildCategoryMenuItem('Environment'),
                      ],
                    ),
                    const SizedBox(width: 5),
                    FilterButton(
                        constraints: const Size(150, 120),
                        selectedFilter: selectedDateFilter,
                        filters: [
                          _buildDateFilterMenuItem('1 Day'),
                          _buildDateFilterMenuItem('less than a Week'),
                          _buildDateFilterMenuItem('more than a Week'),
                        ])
                  ],
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is LoadingSearch) {
                    return const CircularProgressIndicator(strokeWidth: 1.5);
                  } else if (state is SuccessSearch) {
                    return state.queryResults.isEmpty
                        ? const Center(child: Text('No Results'))
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.queryResults.length,
                            itemBuilder: (context, index) => CauseInfoCard(
                              post: state.queryResults[index],
                            ),
                          );
                  }
                  return const Center(
                    child: Text('Try searching for a cause'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildDateFilterMenuItem(String title) {
    return PopupMenuItem(
      height: 35,
      child: Text(title),
      onTap: () {
        DurationFilter durationFilter = DurationFilter.moreThanWeek;
        if (title == '1 Day') {
          durationFilter = DurationFilter.oneDay;
        } else if (title == 'less than a Week') {
          durationFilter = DurationFilter.lessThanWeek;
        } else if (title == 'more than a Week') {
          durationFilter = DurationFilter.moreThanWeek;
        }

        context
            .read<SearchBloc>()
            .add(FilterByDuration(duration: durationFilter));
      },
    );
  }

  _buildCategoryMenuItem(String title) {
    return PopupMenuItem(
      height: 35,
      child: Text(title),
      onTap: () {
        setState(() {
          selectedCategory = title;
        });
        context
            .read<SearchBloc>()
            .add(FilterByCategory(category: selectedCategory));
      },
    );
  }
}
