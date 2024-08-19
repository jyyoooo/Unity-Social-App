part of 'chat_bloc.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Message> messages;
  final bool isPrevious;
  ChatLoaded(this.messages, {this.isPrevious = false});
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
