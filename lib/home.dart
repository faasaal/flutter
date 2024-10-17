import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'login.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () => _confirmSignOut(context),
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: ListView(
        children: const [
          CarTile(carName: 'Indica', color: Colors.grey),
          CarTile(carName: 'Polo', color: Color.fromARGB(255, 26, 117, 43)),
          CarTile(carName: 'Zen', color: Color.fromARGB(255, 158, 158, 158)),
          CarTile(carName: 'Rolls Royce', color: Color.fromARGB(255, 220, 47, 47)),
          CarTile(carName: 'Lamborghini', color: Colors.blue),
          CarTile(carName: 'Porsche', color: Colors.yellow),
          CarTile(carName: 'Skoda', color: Colors.grey),
          CarTile(carName: 'Benz', color: Colors.grey),
          CarTile(carName: 'BMW', color: Colors.grey),
          CarTile(carName: 'Alto', color: Colors.grey),
        ],
      ),
    );
  }

  void _confirmSignOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                signOut(context); // Call the sign-out function
              },
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }
}

class CarTile extends StatelessWidget {
  final String carName;
  final Color color;

  const CarTile({Key? key, required this.carName, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: color,
      contentPadding: const EdgeInsets.all(6),
      leading: const Icon(Icons.car_repair),
      title: Text(carName),
    );
  }
}

void signOut(BuildContext ctx) {
  // Clear user data from Hive if necessary
  Hive.box('userBox').clear(); // Optional: clear the user data
  Navigator.of(ctx).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => const ScreenLogin()),
    (route) => false,
  );
}
