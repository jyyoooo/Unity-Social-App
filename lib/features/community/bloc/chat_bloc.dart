import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:unitysocial/features/community/data/models/message_model.dart';
import 'package:unitysocial/features/community/data/repository/chat_repo.dart';

part 'chat_events.dart';
part 'chat_states.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final _messageController = StreamController<List<Message>>.broadcast();
  Stream<List<Message>> get messageStream => _messageController.stream;
  final chatRepo = ChatRepo();
  List<Message> allMessages = [];
  int? lastFetchedAt;

  ChatBloc() : super(ChatInitial()) {
    on<FetchMessages>(_fetchMessagesStream);
    on<FetchMoreMessages>(_fetchMoreMessages);
    on<MessagesReceivedEvent>(_messagesReceivedEvent);
  }

  FutureOr<void> _fetchMessagesStream(
      FetchMessages event, Emitter<ChatState> emit) async {
    log('fethching stream');
    emit(ChatLoading());
    try {
      chatRepo.streamNewMessages(event.roomId).listen(
            (messages) => add(MessagesReceivedEvent(messages)),
          );
    } catch (e) {
      log("FETCH STREAM ERROR: $e");
      emit(ChatError('Failed to get stream'));
    }
  }

  FutureOr<void> _messagesReceivedEvent(
      MessagesReceivedEvent event, Emitter<ChatState> emit) {
    emit(ChatLoaded(event.messages));
  }

  FutureOr<void> _fetchMoreMessages(
      FetchMoreMessages event, Emitter<ChatState> emit) async {
    try {
      final messages = await chatRepo.fetchPreviousMessages(
          event.roomId, event.previousDocId);
      if (messages.isEmpty) {
        emit(ChatError('Something went wrong'));
      } else {
        emit(ChatLoaded(messages, isPrevious: true));
      }
    } catch (e) {
      log("FETCH MORE ERROR: $e");
      emit(ChatError('Failed to load chat'));
    }
  }
}
 