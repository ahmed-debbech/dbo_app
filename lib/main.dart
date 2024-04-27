import 'package:dbo_app/services/BackgroundService.dart';
import 'package:dbo_app/services/BudoService.dart';
import 'package:dbo_app/services/PushNotificationService.dart';
import 'package:dbo_app/tabs/budo.dart';
import 'package:dbo_app/tabs/news.dart';
import 'package:dbo_app/tabs/worldboss.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
  
  PermissionStatus status = await Permission.notification.status; 
  if(!status.isGranted){
    //await Permission.notification.request();
    await openAppSettings();
    print("user has not granted notification permissions");
  }
  if(status.isGranted){
    print("user has granted notification permissions");
  }
  BackgroundService backs = BackgroundService();
  backs.refreshUser();
  runApp(const MyApp());
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
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 12, 53, 80)),
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
  BudoService bs = BudoService();
  BackgroundService backs = BackgroundService();

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
        bs.getNext();
        bs.getList();
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
    return Banner(
        message: 'beta',
        location: BannerLocation.topEnd,
        color: Color.fromARGB(201, 255, 5, 5),
        child: DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  bottom: const TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.event_available)),
                      Tab(icon: Icon(Icons.emoji_events)),
                      Tab(icon: Icon(Icons.new_releases_rounded)),
                    ],
                  ),
                  title: const Text(
                    'DBOG Event Notifier',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                body: const TabBarView(
                  children: [Budokai(), Boss(), NewsTab()],
                ))));
  }
}
