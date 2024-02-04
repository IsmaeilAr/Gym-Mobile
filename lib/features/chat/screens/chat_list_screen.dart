import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/conversation_tile.dart';
import 'package:gym/components/widgets/icon_button.dart';
import 'package:gym/components/widgets/loading_indicator.dart';
import 'package:gym/features/chat/models/chat_model.dart';
import 'package:gym/features/chat/provider/chat_provider.dart';
import 'package:gym/features/chat/screens/select_person_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';



class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<ChatProvider>().callGetAllChats(context);
    });
    super.initState();
  }

  Future<void> _refresh() async {
    context.read<ChatProvider>().callGetAllChats(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        leading: BarIconButton(onPressed: () { Navigator.pop(context); }, icon: Icons.arrow_back_ios_outlined,),
        title: const Text("Chats", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: lightGrey),),
        actions: [
          BarIconButton(onPressed: () {  }, icon: Icons.search,),
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
          itemCount: context.watch<ChatProvider>().chatList.length,
          shrinkWrap: true,
          itemBuilder: (context, index){
            ChatModel chatUser = context.watch<ChatProvider>().chatList[index];
            return ConversationTile(
                chatUser
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
                    type: PageTransitionType.fade,
                    child: const SelectPersonScreen()
                ));
          },
            child: Icon(Icons.add, color: lightGrey, size: 18.sp,)
        ),
      ),
    );
  }
}
