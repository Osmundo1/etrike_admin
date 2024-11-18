import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../methods/common_methods.dart';
import '../widgets/loading_dialog.dart';


class RegisterDriverForm extends StatefulWidget {
  @override
  _RegisterDriverFormState createState() => _RegisterDriverFormState();
}

class _RegisterDriverFormState extends State<RegisterDriverForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController carColorController = TextEditingController();
  final TextEditingController carNumberController = TextEditingController();

  final CommonMethods cMethods = CommonMethods();

  void registerNewDriver() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => LoadingDialog(messageText: "Registering your account..."),
    );

    final User? userFirebase = (
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ).catchError((errorMsg) {
          Navigator.pop(context);
          cMethods.displaySnackBar(errorMsg.toString(), context);
        })
    ).user;

    if (!context.mounted) return;
    Navigator.pop(context);

    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("drivers").child(userFirebase!.uid);

    Map driverCarInfo = {
      "carColor": carColorController.text.trim(),
      "carModel": carModelController.text.trim(),
      "carNumber": carNumberController.text.trim(),
    };

    Map driverDataMap = {
      "photo": "https://firebasestorage.googleapis.com/v0/b/etrikev2.appspot.com/o/Images%2F1719554726871?alt=media&token=08461bf2-9266-47d4-a1e3-ef1c9723629a", // Add logic to handle photo upload if needed
      "car_details": driverCarInfo,
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "phone": phoneController.text.trim(),
      "id": userFirebase.uid,
      "blockStatus": "no",
    };
    usersRef.set(driverDataMap);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Register New Driver'),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.6, // 60% of the screen width
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
              TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
              TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
              TextField(controller: phoneController, decoration: InputDecoration(labelText: 'Phone')),
              TextField(controller: carModelController, decoration: InputDecoration(labelText: 'Tricycle Model')),
              TextField(controller: carColorController, decoration: InputDecoration(labelText: 'Tricycle Color')),
              TextField(controller: carNumberController, decoration: InputDecoration(labelText: 'Tricycle Number')),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF142D53),
          ),
          child: const Text('Cancel',style: TextStyle(color: Colors.white),),
        ),
        ElevatedButton(
          onPressed: registerNewDriver,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF142D53),
          ),
          child: const Text('Register',style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }
}
