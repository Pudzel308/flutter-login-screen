import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IT126-Practical-Activity-Janiola',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
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

  String firstName = '';
  String lastName = '';
  String emailAdd = '';
  String newPass = '';
  String confPass = '';

  final f_name = TextEditingController();
  final last_name = TextEditingController();
  final email = TextEditingController();
  final n_password = TextEditingController();
  final conf_pass = TextEditingController();

  final fnameF = FocusNode();
  final lnameF = FocusNode();
  final emailF = FocusNode();
  final npassF = FocusNode();
  final confPassF = FocusNode();

  void _submit() {
    if (f_name.text.trim().isEmpty || last_name.text.trim().isEmpty || email.text.trim().isEmpty || n_password.text.trim().isEmpty || conf_pass.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Cannot Proceed.'),
            content: Text('Please fill out the fields!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    } else if (n_password.text != conf_pass.text) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Password Mismatch!'),
            content: Text('Please enter matching keywords.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        firstName = f_name.text;
        lastName = last_name.text;
        emailAdd = email.text;
        newPass = n_password.text;
        confPass = conf_pass.text;
      });
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('User registered successfully'),
            content: Text("Logged in as:\n\n" + firstName + " " + lastName + "\n" + emailAdd),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _clear();
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    }
  }

  void _clear() {
    f_name.clear();
    last_name.clear();
    email.clear();
    n_password.clear();
    conf_pass.clear();
  }

  @override
  void dispose() {
    f_name.dispose();
    last_name.dispose();
    email.dispose();
    n_password.dispose();
    conf_pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Fullname: " + firstName + " " + lastName),
                Text("Email: " + emailAdd),
              ],
            ),
            Divider(),
            SizedBox(height: 56),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextField(
                    focusNode: fnameF,
                    textInputAction: TextInputAction.next,
                    controller: f_name,
                    onSubmitted: (_) {
                      lnameF.requestFocus();
                    },
                    decoration: InputDecoration(
                      labelText: 'First name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 24),
                Expanded(
                  child: TextField(
                    focusNode: lnameF,
                    textInputAction: TextInputAction.next,
                    controller: last_name,
                    onSubmitted: (_) {
                      emailF.requestFocus();
                    },
                    decoration: InputDecoration(
                      labelText: 'Last name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              focusNode: emailF,
              controller: email,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) {
                npassF.requestFocus();
              },
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              focusNode: npassF,
              controller: n_password,
              textInputAction: TextInputAction.next,
              obscureText: true,
              onSubmitted: (_) {
                confPassF.requestFocus();
              },
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: conf_pass,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 56),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: _clear,
                  child: const Text('Clear'),
                ),
                FilledButton(
                  onPressed: _submit,
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
