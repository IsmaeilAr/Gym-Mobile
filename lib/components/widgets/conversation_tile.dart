import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/chat/models/chat_model.dart';
import '../../features/chat/screens/chat_screen.dart';
import '../styles/colors.dart';


class ConversationTile extends StatefulWidget{
  ChatModel chatModel;
  ConversationTile(this.chatModel, {super.key,});
  @override
  State<ConversationTile> createState() => _ConversationTileState();
}

class _ConversationTileState extends State<ConversationTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        // backgroundImage: NetworkImage(widget.chatUser.imageUrl),
        maxRadius: 24.r,
      ),
      title: Text(widget.chatModel.sid2.name, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: lightGrey),),
      subtitle: Text(widget.chatModel.latestMessage.content, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.sp,color: grey, fontWeight:FontWeight.w400),),
      trailing: SizedBox(
        width: 60.w,
        child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Text(
              widget.chatModel.latestMessage.createdAt,
              style: TextStyle(
                  fontSize: 10.sp, color: grey, fontWeight: FontWeight.w400),
            )),
      ),
      onTap: (){
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: ChatScreen(
                    widget.chatModel
                )
            ));
      },
    );
  }
}