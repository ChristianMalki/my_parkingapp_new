import 'package:continue_parkingapp_flutter/blocs/parking_bloc.dart' as parkingBloc;
import 'package:continue_parkingapp_flutter/blocs/parking_bloc.dart';

import 'package:continue_parkingapp_flutter/blocs/parkingspace_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:continue_parkingapp_flutter/blocs/auth_bloc.dart';
import 'package:continue_parkingapp_flutter/blocs/vehicle_bloc.dart';
import 'package:continue_parkingapp_flutter/repositories/ParkingSpace_Repository.dart';
import 'package:continue_parkingapp_flutter/repositories/Parking_Repository.dart';
import 'package:continue_parkingapp_flutter/repositories/Vehicle_Repository.dart';
import 'package:continue_parkingapp_flutter/views/parking_view.dart';
import 'package:continue_parkingapp_flutter/views/parkingspace_view.dart';
import 'package:continue_parkingapp_flutter/views/vehicle_view.dart';
import 'package:shared/shared.dart';

// Observer for debugging state changes
class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(
    BlocProvider(
      create: (context) => AuthBloc(),
      child: const MyApp(),
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
      homeWidget = const SignedInView();
    } else if (state is AuthSignedOut || state is AuthInitial) {
      homeWidget = const SignedOutView();
    } else if (state is AutFail) {
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

class SignedOutView extends StatelessWidget {
  const SignedOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthBloc>().add(AuthLogin(name: "Christian"));
          },
          child: const Text("Login"),
        ),
      ),
    );
  }
}

class SignedInView extends StatelessWidget {
  const SignedInView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ParkingBloc(repository: ParkingRepository())..add(parkingBloc.LoadParking()),
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
      child: const LandingPage(),
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
