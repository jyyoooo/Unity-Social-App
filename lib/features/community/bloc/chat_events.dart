part of 'chat_bloc.dart';

abstract class ChatEvent {}

class FetchMessages extends ChatEvent {
  final String roomId;
  FetchMessages(this.roomId);
}

class FetchMoreMessages extends ChatEvent {
  final String roomId;
  final String previousDocId;
  FetchMoreMessages(this.roomId, this.previousDocId);
}

class MessagesReceivedEvent extends ChatEvent {
  final List<Message> messages;
  MessagesReceivedEvent(this.messages);
}
