import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MessageBubble extends StatelessWidget {
  @override
  MessageBubble(this.message, this.username, this.userimage, this.isMe,
      {this.key});
  final Key key;
  final String message;
  final String username;
  final String userimage;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Row(
          mainAxisAlignment:
              !isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color:
                      !isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                    bottomLeft: isMe ? Radius.circular(0) : Radius.circular(14),
                    bottomRight:
                        !isMe ? Radius.circular(0) : Radius.circular(14),
                  )),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    !isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  new Padding(padding: EdgeInsets.only(top: 14)),
                  Text(message,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: !isMe
                              ? Colors.black
                              : Theme.of(context)
                                  .accentTextTheme
                                  .headline6
                                  .color),
                      textAlign: !isMe ? TextAlign.end : TextAlign.start)
                ],
              ),
            )
          ],
        ),
        Positioned(
            top: 0,
            left: isMe ? 120 : null,
            right: !isMe ? 120 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userimage),
            )),
        Positioned(
          top: 16,
          left: isMe ? 77 : null,
          right: !isMe ? 77 : null,
          child: Center(child: Text(
            username,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: !isMe
                    ? Colors.black
                    : Theme.of(context).accentTextTheme.headline6.color),
          ),)
        )
      ],
    );
  }
}
