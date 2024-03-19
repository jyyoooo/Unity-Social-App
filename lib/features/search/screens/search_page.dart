import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';
import 'package:unitysocial/features/home/screens/widgets/cause_info_card.dart';
import 'package:unitysocial/features/search/bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => searchFocusNode.requestFocus()); // Request focus on next frame
  }

  @override
  void dispose() {
    searchFocusNode.dispose(); // Dispose the FocusNode when the widget is disposed
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
          preferredSize: const Size.fromHeight(130),
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
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is LoadingSearch) {
              return const CircularProgressIndicator(strokeWidth: 1.5);
            } else if (state is SuccessSearch) {
              return state.queryResults.isEmpty
                  ? const Center(child: Text('No Results'))
                  : ListView.builder(physics: const BouncingScrollPhysics(),
                      itemCount: state.queryResults.length,
                      itemBuilder: (context, index) =>
                          CauseInfoCard(post: state.queryResults[index]));
            }
            return const Center(
              child: Text('Try searching for a cause'),
            );
          },
        ),
      ),
    );
  }
}
