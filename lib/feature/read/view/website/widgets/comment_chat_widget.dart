import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentChatWidget extends StatelessWidget{
  final void Function(String comment) sendComment;
  const CommentChatWidget({super.key, required this.sendComment});

  @override
  Widget build(BuildContext context) {
    TextEditingController commentControllerInput = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 18,
            child: Center(
              child: Text("D"),
            ),
          ),

          const SizedBox(width: 10),

          // Input
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
		controller: commentControllerInput,
                decoration: const InputDecoration(
                  hintText: 'Thêm bình luận của bạn...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Send button
          GestureDetector(
            onTap: (){
	     sendComment(commentControllerInput.text);
	    },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
