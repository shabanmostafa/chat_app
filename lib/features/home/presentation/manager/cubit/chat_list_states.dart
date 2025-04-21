import 'package:cloud_firestore/cloud_firestore.dart';

class ChatListState {
  const ChatListState();
}

class ChatListLoading extends ChatListState {}

class ChatListSuccess extends ChatListState {
  final List<QueryDocumentSnapshot> chatDocs;
  final Map<String, Map<String, dynamic>> userData;

  ChatListSuccess({required this.chatDocs, required this.userData});
}

class ChatListFailure extends ChatListState {
  final String error;

  ChatListFailure(this.error);
}
