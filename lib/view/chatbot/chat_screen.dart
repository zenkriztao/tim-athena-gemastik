import 'package:autism_perdiction_app/theme.dart';
import 'package:autism_perdiction_app/widgets/widgets/chat_item.dart';
import 'package:autism_perdiction_app/widgets/widgets/my_app_bar.dart';
import 'package:autism_perdiction_app/widgets/widgets/text_and_voice_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/chats_provider.dart';


class ChatScreenBot extends StatelessWidget {
  const ChatScreenBot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        body: Column(
          children: [
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                final chats = ref.watch(chatsProvider).reversed.toList();
                return ListView.builder(
                  reverse: true,
                  itemCount: chats.length,
                  itemBuilder: (context, index) => ChatItem(
                    text: chats[index].message,
                    isMe: chats[index].isMe,
                  ),
                );
              }),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: TextAndVoiceField(),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
