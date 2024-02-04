import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/components/widgets/snackBar.dart';
import 'package:gym/utils/helpers/api/api_helper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';


class ChatProvider extends ChangeNotifier {

  bool isDeviceConnected = false;

  bool _isLoadingMessages = false;

  bool get isLoadingMessages => _isLoadingMessages;

  set isLoadingMessages(bool value) {
    _isLoadingMessages = value;
    notifyListeners();
  }

  bool _isLoadingChats = false;

  bool get isLoadingChats => _isLoadingChats;

  set isLoadingChats(bool value) {
    _isLoadingChats = value;
    notifyListeners();
  }

  List<ChatMessage> _messageList = [];

  List<ChatMessage> get messageList => _messageList;

  set messageList(List<ChatMessage> value) {
    _messageList = value;
    notifyListeners();
  }

  List<ChatModel> _chatList = [];

  List<ChatModel> get chatList => _chatList;

  set chatList(List<ChatModel> value) {
    _chatList = value;
    notifyListeners();
  }


  bool _isLoadingSendMsg = false;

  bool get isLoadingSendMsg => _isLoadingSendMsg;

  set isLoadingSendMsg(bool value) {
    _isLoadingSendMsg = value;
    notifyListeners();
  }

  bool _isLoadingDeleteMsg = false;

  bool get isLoadingDeleteMsg => _isLoadingDeleteMsg;

  set isLoadingDeleteMsg(bool value) {
    _isLoadingDeleteMsg = value;
    notifyListeners();
  }

  Future<void> callGetChatMessages(BuildContext context, int userId) async {
    isLoadingMessages = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().getChatMessagesApi(userId);
        isLoadingMessages = false;
        results.fold((l) {
          isLoadingMessages = false;
           showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data;
            log("data $data");
            List<dynamic> list = data;
            // messageList = list.map((e) => ChatMessage.fromJson(e)).toList();
            messageList = list.map((e) => ChatMessage.fromJson(e)).toList().reversed.toList();
            isLoadingMessages = false;
          } else {
            isLoadingMessages = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get chat : $e");
         showMessage("$e", false);
        isLoadingMessages = false;
      }
    } else {
       showMessage("no_internet_connection", false);
      isLoadingMessages = false;
    }
    notifyListeners();
  }


  Future<void> callGetAllChats(BuildContext context, ) async {
    isLoadingChats = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().getChatsApi();
        isLoadingChats = false;
        results.fold((l) {
          isLoadingChats = false;
           showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            // var data = response.data["data"];
            var data = response.data;
            log("data $data");
            List<dynamic> list = data;
            chatList = list.map((e) => ChatModel.fromJson(e)).toList();
            isLoadingChats = false;
          } else {
            isLoadingChats = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get chat : $e");
         showMessage("$e", false);
        isLoadingChats = false;
      }
    } else {
       showMessage("no_internet_connection", false);
      isLoadingChats = false;
    }
    notifyListeners();
  }

  Future<bool> callSendMessage(
      BuildContext context,
      int receiverId,
      String content,
      ) async {
    isLoadingSendMsg = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().sendMessageApi(
          receiverId,
          content,
        );
        isLoadingSendMsg = false;
        await results.fold((l) {
          isLoadingSendMsg = false;
           showMessage(l, false);
          repoStatus = false;
        }, (r) async {
          Response response = r;
          if (response.statusCode == 201) {
            var data = response.data;
            log("## $data");
            isLoadingSendMsg = false;
            repoStatus = true;
          } else {
            isLoadingSendMsg = false;
            log("## ${response.statusCode}");
            log("## ${response.data}");
          }
        });
        return repoStatus;
      } on Exception catch (e) {
         showMessage("$e", false);
        isLoadingSendMsg = false;
        return false;
      }
    } else {
       showMessage("no internet", false);
      isLoadingSendMsg = false;
      return false;
    }
  }

  Future<bool> callDeleteMessage(
      BuildContext context,
      int messageID,
      ) async {
    isLoadingDeleteMsg = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        Either<String, Response> results =
        await ApiHelper().deleteMessageApi(messageID);
        isLoadingDeleteMsg = false;
        results.fold((l) {
          isLoadingDeleteMsg = false;
           showMessage(l, false);
          repoStatus = false;
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("data $data");
            repoStatus = true;
             showMessage("delete_success", true);
            isLoadingDeleteMsg = false;
            repoStatus = true;
          } else {
            isLoadingDeleteMsg = false;
            log("## ${response.data}");
            repoStatus = false;
          }
        });
        return repoStatus;
      } on Exception catch (e) {
        log("Exception delete message: $e");
         showMessage("$e", false);
        isLoadingDeleteMsg = false;
        return false;
      }
    } else {
       showMessage("no_internet_connection", false);
      isLoadingDeleteMsg = false;
      return false;
    }
  }

}
