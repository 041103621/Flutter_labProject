import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      home: const MyHomePage(title: 'Lab3'),
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
  int _counter = 0;
  var isChecked = false;
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  bool _isPasswordVisible = false;
  String _password = '';
  String? _passwordLabel;
  String _imageSource = 'images/question-mark.png';
  late EncryptedSharedPreferences savedData;

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();

    savedData = EncryptedSharedPreferences(); //constructor is not asynchronous
    savedData.getString("loginName").then( (unencryptedString)  {
      if(unencryptedString != null){
        _loginController.text = unencryptedString;
      }
    });

    savedData.getString("loginPassword").then( (unencryptedString)  {
      if(unencryptedString != null){
        _passwordController.text = unencryptedString;

        //show Snackbar here

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('the previous login name and passwords have been loaded'),
                action: SnackBarAction( label:'Clear saved data',
                    onPressed: () {
                  savedData.remove("loginName");

                      savedData.remove("loginPassword");
                      _loginController.text= '';
                      _passwordController.text='';


                } ),
                duration: Duration(seconds: 30)));

      }
    });

  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void functionName() async {
    final prefs = await SharedPreferences.getInstance();
  }

  void _clearData () {
    savedData.remove("loginName");
    savedData.remove("loginPassword");
    _loginController.text= '';
    _passwordController.text='';
    Navigator.pop(context);

  }



  @override
  Widget build(BuildContext context) {
    //var widget;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(controller:  _loginController,
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

            ),


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

  showDialog<String>(
    context: context,
    builder: (BuildContext ctx) =>
        AlertDialog(
          title: const Text('Save data'),
          content: const Text('Do you want to save your login'),
          actions: <Widget>[
            ElevatedButton(child: Text("Yes"),
              onPressed: () {
                var nameTyped = _loginController.value.text; //
                var passwordTyped = _passwordController.value.text; //

                //savedData is EncryptedSharedPreferences
                savedData.setString("loginName", nameTyped); //variable name
                savedData.setString("loginPassword", passwordTyped); //variable name
                Navigator.pop(context);
              }
              ,),
            FilledButton(child: Text("No"),
                onPressed: _clearData),

          ],
        ),
  );


}

}

