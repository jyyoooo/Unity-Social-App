part of 'chat_bloc.dart';

abstract class ChatEvent {}

class FetchMessages extends ChatEvent {
  final String roomId;
  FetchMessages(this.roomId);
}
