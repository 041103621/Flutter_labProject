import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  bool _isPasswordVisible = false;
  String _password = '';
  String? _passwordLabel;
  String _imageSource = 'images/question-mark.png';

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    _password = _passwordController.text;

    setState(() {
      _isPasswordVisible = true;
      _passwordLabel = 'Password';

      if (_password == 'QWERTY123') {
        _imageSource = 'images/idea.png';
      }
      else {
        _imageSource = 'images/stop.png';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(controller: _loginController,
                decoration: const InputDecoration(
                    hintText:"Login",
                    border: OutlineInputBorder()
                )),
            TextField(controller: _passwordController,
                decoration:  InputDecoration(
                    hintText:"Password",
                    border: OutlineInputBorder(),
                  labelText: _passwordLabel
                ),
                obscureText: !_isPasswordVisible,
    /*onChanged: (value) {
                if (_isPasswordVisible) {
                    setState(() {
                      _password = value;
                    });
                  }
                }*/),


            ElevatedButton( onPressed: _login,
                child: const Text("Login", style: TextStyle(fontSize: 30.0, color: Colors.blue) )

            ),
            ElevatedButton( onPressed: _login,
            child:Image.asset(_imageSource, width: 300, height:300))

          ],
        ),
      ),
    );
  }
}
