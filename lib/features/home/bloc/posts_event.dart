part of 'posts_bloc.dart';

abstract class PostsEvent {}

class FetchAllPosts extends PostsEvent {
  final String category;
  FetchAllPosts({required this.category});
}
