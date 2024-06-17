import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab2/DataRepository.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => OtherPageState();
}


class OtherPageState extends State<ProfilePage>
{


  late TextEditingController _controllerFirstname; // late means initialize later, but not null
  late TextEditingController _controllerLastname;
  late TextEditingController _controllerPhone;
  late TextEditingController _controllerEmail;


  @override
  void initState() {
    super.initState();
    _controllerFirstname = TextEditingController();
    _controllerLastname = TextEditingController();
    _controllerPhone = TextEditingController();
    _controllerEmail = TextEditingController();

    loadInfoAsync();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Welcome Back' + DataRepository.loginName), duration: Duration(seconds: 30)),
    );

  }

  Future<void> loadInfoAsync() async{
    await DataRepository.loadProfileData();
    if (DataRepository.loginName != '') {
      _controllerFirstname.text = DataRepository.firstName;
      _controllerLastname.text = DataRepository.lastName;
      _controllerPhone.text = DataRepository.phoneNumber;
      _controllerEmail.text = DataRepository.emailAddress;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Welcome Back!'),
                duration: Duration(seconds: 30)));
      });

    }
  }

  @override
  void dispose() {
    _controllerFirstname.dispose();
    _controllerLastname.dispose();
    _controllerPhone.dispose();
    _controllerEmail.dispose();
    super.dispose();
    DataRepository.saveProfileData();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
      appBar:  AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                     title: Text('Profile Page')),
      body: Center(
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
             TextField(
                 controller:  _controllerFirstname,
          decoration: InputDecoration(
              hintText:"First Name",
              border: OutlineInputBorder())
             ),
             TextField(
                 controller:  _controllerLastname,
                 decoration: InputDecoration(
                 hintText:"Last Name",
                 border: OutlineInputBorder())
             ),
             Row(children: [
               Flexible(child: TextField(
                   controller:  _controllerPhone,
                    decoration: InputDecoration(
                        hintText:"Phone Number",
                        border: OutlineInputBorder())
                ),),
                ElevatedButton(child: Icon(Icons.phone),
                    onPressed: () {
                       //DataRepository.phoneNumber = _controllerPhone.value.text;
                      final Uri telUri = Uri(scheme: 'tel', path: _controllerPhone.value.text);
                       launchUrl(telUri);
                    } ),
                ElevatedButton(child: Icon(Icons.sms),
                    onPressed: () {
                      final Uri telUri = Uri(scheme: 'sms', path: _controllerPhone.value.text);
                      launchUrl(telUri);
                      //launch("sms:_controllerPhone.value.text");
                    } )
               ]),
             Row(children: [
               Flexible(child: TextField(
                   controller:  _controllerEmail,
                     decoration: InputDecoration(
                         hintText:"Email Address",
                         border: OutlineInputBorder())
                 ),),
                 ElevatedButton(child: Icon(Icons.email),
                     onPressed: () {
                       final Uri emailUri = Uri(scheme: 'sms', path: _controllerEmail.value.text);
                       launchUrl(emailUri);
                       //launch("mailto:_controllerEmail.value.text");
                     } )
  ],
  ),
            ElevatedButton( onPressed: _save,
                child: const Text("Save", style: TextStyle(fontSize: 30.0, color: Colors.blue) )

            )
]
  ),
  ));


}

  void _clearData () {
    DataRepository.clearProfileData();
    _controllerFirstname.text= '';
    _controllerLastname.text='';
    _controllerPhone.text='';
    _controllerEmail.text='';
    Navigator.pop(context);

  }

  void _save() {

    showDialog<String>(
      context: context,
      builder: (BuildContext ctx) =>
          AlertDialog(
            title: const Text('Save data'),
            content: const Text('Do you want to save your profile'),
            actions: <Widget>[
              ElevatedButton(child: Text("Yes"),
                onPressed: () {
                  DataRepository.firstName = _controllerFirstname.value.text; //
                  DataRepository.lastName = _controllerLastname.value.text; //
                  DataRepository.phoneNumber = _controllerPhone.value.text; //
                  DataRepository.emailAddress = _controllerEmail.value.text; //
                  DataRepository.saveProfileData();
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

