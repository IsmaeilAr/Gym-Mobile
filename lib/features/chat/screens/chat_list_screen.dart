import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/back_button.dart';
import 'package:gym/components/widgets/conversation_tile.dart';
import 'package:gym/components/widgets/icon_button.dart';
import 'package:gym/components/widgets/loading_indicator.dart';
import 'package:gym/features/chat/models/chat_model.dart';
import 'package:gym/features/chat/provider/chat_provider.dart';
import 'package:gym/features/chat/screens/select_person_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../components/styles/gym_icons.dart';
import '../../../components/widgets/search_bar.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      _refresh();
      searching = false;
      customIcon = const Icon(
        Icons.search,
        color: lightGrey,
      );
    });
    super.initState();
  }

  Future<void> _refresh() async {
    context.read<ChatProvider>().callGetAllChats(context);
  }

  late bool searching = false;
  late Icon customIcon = const Icon(
    Icons.search,
    color: lightGrey,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        leading: const MyBackButton(),
        title: searching
            ? ActiveSearchBar(
                hint: AppLocalizations.of(context)!.searchChats,
                runFilter: (value) {
                  runFilter(value);
                },
              )
            : InactiveSearchBar(
                title: AppLocalizations.of(context)!.chats,
              ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                !searching
                    ? customIcon = Icon(
                        Icons.cancel,
                        color: lightGrey,
                        size: 18.sp,
                      )
                    : customIcon = const Icon(
                        GymIcons.search,
                        // Icons.search,
                        color: lightGrey,
                      );
                searching = !searching;
              });
            },
            icon: customIcon,
          )
        ],
      ),
      body:

      RefreshIndicator(
        color: red,
        backgroundColor: dark,
        onRefresh: _refresh,
        child:
        context.watch<ChatProvider>().isLoadingChats ?
        const LoadingIndicatorWidget() :
        ListView.builder(
                itemCount: context.watch<ChatProvider>().foundChatList.length,
                shrinkWrap: true,
                itemBuilder: (context, index){
                  ChatModel chatUser =
                      context.watch<ChatProvider>().foundChatList[index];
                  return ConversationTile(chatUser
            );
          },
        ),
      ),
      floatingActionButton: CircleAvatar(
        radius: 28.r,
      backgroundColor: red,
        child: InkWell(
          onTap: (){
            Navigator.push(
                context,
                PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: const SelectPersonScreen()
                ));
          },
            child: Icon(Icons.add, color: lightGrey, size: 18.sp,)
        ),
      ),
    );
  }

  void runFilter(String input) {
    List<ChatModel> results;
    if (input.isEmpty) {
      results = context.read<ChatProvider>().chatList;
    } else {
      results = context
          .read<ChatProvider>()
          .chatList
          .where((element) =>
              element.sid2.name.toLowerCase().contains(input.toLowerCase()))
          .toList();
    }
    context.read<ChatProvider>().foundChatList = results;
  }
}
