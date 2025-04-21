import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final String chatId;
  final String currentUserId;

  ChatCubit({required this.chatId, required this.currentUserId})
      : super(ChatInitial());

  void loadMessages() {
    emit(ChatLoading());
    FirebaseFirestore.instance
        .collection('Chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      final messages = snapshot.docs.map((doc) => doc.data()).toList();
      emit(ChatLoaded(messages: messages));
    }, onError: (error) {
      emit(ChatError(error.toString()));
    });
  }
}
