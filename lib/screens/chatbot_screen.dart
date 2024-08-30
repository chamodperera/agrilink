import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';


class ChatbotScreen extends StatefulWidget {
  final String initialMessage;
  const ChatbotScreen({Key? key, required this.initialMessage}) : super(key: key);

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
    });
    
    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    setState(() {
      _messages.add(Message(
        isUser: false,
        message: response.text ?? 'No response',
        date: DateTime.now(),
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('AgriChat',style: theme.textTheme.titleMedium),
        backgroundColor: theme.colorScheme.background,
        leading: const BackButtonWidget(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
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
            padding: const EdgeInsets.only(bottom: 30, left: 10, right: 10, top: 10),
            child: Row(
              children: [
              Expanded(
                flex: 15,
                child: TextFormField(
                    controller: _userMessage,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                      label: const Text('  Type your message here'),
                    ),
                  ),
              ),
                SizedBox(width: 15),
                IconButton(
                  padding: const EdgeInsets.all(15),
                  iconSize: 25,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(theme.colorScheme.primary),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    //box with radius
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
    required this.date}
  );

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
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14,
                    color: isUser ? Colors.black : Colors.white,
                  ),
                ),
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