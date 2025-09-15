import 'dart:io';
import 'package:continue_parkingapp_flutter/blocs/parking_bloc.dart' as parkingBloc;

import 'package:continue_parkingapp_flutter/blocs/parkingspace_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:continue_parkingapp_flutter/blocs/auth_bloc.dart';
import 'package:continue_parkingapp_flutter/blocs/vehicle_bloc.dart';
import 'package:continue_parkingapp_flutter/repositories/ParkingSpace_Repository.dart';
import 'package:continue_parkingapp_flutter/repositories/Vehicle_Repository.dart';
import 'package:continue_parkingapp_flutter/views/parking_view.dart';
import 'package:continue_parkingapp_flutter/views/vehicle_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'blocs/parkingspace_bloc.dart';
import 'firebase_options.dart';
import 'repositories/Parking_Repository.dart';

Future<void> _configureLocalTimeZone() async {
if (kIsWeb || Platform.isLinux) {
return;
}
tz.initializeTimeZones();
if (Platform.isWindows) {
return;
}
try {
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  } catch (e) {
    tz.setLocalLocation(tz.getLocation('Europe/Stockholm')); // or your default
  }
}

// ...
Future<FlutterLocalNotificationsPlugin> initializeNotifications() async {
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Change icon to '@mipmap/ic_launcher' which is default app icon
  var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');

  var initializationSettingsDarwin =
      const DarwinInitializationSettings(); // ios & macos

  var initializationSettingsLinux =
      const LinuxInitializationSettings(defaultActionName: 'Open notification');

  const WindowsInitializationSettings initializationSettingsWindows =
      WindowsInitializationSettings(
          appName: 'continue_parkingapp_flutter', // Your app name, sync msix installer in pubspec
          appUserModelId:
              'Com.Example.App', // app name, sync msix intaller in pubspec
          guid:
              '1c26bc72-e4e7-4098-b86f-3f6b97db8ff5'); // TODO: Generate your own: https://www.guidgenerator.com/ and sync in msix installer in pubspec

  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      windows: initializationSettingsWindows,
      linux: initializationSettingsLinux);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  return flutterLocalNotificationsPlugin;
}
late final FlutterLocalNotificationsPlugin notificationsPlugin;


// Observer for debugging state changes
class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}

Future<void> cleanupAllNotifications() async {
  try {
    // Cancel all notifications
    await notificationsPlugin.cancelAll();
    print('Cleaned up all notifications');
  } catch (e) {
    print('Error cleaning notifications: $e');
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase first
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize notifications
  notificationsPlugin = await initializeNotifications();
  await cleanupAllNotifications();
  await _configureLocalTimeZone();

  // Set bloc observer
  Bloc.observer = SimpleBlocObserver();

  // Run app with proper provider structure
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) =>
              parkingBloc.ParkingBloc(repository: ParkingRepository())..add(parkingBloc.LoadParking() as parkingBloc.ParkingEvent),
        ),
        BlocProvider(
          create: (context) =>
              VehicleBloc(repository: VehicleRepository())..add(LoadVehicle()),
        ),
        BlocProvider(
          create: (context) => ParkingSpaceBloc(
              repository: ParkingSpaceRepository())..add(LoadParkingSpace() as ParkingSpaceEvent),
        ),
      ],
      child: const MyApp(), // Remove duplicate child
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthBloc>().state;

    Widget homeWidget;

    if (state is AuthPending) {
      homeWidget = const Center(child: CircularProgressIndicator());
    } else if (state is AuthSuccess) {
      homeWidget = const LandingPage();
    } else if (state is AuthSignedIn || state is AuthInitial) {
      homeWidget = const SignedInView();
    } else if (state is AuthFailure) {
      homeWidget = Center(child: Text(state.error));
    } else {
      homeWidget = const Center(child: Text("Unknown State"));
    }

    return MaterialApp(
      title: 'Bloc Examples',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: homeWidget,
    );
  }
}

/* class SignedOutView extends StatelessWidget {
  const SignedOutView({super.key});


  
  } */


class SignedInView extends StatelessWidget {
  const SignedInView({super.key});

 
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthBloc>().add(AuthLogin(name: "Christian", email: 'test123@test.com', password: 'test123'));
          },
          child: const Text("Login"),
        ),
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;

  final List<Widget> _views = const [
    ParkingView(),
    VehicleView(),
    LogoutView(),
  ];

  final List<BottomNavigationBarItem> _bottomItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.local_parking),
      label: "Parking",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.car_rental),
      label: "Vehicle",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.logout),
      label: "Logout",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _views[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomItems,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class LogoutView extends StatelessWidget {
  const LogoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthBloc>().logout();
          },
          child: const Text("Logout"),
        ),
      ),
    );
  }
}
