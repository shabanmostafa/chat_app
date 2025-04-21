import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete_chat_app_tharwat/features/home/manager/cubit/chat_list_states.dart';

class ChatListCubit extends Cubit<ChatListState> {
  final String currentUserId;
  final Map<String, Map<String, dynamic>> _userCache = {};

  ChatListCubit(this.currentUserId) : super(ChatListLoading());

  void fetchChats() async {
    emit(ChatListLoading());
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Chats')
          .where('participants', arrayContains: currentUserId)
          .get();

      final chatDocs = snapshot.docs;

      for (final chat in chatDocs) {
        final participants = chat['participants'] as List<dynamic>;
        final otherUserId =
            participants.firstWhere((id) => id != currentUserId);

        if (!_userCache.containsKey(otherUserId)) {
          final userSnap = await FirebaseFirestore.instance
              .collection('users')
              .doc(otherUserId)
              .get();

          if (userSnap.exists) {
            _userCache[otherUserId] = userSnap.data()!;
          }
        }
      }

      emit(ChatListSuccess(chatDocs: chatDocs, userData: _userCache));
    } catch (e) {
      emit(ChatListFailure(e.toString()));
    }
  }
}
