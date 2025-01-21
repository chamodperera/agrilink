import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class ChatbotScreen extends StatefulWidget {
  final String location;
  final String district;
  final String initialMessage;
  final File? capturedImage; // Optional image from mobile
  final Uint8List? webImage; // Optional image from web

  const ChatbotScreen({
    Key? key,
    required this.initialMessage,
    required this.location,
    required this.district,
    this.capturedImage,
    this.webImage,
  }) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  TextEditingController _userMessage = TextEditingController();

  static const endpoint =
      "https://agrilink-backend-hna7grgwbjaccpbr.southeastasia-01.azurewebsites.net/assistant";

  final List<Message> _messages = [];
  bool _isLoadingResponse = false; // Flag to track loading state

  @override
  void initState() {
    super.initState();
    _userMessage = TextEditingController(text: widget.initialMessage);

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
      _isLoadingResponse = true;
    });

    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "user_input": message,
          "history": _messages
              .map((e) =>
                  e.isUser ? {"user": e.message} : {"assistant": e.message})
              .toList()
              .sublist(0, _messages.length - 1),
          "location": "Aluthgama",
          "district": "Anuradhapura"
        }),
      );

      final responseData = jsonDecode(response.body);
      final responseMessage = responseData['response'] ?? 'No response';

      setState(() {
        _messages.add(Message(
          isUser: false,
          message: responseMessage,
          date: DateTime.now(),
        ));
      });
    } catch (e) {
      setState(() {
        _messages.add(Message(
          isUser: false,
          message: 'Error fetching response. Please try again.',
          date: DateTime.now(),
        ));
      });
    } finally {
      setState(() {
        _isLoadingResponse = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('AgriSense Help', style: theme.textTheme.titleMedium),
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
              itemCount: _messages.length + (_isLoadingResponse ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isLoadingResponse) {
                  return const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final message = _messages[index];
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
                        MaterialStateProperty.all(theme.colorScheme.secondary),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    // sendMessage();
                  },
                  icon: Icon(FluentIcons.camera_24_regular),
                ),
                SizedBox(width: 10),
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
    return MarkdownBody(
      data: text,
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        p: TextStyle(fontSize: 14, color: Colors.white),
        strong: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        blockquote:
            TextStyle(fontStyle: FontStyle.italic, color: Colors.white70),
      ),
    );
  } else {
    return Text(
      text,
      style: TextStyle(fontSize: 14, color: Colors.black),
    );
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
