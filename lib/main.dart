//import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
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
  String _username='';
  String _password = '';
  String _imageSource = 'images/question-mark.png';


  @override
  void initState() {
    super.initState();

    _loginController = TextEditingController();
    _passwordController = TextEditingController();

    loadDataAsync();

  }

  Future<void> loadDataAsync() async{
    await DataRepository.loadLoginData();
    _loginController.text = DataRepository.loginName;
    _passwordController.text = DataRepository.loginPassword;

    // if (DataRepository.loginName != '' && DataRepository.loginPassword != '' ) {
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(
    //             content: Text(
    //                 'the previous login name and passwords have been loaded'),
    //             action: SnackBarAction(label: 'Clear saved data',
    //                 onPressed: () {
    //                   DataRepository.clearLoginData();
    //                   _loginController.text = '';
    //                   _passwordController.text = '';
    //                   Navigator.pop(context);
    //                 }),
    //             duration: Duration(seconds: 30)));
    //   });
    // }
  }


  void _login() async {
    _username=  _loginController.text;
    _password = _passwordController.text;

    //setState(() {
      _isPasswordVisible = true;
     //_passwordLabel = 'Password';
    //DataRepository.loginName=_loginController.text;
    //DataRepository.loginPassword=_passwordController.text;
    //DataRepository.saveLoginData();
    //loadDataAsync();

    if (_password != DataRepository.loginPassword||_username!=DataRepository.loginName){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Login Failed. User name is '+DataRepository.loginName+" and Password is "+DataRepository.loginPassword),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop(); // 关闭对话框
                },
              ),
            ],
          );
        },
      );
    }else{
      //Navigator.pushNamed(context, '/pageTwo');
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );

        if (result != null) {
          // 假设我们期望返回一个字符串
          //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Returned: $result")));
          loadDataAsync();
        }

    }
      //if (_password == DataRepository.loginPassword) {
       // DataRepository.loginName = _loginController.text;
        //DataRepository.loginPassword = _passwordController.text;
        //_imageSource = 'images/idea.png';
        //DataRepository.firstName  = _controller.value.text;
        // showDialog<String>(
        //   context: context,
        //   builder: (BuildContext ctx) =>
        //       AlertDialog(
        //         title: const Text('Save data'),
        //         content: const Text('Do you want to save your login'),
        //         actions: <Widget>[
        //           ElevatedButton(child: Text("Yes"),
        //             onPressed: () {
        //               DataRepository.loginName = _loginController.value.text; //
        //               DataRepository.loginPassword = _passwordController.value.text; //
        //               DataRepository.saveLoginData();
        //               Navigator.pop(context);
        //             }
        //             ,),
        //           FilledButton(child: Text("No"),
        //               onPressed: () {
        //                 DataRepository.clearLoginData();
        //                 _loginController.text = '';
        //                 _passwordController.text = '';
        //                 Navigator.pop(context);
        //
        //               }),
        //
        //         ],
        //       ),
        // );

       /* ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Welcome Back ${_loginController.text}'), duration: Duration(seconds: 30)),
        );*/
      //}
      //else {
        //_imageSource = 'images/stop.png';
      //}
    }
    //);


 // }




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
                      hintText: "UserName",
                      border: OutlineInputBorder(),
                      labelText:"UserName",
                      labelStyle: TextStyle(fontSize: 30.0),
                  )),
              SizedBox(height: 20.0),
              TextField(controller: _passwordController,
                decoration: InputDecoration(
                     hintText: "Password",
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 30.0),
                ),
                obscureText: !_isPasswordVisible,

              ),
              SizedBox(height: 20.0),
              ElevatedButton(onPressed: _login,
                  child: const Text("Login",
                      style: TextStyle(fontSize: 30.0, color: Colors.blue))

              ),
              // ElevatedButton(onPressed: _login,
              //     child: Image.asset(_imageSource, width: 300, height: 300))

            ],
          ),
        ),
      );
    }
    }
