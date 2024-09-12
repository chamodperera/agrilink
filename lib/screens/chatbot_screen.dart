import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class ChatbotScreen extends StatefulWidget {
  final String initialMessage;
  final File? capturedImage; // Optional image from mobile
  final Uint8List? webImage; // Optional image from web

  const ChatbotScreen({
    Key? key,
    required this.initialMessage,
    this.capturedImage,
    this.webImage,
  }) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  TextEditingController _userMessage = TextEditingController();

  static const apiKey = "AIzaSyBRc-tNaAPK1jFEOZKre03mOxogtSa5il8";
  final GenerativeModel model = GenerativeModel(
    apiKey: apiKey,
    model: 'gemini-1.5-flash',
  );

  final List<Message> _messages = [];
  final String prompt =
      'You are an agriculture expert. Your task is to help farmers with their queries. For example, you can help them with crop management, pest control, and soil health. You should also resposnd to images of plants or pests.  If the user asks something that does not fall under the agriculture domain, you can say "I am an agriculture expert, I can only help you with agriculture-related queries."';

  @override
  void initState() {
    super.initState();
    _userMessage = TextEditingController(text: widget.initialMessage);

    setState(() {
      _messages.add(Message(
        isUser: false,
        message: prompt,
        date: DateTime.now(),
      ));
    });

    if (widget.initialMessage.isNotEmpty) {
      sendMessage();
    }
  }

  Future<void> sendMessage() async {
    final message = _userMessage.text;
    _userMessage.clear();

    setState(() {
      _messages.add(Message(
        isUser: true,
        message: message,
        date: DateTime.now(),
      ));
    });

    // If an image is provided, process it first
    if (widget.capturedImage != null || widget.webImage != null) {
      List<DataPart> imageDataParts = [];

      // Handle captured image from mobile
      if (widget.capturedImage != null) {
        final bytes = await widget.capturedImage!.readAsBytes();
        imageDataParts.add(DataPart('image/jpeg', bytes));
      }

      // Handle image from web (Uint8List)
      if (widget.webImage != null) {
        imageDataParts.add(DataPart('image/jpeg', widget.webImage!));
      }

      // Create multi-part content with text and image data
      final content = [
        Content.text(_messages[0].message),
        Content.text(_messages[1].message),
        Content.multi(
          imageDataParts,
        ),
        ..._messages
            .sublist(2)
            .map((message) => Content.text(message.message))
            .toList(),
      ];

      final response = await model.generateContent(content);

      setState(() {
        _messages.add(Message(
          isUser: false,
          message: response.text ?? 'No response',
          date: DateTime.now(),
        ));
      });
    } else {
      // If no image, just process the message as usual
      final content =
          _messages.map((message) => Content.text(message.message)).toList();
      final response = await model.generateContent(content);

      setState(() {
        _messages.add(Message(
          isUser: false,
          message: response.text ?? 'No response',
          date: DateTime.now(),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('AgriChat', style: theme.textTheme.titleMedium),
        backgroundColor: theme.colorScheme.background,
        leading: const BackButtonWidget(),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.capturedImage != null || widget.webImage != null) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.capturedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(widget.capturedImage!, height: 150),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.memory(widget.webImage!, height: 150),
                    ),
            ),
          ],
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length - 1,
              itemBuilder: (context, index) {
                final message = _messages[index + 1];
                return Messages(
                  isUser: message.isUser,
                  message: message.message,
                  date: DateFormat('HH:mm').format(message.date),
                );
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 30, left: 10, right: 10, top: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 15,
                  child: TextFormField(
                    controller: _userMessage,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      label: const Text('  Type your message here'),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                IconButton(
                  padding: const EdgeInsets.all(15),
                  iconSize: 25,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(theme.colorScheme.primary),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    sendMessage();
                  },
                  icon: Icon(FluentIcons.send_24_regular),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  const Messages(
      {super.key,
      required this.isUser,
      required this.message,
      required this.date});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      children: [
        Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.9,
              minWidth: MediaQuery.of(context).size.width * 0.25,
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMessageText(message, isUser),
                  if (isUser) SizedBox(height: 10),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 10,
                      color: isUser ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: isUser
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onPrimary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                  bottomLeft: isUser ? const Radius.circular(10) : Radius.zero,
                  bottomRight: isUser ? Radius.zero : const Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildMessageText(String text, bool isUser) {
  if (!isUser) {
    final parts = text.split('**');
    return RichText(
      text: TextSpan(
        children: parts.map((part) {
          final isBold = part.startsWith('**') && part.endsWith('**');
          return TextSpan(
            text: isBold ? part.substring(2, part.length - 2) : part,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
              color: Colors.white,
            ),
          );
        }).toList(),
      ),
    );
  } else {
    return Text(text, style: TextStyle(fontSize: 14, color: Colors.black));
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({
    required this.isUser,
    required this.message,
    required this.date,
  });
}
