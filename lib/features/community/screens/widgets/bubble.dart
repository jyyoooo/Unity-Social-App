// library flutter_chat_bubble;

// import 'package:flutter/material.dart';

// import 'package:unitysocial/core/enums/chats.dart';
// import 'package:unitysocial/features/community/models/chat.dart';

// import 'formatter.dart';

// class Bubble extends StatelessWidget {
//   final EdgeInsetsGeometry? margin;
//   final Chat chat;

//   const Bubble({
//     super.key,
//     this.margin,
//     required this.chat,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: alignmentOnType,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (chat.type == ChatMessageType.received)
//           const CircleAvatar(
//             backgroundImage: AssetImage("assets/images/avatar_1.png"),
//           ),
//         const SizedBox(
//           width: 5,
//         ),
//         Container(
//           margin: margin ?? EdgeInsets.zero,
//           child: PhysicalShape(
//             clipper: ShapeBorderClipper(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12))),
//             elevation: 2,
//             color: bgColorOnType,
//             shadowColor: Colors.grey.shade200,
//             child: Container(
//               constraints: BoxConstraints(
//                 maxWidth: MediaQuery.of(context).size.width * 0.8,
//               ),
//               padding: paddingOnType,
//               child: Column(
//                 crossAxisAlignment: crossAlignmentOnType,
//                 children: [
//                   Text(
//                     chat.message,
//                     style: TextStyle(color: textColorOnType),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   Text(
//                     Formatter.formatDateTime(chat.time),
//                     style: TextStyle(color: textColorOnType, fontSize: 12),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Color get textColorOnType {
//     switch (chat.type) {
//       case ChatMessageType.sent:
//         return Colors.white;
//       case ChatMessageType.received:
//         return const Color(0xFF0F0F0F);
//     }
//   }

//   Color get bgColorOnType {
//     switch (chat.type) {
//       case ChatMessageType.received:
//         return const Color(0xFFE7E7ED);
//       case ChatMessageType.sent:
//         return const Color(0xFF007AFF);
//     }
//   }

//   CrossAxisAlignment get crossAlignmentOnType {
//     switch (chat.type) {
//       case ChatMessageType.sent:
//         return CrossAxisAlignment.end;
//       case ChatMessageType.received:
//         return CrossAxisAlignment.start;
//     }
//   }

//   MainAxisAlignment get alignmentOnType {
//     switch (chat.type) {
//       case ChatMessageType.received:
//         return MainAxisAlignment.start;

//       case ChatMessageType.sent:
//         return MainAxisAlignment.end;
//     }
//   }

//   EdgeInsets get paddingOnType {
//     switch (chat.type) {
//       case ChatMessageType.sent:
//         return const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 24);
//       case ChatMessageType.received:
//         return const EdgeInsets.only(
//           top: 10,
//           bottom: 10,
//           left: 24,
//           right: 10,
//         );
//     }
//   }
// }
