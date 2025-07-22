
# 🧠 CholAi SDK for Flutter

A plug-and-play SDK for **real-time chat** and **AI integration**, built for fast onboarding into your Flutter app.

---

## 🚀 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  cholai_sdk: ^0.0.2  # Replace with the latest version
```

Then run:

```bash
flutter pub get
```

---

## ⚙️ Initialization

### Step 1: Pre-initialize the SDK in `main()`

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CholAiSdk.preInit(); // Optional: Prepares resources early
  runApp(const MyApp());
}
```

### Step 2: Initialize SDK after login or user session is ready

```dart
@override
void initState() {
  super.initState();
  CholAiSdk.initialize(
    userId: 'your-user-id',
    fcmToken: 'your-device-fcm-token',
    baseUrl: 'https://your-server.com', // Replace with your backend base URL
  );
}
```

---

## 💬 Show Chat View

Use the following snippet to launch a full-screen chat view between two users:

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
```

---

## 📱 Example App

Here’s a full working example to copy and run:

```dart
import 'package:flutter/material.dart';
import 'package:cholai_sdk/cholai_sdk.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CholAiSdk.preInit(); // Optional: Pre-initialize SDK
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
```

---

## 📦 Features

- 🔒 Secure real-time chat  
- 👥 One-to-one chat detail view  
- 🔔 Firebase FCM token support  
- 📦 Easy to plug into any app  
- 🎨 Theming and customization *(coming soon)*  
