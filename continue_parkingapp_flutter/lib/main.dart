import 'package:continue_parkingapp_flutter/blocs/parking_bloc.dart' as parkingBloc;
import 'package:continue_parkingapp_flutter/blocs/parking_bloc.dart';
import 'package:continue_parkingapp_flutter/blocs/parkingspace_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:continue_parkingapp_flutter/blocs/auth_bloc.dart';
import 'package:continue_parkingapp_flutter/blocs/vehicle_bloc.dart';
import 'package:continue_parkingapp_flutter/repositories/ParkingSpace_Repository.dart';
import 'package:continue_parkingapp_flutter/repositories/Vehicle_Repository.dart';
import 'package:continue_parkingapp_flutter/views/parking_view.dart';
import 'package:continue_parkingapp_flutter/views/vehicle_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'repositories/Parking_Repository.dart';

// ...



// Observer for debugging state changes
class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  Bloc.observer = SimpleBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ParkingBloc(repository: ParkingRepository())..add(parkingBloc.LoadParking() as parkingBloc.ParkingEvent),
        ),
        BlocProvider(
          create: (context) =>
              VehicleBloc(repository: VehicleRepository())..add(LoadVehicle()),
        ),
        BlocProvider(
          create: (context) => ParkingSpaceBloc(
              repository: ParkingSpaceRepository())..add(LoadParkingSpace() as ParkingSpaceEvent),
        ),
         BlocProvider(
      create: (context) => AuthBloc(),
      child: const MyApp(),
    ),
      ],
      child:const MyApp(),
    )
   
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
