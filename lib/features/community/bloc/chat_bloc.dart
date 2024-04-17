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

  ChatBloc() : super(ChatInitial()) {
    on<FetchMessages>((event, emit) async {
      log('on fetch msg bloc');
      emit(ChatLoading());
      try {
        chatRepo.fetchMessages(event.roomId).listen((messagesList) {
          _messageController.add(messagesList);
        });
        await for (final messages in messageStream) {
          emit(ChatLoaded(messages));
          // log(messages.toString());
        }
      } catch (e) {
        emit(ChatError('Failed to fetch messages: $e'));
      } finally {
        _messageController.close();
      }
    });
  }
}
