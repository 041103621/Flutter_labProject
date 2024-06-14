//import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'ProfilePage.dart';
import 'DataRepository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        //Keys:         //values
        '/pageOne'   :   (context) => MyHomePage(title: 'Flutter Lab'),
        '/pageTwo'  :    (context) { return ProfilePage(); }

      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute : '/pageOne'  ,
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
  var isChecked = false;
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  bool _isPasswordVisible = false;
  String _password = '';
  String? _passwordLabel;
  String _imageSource = 'images/question-mark.png';
 //late EncryptedSharedPreferences savedData;

  void _login() {
    _password = _passwordController.text;

    setState(() {
      _isPasswordVisible = true;
      _passwordLabel = 'Password';

      if (_password == 'siqian123') {
        //_imageSource = 'images/idea.png';
        //DataRepository.firstName  = _controller.value.text;
        Navigator.pushNamed(context, '/pageTwo');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Welcome Back ${_loginController.text}'), duration: Duration(seconds: 30)),
        );
      }
      else {
        _imageSource = 'images/stop.png';
      }
    });
/*
    showDialog<String>(
      context: context,
      builder: (BuildContext ctx) =>
          AlertDialog(
            title: const Text('Save data'),
            content: const Text('Do you want to save your login'),
            actions: <Widget>[
              ElevatedButton(child: Text("Yes"),
                onPressed: () {
                  DataRepository.loginName = _loginController.value.text; //
                  DataRepository.loginPassword = _passwordController.value.text; //
                  DataRepository.saveLoginData();
                  Navigator.pop(context);
                }
                ,),
              FilledButton(child: Text("No"),
                  onPressed: () {
                    DataRepository.clearLoginData();
                    _loginController.text = '';
                    _passwordController.text = '';
                    Navigator.pop(context);

                  }),

            ],
          ),
    );*/
  }

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
    DataRepository.loadLoginData();

    //savedData = EncryptedSharedPreferences(); //constructor is not asynchronous
    //savedData.getString("loginName").then((unencryptedString) {
      if (DataRepository.loginName != '' && DataRepository.loginPassword != '' ) {
        _loginController.text = DataRepository.loginName;
        _passwordController.text = DataRepository.loginPassword;

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'the previous login name and passwords have been loaded'),
                action: SnackBarAction(label: 'Clear saved data',
                    onPressed: () {
                      DataRepository.clearLoginData();
                      _loginController.text = '';
                      _passwordController.text = '';
                      Navigator.pop(context);
                    }),
                duration: Duration(seconds: 30)));
      }
}


    @override
    void dispose() {
      _loginController.dispose();
      _passwordController.dispose();
      super.dispose();
      DataRepository.saveLoginData();
    }


    @override
    Widget build(BuildContext context) {
      //var widget;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(controller: _loginController,
                  decoration: const InputDecoration(
                      hintText: "Login",
                      border: OutlineInputBorder()
                  )),
              TextField(controller: _passwordController,
                decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(),
                    labelText: _passwordLabel
                ),
                obscureText: !_isPasswordVisible,

              ),


              ElevatedButton(onPressed: _login,
                  child: const Text("Login",
                      style: TextStyle(fontSize: 30.0, color: Colors.blue))

              ),
              ElevatedButton(onPressed: _login,
                  child: Image.asset(_imageSource, width: 300, height: 300))

            ],
          ),
        ),
      );
    }
    }
