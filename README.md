# 🧠 CholAi SDK for Flutter

A plug-and-play SDK for real-time chat and AI integration, built for fast onboarding into your Flutter app.

---

## 🚀 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  cholai_sdk: ^<latest_version>
Then run:

flutter pub get
⚙️ Initialization

Before using any chat features, initialize the SDK:

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CholAiSdk.preInit(); // Optional: For preparing resources
  runApp(const MyApp());
}

Then call CholAiSdk.initialize once inside your app:

```dart
@override
void initState() {
  super.initState();
  CholAiSdk.initialize(
    userId: 'your-user-id',
    fcmToken: 'your-device-fcm-token',
    baseUrl: 'https://your-server.com', // Replace with your backend URL
  );
}

💬 Open Chat View

Use this to launch the chat detail view between two users:

```dart
showModalBottomSheet(
  context: context,
  builder: (context) => CholAiSdk.getChatDetailView(
    senderIdParam: 'sender-id',
    senderNameParam: 'Sender Name',
    senderProfileImageParam: '',

    receiverIdParam: 'receiver-id',
    receiverNameParam: 'Receiver Name',
    receiverProfileImageParam: '',
    receiverPhoneNumberParam: '1234567890',
    receiverCountryCodeParam: '+91',
  ),
);

📱 Example

Here is a minimal working app using the SDK:

```dart
import 'package:flutter/material.dart';
import 'package:cholai_sdk/cholai_sdk.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CholAiSdk.preInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CholAi SDK Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    CholAiSdk.initialize(
      userId: '685ed9d4ba12bfdac897d686',
      fcmToken: 'fcmToken',
      baseUrl: 'https://cholai-node.onrender.com',
    );
  }

  void _openChat() {
    showModalBottomSheet(
      context: context,
      builder: (context) => CholAiSdk.getChatDetailView(
        senderIdParam: '685ed9d4ba12bfdac897d686',
        senderNameParam: 'Sabari',
        senderProfileImageParam: '',
        receiverIdParam: '685eddd4ba12bfdac897d687',
        receiverNameParam: 'Dhina',
        receiverProfileImageParam: '',
        receiverPhoneNumberParam: '9842776133',
        receiverCountryCodeParam: '+91',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CholAi Chat Example')),
      body: const Center(child: Text('Tap the button to start a chat')),
      floatingActionButton: FloatingActionButton(
        onPressed: _openChat,
        child: const Icon(Icons.chat),
        tooltip: 'Start Chat',
      ),
    );
  }
}

📦 Features

🔒 Secure chat communication
👤 User-to-user conversation view
🔔 FCM token integration
🎨 Fully customizable UI wrapper (upcoming)
📣 Coming Soon

Message history with pagination
AI reply suggestions
In-app voice calling support
🧑‍💻 Maintained By

CholAi Team – Bringing AI-driven messaging into your app experience.