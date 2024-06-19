

//responsible for loading and saving itself
import 'dart:async';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class DataRepository{

  static String loginName = ""; //initially it's empty string
  static String loginPassword = "";
  static String firstName = "";
  static String lastName = "";
  static String phoneNumber = "";
  static String emailAddress = "";
  static late EncryptedSharedPreferences prefs;

  static Future<void> loadLoginData() async
  {
    //load your variables here
    prefs = EncryptedSharedPreferences();
    loginName=await prefs.getString("loginName");
    loginPassword=await prefs.getString("loginPassword") ;
  }

  static Future<void> loadProfileData() async
  {
    firstName=await prefs.getString("firstName");
    lastName=await prefs.getString("lastName");
    phoneNumber=await prefs.getString("phoneNumber");
    emailAddress=await prefs.getString("emailAddress");
  }


  static Future<void> saveLoginData() async
  {
    //save your variables
    if(loginName!=null&&loginPassword!=null) {
      await prefs.setString("loginName", loginName);
      await prefs.setString("loginPassword", loginPassword);
    }else{

    }
  }

  static Future<void> saveProfileData() async
  {
    //save your variables
    if(firstName!=""){
      await prefs.setString("firstName", firstName);
    }else{
      await prefs.remove("firstName");
    }

    if(lastName!=""){
      await prefs.setString("lastName", firstName);
    }else{
      await prefs.remove("lastName");
    }

    if(phoneNumber!=""){
      await prefs.setString("phoneNumber", firstName);
    }else{
      await prefs.remove("phoneNumber");
    }

    if(emailAddress!=""){
      await prefs.setString("emailAddress", firstName);
    }else{
      await prefs.remove("emailAddress");
    }

    if(loginName!=""){
      await prefs.setString("loginName", loginName);
    }

    if(loginPassword!=""){
      await prefs.setString("loginPassword", loginPassword);
    }
  }

  // static Future<void> clearLoginData() async
  // {
  //   //var prefs = EncryptedSharedPreferences();
  //   await prefs.remove("loginName");
  //   await prefs.remove("loginPassword");
  // }
  //
  // static Future<void> clearProfileData() async
  // {
  //   //var prefs = EncryptedSharedPreferences();
  //   await prefs.remove("firstName");
  //   await prefs.remove("lastName");
  //   await prefs.remove("phoneNumber");
  //   await prefs.remove("emailAddress");
  // }

}