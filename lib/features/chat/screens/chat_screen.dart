import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/net_image.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:gym/components/widgets/loading_indicator.dart';
import 'package:gym/components/widgets/message_bubble.dart';
import 'package:gym/features/coaches/provider/coach_provider.dart';
import 'package:gym/features/profile/models/user_model.dart';
import 'package:gym/features/profile/screens/coach_profile.dart';
import 'package:gym/utils/extensions/time_formatter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';
import '../provider/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  final ChatModel chatModel;

  const ChatScreen(this.chatModel, {super.key});

  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatProvider>().callGetChatMessages(context, widget.chatModel.sid2.id);
      context.read<CoachProvider>().getCoachInfo(context, widget.chatModel.sid2.id);
    });
    super.initState();
  }

  final TextEditingController _textController = TextEditingController();
  final scrollController = ScrollController();

  Future<void> _handleSubmitted(String text) async {
    _textController.clear();
    ChatMessage message = ChatMessage(
      content: text,
      isSender: true,
      createdAt: DateTime.now().toString(),
      id: 0,
      senderId: 0,
      receiverId: widget.chatModel.sid2.id,
    );
    context.read<ChatProvider>().messageList.insert(0, message);
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
   context.read<ChatProvider>().callSendMessage(context, widget.chatModel.sid2.id, text);
  }

  @override
  Widget build(BuildContext context) {
    List messages = context.read<ChatProvider>().messageList;
    UserModel coach = context.read<CoachProvider>().coachInfo;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: lightGrey,
              size: 24.r,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                // navigate to profile
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: CoachProfileScreen(coach)));
              },
              child: CircleAvatar(
                radius: 18.r,
                backgroundImage: assetImage(coach),
              ),
            ),
            const Gap(
              w: 10,
            ),
            Text(
              widget.chatModel.sid2.name,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  color: lightGrey),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: (){
            context.read<ChatProvider>().callGetChatMessages(context, widget.chatModel.sid2.id);

          }, icon: Icon(Icons.refresh_outlined, size: 16.r, color: lightGrey,))
        ],
      ),
      body:
      Column(
        children: [
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.topCenter,
              child: context.watch<ChatProvider>().isLoadingMessages
                  ? const LoadingIndicatorWidget()
                  : ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        ChatMessage message = messages[index];
                        return MessageBubble(
                    message: message.content,
                    isSender: message.isSender,
                    time: message.createdAt.formatTimestamp(),
                  );
                },
              ),
            ),
          ),
          TextComposerWidget(
            textController: _textController,
            handleSubmitted: _handleSubmitted,
          ),
        ],
      ),
    );
  }
}

class TextComposerWidget extends StatelessWidget {

  final TextEditingController textController;
  final Function(String) handleSubmitted;

  const TextComposerWidget({
    super.key,
    required this.textController,
    required this.handleSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      width: 332.w,
      height: 42.h,
      padding: EdgeInsets.only(left: 12.w),
      decoration: BoxDecoration(
        color: lightGrey,
        borderRadius: BorderRadius.circular(21.r),
      ),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: textController,
              onSubmitted: handleSubmitted,
              cursorColor: red,
              decoration: InputDecoration.collapsed(
                hintText: 'Message',
                hintStyle: TextStyle(
                  color: grey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          context.watch<ChatProvider>().isLoadingSendMsg ?
          IconButton(
            icon: Icon(Icons.send, color: grey, size: 18.w),
            onPressed: () {
            },
          ) :
          IconButton(
            icon: Icon(Icons.send, color: red, size: 20.w),
            onPressed: () => handleSubmitted(textController.text),
          ),
        ],
      ),
    );
  }
}
