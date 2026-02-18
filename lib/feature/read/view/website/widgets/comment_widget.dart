import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/utils/time_ago.dart';
import 'package:kujitoon/feature/read/bloc/comment_bloc.dart';
import 'package:kujitoon/feature/read/bloc/comment_event.dart';
import 'package:kujitoon/feature/read/bloc/comment_state.dart';
import 'package:kujitoon/feature/read/view/website/widgets/comment_chat_widget.dart';
import 'package:kujitoon/feature/read/view/website/widgets/comment_item.dart';

class CommentWidget extends StatefulWidget{
  final String slug;
  final int chapter;
  const CommentWidget({super.key, required this.slug, required this.chapter});

  @override
  State<StatefulWidget> createState() => _CommentWidget();
}

class _CommentWidget extends State<CommentWidget>{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentBloc, CommentState>(
        builder: (context, state){
          if(state is LoadedCommentState){
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10
                  )
                ]
              ),
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${state.listComments.length} Bình Luận", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                    CommentChatWidget(sendComment: (String comment){
			context.read<CommentBloc>().add(SendCommentEvent(
			  widget.slug, 
			  widget.chapter, 
			  comment, 
			  state,
			));
		    }),
                    for(var comment in state.listComments)...[
                      CommentItem(
                        username: comment.userName,
                        isAdmin: comment.isAdmin,
                        timeAgo: TimeAgo.time(comment.dateTime),
                        content: comment.comment,
                        chapter: comment.chapter,
                      ),
                      SizedBox(height: 5,),
                    ]
                  ],
                ),
              ),
            );
          }else{
            return Container();
          }
        },
        listener: (context, state){}
    );
  }

}
