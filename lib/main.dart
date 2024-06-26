import 'package:dbo_app/services/BackgroundService.dart';
import 'package:dbo_app/services/BudoService.dart';
import 'package:dbo_app/services/PushNotificationService.dart';
import 'package:dbo_app/tabs/events.dart';
import 'package:dbo_app/tabs/news.dart';
import 'package:dbo_app/tabs/notif_panel.dart';
import 'package:dbo_app/tabs/settings.dart';
import 'package:dbo_app/tabs/worldboss.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import './options.dart' as firebase_opts;
import './global.dart' as globals;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "dbogg",
      options: FirebaseOptions(
          apiKey: firebase_opts.apiKey,
          appId: firebase_opts.appId,
          messagingSenderId: firebase_opts.messagingSenderId,
          projectId: firebase_opts.projectId));

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print("message from app");
  });

  PermissionStatus status = await Permission.notification.status;
  if (!status.isGranted) {
    //await Permission.notification.request();
    print("user has not granted notification permissions");
    runApp(const MyAppNotReady());
  }
  if (status.isGranted) {
    print("user has granted notification permissions");
    BackgroundService backs = BackgroundService();
    backs.refreshUser();
    runApp(const MyApp());
  }
}

class MyAppNotReady extends StatelessWidget{
  const MyAppNotReady({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DBO',
    theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Color(0xEEFEB521)), //yellow: Color(0xEEFEB521) blue: Color(0xEE0C3550)
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      home: Scaffold(
            appBar: AppBar(
                flexibleSpace: Image(
                  opacity: const AlwaysStoppedAnimation(.4),
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover,
                ),
                title: Row(children: [
                  Container(
                      color: Colors
                          .transparent, // To see the difference between the image's original size and the frame
                      height: 24,
                      width: 24,
                      // Uploading the Image from Assets
                      child: Image.asset(
                        "assets/images/icon1.png",
                        fit: BoxFit.cover,
                      )),
                  SizedBox(width: 10),
                  const Text(
                    'DBOG Event Notifier',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ]),
                backgroundColor: Colors.black),
                body:
                Center(
                  heightFactor: 12,
                  child: Column(children: [
                    SizedBox(height: 10),
                    const Text(
                    "Please allow the app to push notifications",
                    style: TextStyle(
                        color: Color.fromARGB(255, 42, 40, 40),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "In order to make this app notify you about events in the game, you have to allow it to push notifications.",
                    style: TextStyle(
                        color: Color.fromARGB(255, 42, 40, 40),
                        fontWeight: FontWeight.w100,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  MaterialButton(onPressed: () async{
                        await openAppSettings();
                  }, minWidth: 50, 
                  color: Color.fromARGB(237, 254, 121, 33),
                  child: Text("Enable in settings")),
                  ]),
                )
                )
    );
  }
}

class MyApp extends StatelessWidget with WidgetsBindingObserver {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DBO',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Color(0xEEFEB521)), //yellow: Color(0xEEFEB521) blue: Color(0xEE0C3550)
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'DBOG Event Notifier'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  BackgroundService backs = BackgroundService();

  bool openNotifPanel = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        print("Inactive");
        break;
      case AppLifecycleState.paused:
        print("Paused");
        break;
      case AppLifecycleState.resumed:
        print("Resumed");
        backs.refreshUser();
        break;
      case AppLifecycleState.detached:
        print("detached");
        break;
      case AppLifecycleState.hidden:
        print("hidden");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
                flexibleSpace: Image(
                  opacity: const AlwaysStoppedAnimation(.4),
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover,
                ),
                backgroundColor: Colors.black,
                //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                bottom: const TabBar(
                  tabs: [
                    Tab(
                        icon: Icon(
                      Icons.event_available,
                      color: Colors.white,
                    )),
                    Tab(
                        icon: Icon(
                      Icons.emoji_events,
                      color: Colors.white,
                    )),
                    Tab(
                        icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                    )),
                  ],
                ),
                title: Row(children: [
                  Container(
                      color: Colors
                          .transparent, // To see the difference between the image's original size and the frame
                      height: 24,
                      width: 24,

                      // Uploading the Image from Assets
                      child: Image.asset(
                        "assets/images/icon1.png",
                        fit: BoxFit.cover,
                      )),
                  SizedBox(width: 10),
                  const Text(
                    'DBOG Event Notifier',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ])),
            body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.1,
                    image: AssetImage(
                      'assets/images/back_app.jpg',
                    ), // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
                child: TabBarView(
                  children: [AllEvents(), Boss(), SettingsTab()],
                ))));
  }
}
