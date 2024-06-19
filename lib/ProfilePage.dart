import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab2/DataRepository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => OtherPageState();
}

class OtherPageState extends State<ProfilePage> {
  late TextEditingController _controllerFirstname; // late means initialize later, but not null
  late TextEditingController _controllerLastname;
  late TextEditingController _controllerPhone;
  late TextEditingController _controllerEmail;
  //late TextEditingController _controllerLoginName;
  //late TextEditingController _controllerLoginPassword;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controllerFirstname = TextEditingController();
    _controllerLastname = TextEditingController();
    _controllerPhone = TextEditingController();
    _controllerEmail = TextEditingController();
    //_controllerLoginName = TextEditingController();
    //_controllerLoginPassword = TextEditingController();

    loadInfoAsync();
  }

  Future<void> loadInfoAsync() async {
    await DataRepository.loadProfileData();
    //await DataRepository.loadLoginData();
    if (DataRepository.loginName != '') {
      _controllerFirstname.text = DataRepository.firstName;
      _controllerLastname.text = DataRepository.lastName;
      _controllerPhone.text = DataRepository.phoneNumber;
      _controllerEmail.text = DataRepository.emailAddress;
      //_controllerLoginName.text = DataRepository.loginName;
      //_controllerLoginPassword.text = DataRepository.loginPassword;
      //_startTimer();
      _showSnackbar();
    }
  }

  // void _startTimer() {
  //   _timer = Timer.periodic(Duration(seconds: 2), (timer) {
  //     _showSnackbar();
  //   });
  // }

  void _showSnackbar() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Welcome Back! ' + DataRepository.loginName),
          duration: Duration(seconds: 30)));
    });
  }

  @override
  void dispose() {
    _controllerFirstname.dispose();
    _controllerLastname.dispose();
    _controllerPhone.dispose();
    _controllerEmail.dispose();
    //_controllerLoginName.dispose();
    //_controllerLoginPassword.dispose();
    //timer?.cancel();
    super.dispose();
    //DataRepository.saveProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text('Profile Page')),
        body: Center(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // TextField(
                //     controller: _controllerLoginName,
                //     decoration: InputDecoration(
                //         hintText: "LoginName",
                //         labelText:"LoginName",
                //         border: OutlineInputBorder())),
                // TextField(
                //     controller: _controllerLoginPassword,
                //     decoration: InputDecoration(
                //         hintText: "Password",
                //         labelText:"Password",
                //         border: OutlineInputBorder())),
                SizedBox(height: 20.0),
                TextField(
                    controller: _controllerFirstname,
                    decoration: InputDecoration(
                        hintText: "First Name",
                        labelText:"First Name",
                        border: OutlineInputBorder())),
                SizedBox(height: 20.0),
                TextField(
                    controller: _controllerLastname,
                    decoration: InputDecoration(
                        hintText: "Last Name",
                        labelText:"Last Name",
                        border: OutlineInputBorder())),
                SizedBox(height: 20.0),
                Row(children: [
                  Flexible(
                    child: TextField(
                        controller: _controllerPhone,
                        decoration: InputDecoration(
                            hintText: "Phone Number",
                            labelText:"Phone Number",
                            border: OutlineInputBorder())),
                  ),
                  ElevatedButton(
                      child: Icon(Icons.phone),
                      onPressed: () {
                        //DataRepository.phoneNumber = _controllerPhone.value.text;
                        final Uri telUri = Uri(
                            scheme: 'tel', path: _controllerPhone.value.text);
                        launchUrl(telUri);
                      }),
                  ElevatedButton(
                      child: Icon(Icons.sms),
                      onPressed: () {
                        final Uri telUri = Uri(
                            scheme: 'sms', path: _controllerPhone.value.text);
                        launchUrl(telUri);
                        //launch("sms:_controllerPhone.value.text");
                      })
                ]),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                          controller: _controllerEmail,
                          decoration: InputDecoration(
                              hintText: "Email Address",
                              labelText:"Email Address",
                              border: OutlineInputBorder())),
                    ),
                    ElevatedButton(
                        child: Icon(Icons.email),
                        onPressed: () {
                          final Uri emailUri = Uri(
                              scheme: 'mailto',
                              path: _controllerEmail.value.text,
                              queryParameters: {
                                'subject': 'Example Subject',
                                'body': 'Good Morning!',
                              });
                          launchUrl(emailUri);
                          //launch("mailto:_controllerEmail.value.text");
                        })
                  ],
                ),
                SizedBox(height: 30.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    ElevatedButton(
                        onPressed: _save,
                        child: const Text("Save",
                            style: TextStyle(fontSize: 30.0, color: Colors.blue))),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _clear,
                        child: const Text("Clear",
                            style: TextStyle(fontSize: 30.0, color: Colors.red)))
                    ]),]
                )

        ));
  }

  void _clear() {
    showDialog<String>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('Clear data'),
        content: const Text('Do you want to clear your info?'),
        actions: <Widget>[
          ElevatedButton(
            child: Text("Yes"),
            onPressed: () {
              DataRepository.clearProfileData();
              _controllerFirstname.text = '';
              _controllerLastname.text = '';
              _controllerPhone.text = '';
              _controllerEmail.text = '';
              //_controllerLoginName.text='';
              //_controllerLoginPassword.text='';
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text("No"),
            onPressed: () => Navigator.pop(context), // 正确使用 Navigator.pop
          ),
        ],
      ),
    );
  }


  void _save()  {
    // if(_controllerLoginName.value.text.trim()==""){
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Alert'),
    //         content: Text('LoginName is Required!'),
    //         actions: <Widget>[
    //           TextButton(
    //             child: Text('Close'),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    //   return;
    // }
    //
    // if(_controllerLoginPassword.value.text.trim()==""){
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Alert'),
    //         content: Text('LoginPassword is Required!'),
    //         actions: <Widget>[
    //           TextButton(
    //             child: Text('Close'),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    //   return;
    // }

    DataRepository.firstName =_controllerFirstname.value.text;
    DataRepository.lastName =_controllerLastname.value.text;
    DataRepository.phoneNumber =_controllerPhone.value.text;
    DataRepository.emailAddress =_controllerEmail.value.text;
    //DataRepository.loginName =_controllerLoginName.value.text;
    //DataRepository.loginPassword =_controllerLoginPassword.value.text;
    DataRepository.saveProfileData();
    //DataRepository.saveLoginData();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Message'),
          content: Text('Save Successfully!'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context, "From ProfilePage");
              },
            ),
          ],
        );
      },
    );

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //       content: Text('Save Successfully!'),
    //       duration: Duration(seconds: 5)),
    // );
    // showDialog<String>(
    //   context: context,
    //   builder: (BuildContext ctx) =>
    //       AlertDialog(
    //         title: const Text('Save data'),
    //         content: const Text('Do you want to save your profile'),
    //         actions: <Widget>[
    //           ElevatedButton(child: Text("Yes"),
    //             onPressed: () {
    //               DataRepository.firstName = _controllerFirstname.value.text; //
    //               DataRepository.lastName = _controllerLastname.value.text; //
    //               DataRepository.phoneNumber = _controllerPhone.value.text; //
    //               DataRepository.emailAddress = _controllerEmail.value.text; //
    //               DataRepository.saveProfileData();
    //               Navigator.pop(context);
    //             }
    //             ,),
    //           FilledButton(child: Text("No"),
    //               onPressed: _clearData),
    //
    //         ],
    //       ),
    // );
  }
}
